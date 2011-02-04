/* 
 * Modular For Max
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "ModularForMax.h"


/***********************************************************************************
*
*		C EXTERN METHODS
*
************************************************************************************/

// Method to deal with the jamoma application
/////////////////////////////////////////

TTErr jamoma_application_dump_configuration(void)
{
	TTUInt16 i;
	TTValue v, appNames;
	TTSymbolPtr anAppKey;
	TTValue toConvert;
	TTString aTTStr;
	
	post("--- Jamoma Application : Symbol Convertion ---");
	JamomaApplication->getAttributeValue(TT("allAppNames"), appNames);
	
	for (i=0; i<appNames.getSize(); i++) {
		
		appNames.get(i, &anAppKey);
		
		toConvert = TTValue(anAppKey);
		JamomaApplication->sendMessage(kTTSym_ConvertToTTName, toConvert); 
		toConvert.toString();
		toConvert.get(0, aTTStr);
		post("%s <-> %s", anAppKey->getCString(), aTTStr.data());
	}
	
	post("----------------------------------------------");
	
	return kTTErrNone;
}

TTErr jamoma_application_write_configuration(void)
{
	// Read xml configuration file
	TTValue			v;
	TTXmlHandlerPtr anXmlHandler = NULL;
	
	TTObjectInstantiate(TT("XmlHandler"), TTObjectHandle(&anXmlHandler), v);
	
	v = TTValue(TTPtr(JamomaApplication));
	anXmlHandler->setAttributeValue(kTTSym_object, v);
	
	v = TTValue(TT(JamomaConfigurationFilePath));
	return anXmlHandler->sendMessage(TT("Write"), v);
}

// Method to deal with the jamoma directory
/////////////////////////////////////////

TTErr jamoma_directory_dump_observers(void)
{
	unsigned int i, j, s;
	TTValue v;
	TTValuePtr pv;
	TTSymbolPtr key, owner;
	
	post("--- JamomaDirectory Observers ---");
	JamomaDirectory->dumpObservers(v);
	
	s = v.getSize();
	for (i=0; i<s; i++) {
		
		v.get(i,(TTPtr*)&pv);
		pv->get(0, &key);
		post("%s :", key->getCString());
		
		for (j=1; j<pv->getSize(); j++) {
		
			pv->get(j, &owner);
			post("    %s", owner->getCString());
		}
	}
	
	post("----------------------------------------------");
	
	return kTTErrNone;
}

// Method to deal with TTSubscriber
///////////////////////////////////////////////////////////////////////

TTErr jamoma_subscriber_create(ObjectPtr x, TTObjectPtr aTTObject, SymbolPtr relativeAddress, TTSymbolPtr contextType, TTSubscriberPtr *returnedSubscriber)
{
	TTValue			args;
	TTObjectPtr		shareCallback, contextListCallback;
	TTValuePtr		shareBaton, contextListBaton;
		
	// prepare arguments
	args.append(TTPtr(aTTObject));
	args.append(TT(relativeAddress->s_name));
	args.append(JamomaApplication);
	
	shareCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &shareCallback, kTTValNONE);
	shareBaton = new TTValue(TTPtr(x));
	shareCallback->setAttributeValue(kTTSym_baton, TTPtr(shareBaton));
	shareCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_subscriber_share_context_node));
	args.append(shareCallback);
	
	contextListCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &contextListCallback, kTTValNONE);
	contextListBaton = new TTValue(TTPtr(x));
	contextListBaton->append(contextType);
	contextListCallback->setAttributeValue(kTTSym_baton, TTPtr(contextListBaton));
	contextListCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_subscriber_get_context_list));
	args.append(contextListCallback);
	
	*returnedSubscriber = NULL;
	TTObjectInstantiate(TT("Subscriber"), TTObjectHandle(returnedSubscriber), args);
	
	return kTTErrNone;
}

void jamoma_subscriber_share_context_node(TTPtr p_baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	ObjectPtr	contextPatcher, obj;
	TTNodePtr	returnedContextNode;
	TTBoolean	subscriberExist = false;
	SymbolPtr	objclass = NULL, _sym_jcomhub, _sym_jcomparam, _sym_jcommessage, _sym_jcomreturn, _sym_share;
	
	// unpack baton
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	
	// look for any other registered jcom. in the patcher
	// to ask them the model node using their "share_model_node" method. 
	// this would optimized the registration process.
	returnedContextNode = NULL;
	contextPatcher = jamoma_patcher_get(x);
	obj = object_attr_getobj(contextPatcher, _sym_firstobject);
	
	// TODO : cache those t_symbol else where ...
	_sym_jcomhub = gensym("jcom.hub");
	_sym_jcomparam = gensym("jcom.parameter");
	_sym_jcommessage = gensym("jcom.message");
	_sym_jcomreturn = gensym("jcom.return");
	_sym_share = gensym("share_context_node");
	while (obj) {
		objclass = object_attr_getsym(obj, _sym_maxclass);
		if (objclass == _sym_jcomhub || 
			objclass == _sym_jcomparam || 
			objclass == _sym_jcommessage || 
			objclass == _sym_jcomreturn) {
			
			// subscriber exist
			subscriberExist = true;
			
			// ask it the contextNode
			object_method(object_attr_getobj(obj, _sym_object), _sym_share, &returnedContextNode);
			
			if (returnedContextNode)
				break;
		}
		obj = object_attr_getobj(obj, _sym_nextobject);
	}
	
	if (subscriberExist)
		data = TTValue((TTPtr)returnedContextNode);
	else
		data = kTTValNONE; 
	
}

void jamoma_subscriber_get_context_list(TTPtr p_baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	TTListPtr	aContextList;
	TTSymbolPtr	aContextType;
	long		nbLevel = 0;
	
	// unpack baton
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	b->get(1, &aContextType);
	
	// unpack data to get a TTListPtr
	data.get(0, (TTPtr*)&aContextList);
	
	// Get all context name (model or view name) above the jcom
	// looking recursively at all parent patcher.
	jamoma_subscriber_get_context_list_method(x, aContextType, aContextList, &nbLevel);
}

void jamoma_subscriber_get_context_list_method(ObjectPtr z, TTSymbolPtr contextType, TTListPtr aContextList, long *nbLevel)
{
	ObjectPtr		patcher, box;
	TTSymbolPtr		patcherContext, patcherClass;
	AtomCount		ac = 0;
	AtomPtr			av = NULL;
	SymbolPtr		hierarchy;
	SymbolPtr		contextName = _sym_nothing;
	TTString		viewName;
	TTValuePtr		v;
	
	patcher = jamoma_patcher_get(z);
	hierarchy = jamoma_patcher_get_hierarchy(patcher);
	jamoma_patcher_get_context(patcher, &patcherContext);
	jamoma_patcher_get_class(patcher, patcherContext, &patcherClass);
	
	// case where the object is embedded in a contexted patcher
	if ((patcherContext != kTTSym_none) && ((hierarchy == _sym_bpatcher) || (hierarchy == _sym_subpatcher)) ) {
		
		// go upper to fill the list beginning by the top level context
		(*nbLevel)++;
		jamoma_subscriber_get_context_list_method(patcher, contextType, aContextList, nbLevel);
		
		// try to get context name from the patcher arguments
		jamoma_patcher_get_args(patcher, &ac, &av);
		if ((hierarchy == _sym_subpatcher) && (ac >= 2))
			contextName = atom_getsym(av+1);
		
		// For bpatcher of view patcher, we expect it as the second argument (the first is reserved for the /model/address)
		else if (patcherContext == kTTSym_view && (hierarchy == _sym_bpatcher) && (ac >= 2)) 
			contextName = atom_getsym(av+1);
		
		// For bpatcher of model patcher, we expect it as the first argument
		else if (patcherContext == kTTSym_model && (hierarchy == _sym_bpatcher) && ac)
			contextName = atom_getsym(av);
		
		// Try to get context name from the patcher scripting name
		else {
			box = object_attr_getobj(patcher, _sym_box);
			contextName = object_attr_getsym(box, _sym_varname);
			if (!contextName)
				contextName = _sym_nothing;
		}
		
		// If the context name is still nothing
		// get it from the patcher name if it contains the contextType
		if (contextName == _sym_nothing) {
			
			// for view patcher :
			// add "(view") to the patcher class in order to create 
			// a different address than the default model name.
			if (patcherContext == kTTSym_view) {
				viewName = patcherClass->getCString();
				viewName += "(view)";
				contextName = gensym(viewName.data());
			}
			else
				contextName = gensym((char*)patcherClass->getCString());
		}
		
		// add the < contextName, patcher > to the contextList
		v = new TTValue(TT(contextName->s_name));
		v->append((TTPtr)patcher);
		aContextList->append(v);
		
		if (av)
			sysmem_freeptr(av);
	}
	
	// case where the object is in none contexted patcher
	else if (patcherContext == kTTSym_none && ((hierarchy == _sym_bpatcher) || (hierarchy == _sym_subpatcher))) {
		// ignore this level
		jamoma_subscriber_get_context_list_method(patcher, contextType, aContextList, nbLevel);
	}
	
	// case where the user is editing the patcher
	else if ((hierarchy == _sym_topmost) && (*nbLevel == 0)) {
		
		// add the < patcherClass, patcher > to the contextList
		if (patcherContext != kTTSym_none)
			v = new TTValue(patcherClass);
		else
			v = new TTValue(TT(object_attr_getsym(patcher, _sym_name)->s_name));
		
		v->append((TTPtr)patcher);
		aContextList->append(v);
	}
	else {
			// add the < /, patcher > to the contextList
			v = new TTValue(S_SEPARATOR);
			v->append((TTPtr)patcher);
			aContextList->append(v);
	}
}

// Method to deal with TTContainer
///////////////////////////////////////////////////////////////////////

/**	Create a container object */
TTErr jamoma_container_create(ObjectPtr x, TTObjectPtr *returnedContainer)
{
	TTValue			args;
	TTObjectPtr		returnAddressCallback, returnValueCallback;
	TTValuePtr		returnAddressBaton, returnValueBaton;
	
	// prepare arguments
	
	args.append(JamomaApplication);
	
	returnAddressCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnAddressCallback, kTTValNONE);
	returnAddressBaton = new TTValue(TTPtr(x));
	returnAddressCallback->setAttributeValue(kTTSym_baton, TTPtr(returnAddressBaton));
	returnAddressCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_address));
	args.append(returnAddressCallback);
	
	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	returnValueBaton = new TTValue(TTPtr(x));
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(returnValueCallback);
	
	*returnedContainer = NULL;
	TTObjectInstantiate(TT("Container"), TTObjectHandle(returnedContainer), args);
	
	return kTTErrNone;
}

/**	Send Max data using a container object */
TTErr jamoma_container_send(TTContainerPtr aContainer, SymbolPtr relativeAddressAndAttribute, AtomCount argc, AtomPtr argv)
{
	TTSymbolPtr	oscAddress, attrOrMess;
	TTValue		v, data;
	
	if (aContainer) {
		
		// Get address part and attribute part
		splitAttribute(TT(relativeAddressAndAttribute->s_name), &oscAddress, &attrOrMess);
		
		data.append(oscAddress);
		
		if (attrOrMess != NO_ATTRIBUTE)
			data.append(attrOrMess);
		else
			data.append(kTTSym_value);
		
		jamoma_ttvalue_from_Atom(v, _sym_nothing, argc, argv);
		data.append((TTPtr)&v);
		
		return aContainer->sendMessage(kTTSym_Send, data); // data is [address, attribute, [x, x, ,x , ...]]
	}
	
	return kTTErrGeneric;
}

// Method to deal with TTData
///////////////////////////////////////////////////////////////////////

/**	Create a data object */
TTErr jamoma_data_create(ObjectPtr x, TTObjectPtr *returnedData, TTSymbolPtr service)
{
	TTValue			args;
	TTObjectPtr		returnValueCallback;
	TTValuePtr		returnValueBaton;
	
	// prepare arguments

	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	returnValueBaton = new TTValue(TTPtr(x));
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(returnValueCallback);
	
	args.append(service);
	
	*returnedData = NULL;
	TTObjectInstantiate(TT("Data"), TTObjectHandle(returnedData), args);
	
	return kTTErrNone;
}

/**	Send Max data command */
TTErr jamoma_data_command(TTDataPtr aData, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	TTValue		v;
	
	if (aData) {
		
		jamoma_ttvalue_from_Atom(v, msg, argc, argv);
		
		aData->sendMessage(kTTSym_Command, v);
		return kTTErrNone;
	}
	
	return kTTErrGeneric;
}

// Method to deal with TTSender
///////////////////////////////////////////////////////////////////////

/**	Create a sender object */
TTErr jamoma_sender_create(ObjectPtr x, SymbolPtr addressAndAttribute, TTObjectPtr *returnedSender)
{
	TTSymbolPtr	oscAddress, attribute;
	TTValue		args;
	
	// Get address part and attribute part
	splitAttribute(TT(addressAndAttribute->s_name), &oscAddress, &attribute);
	
	// Make a TTReceiver object
	args.append(JamomaApplication);
	args.append(oscAddress);
	
	if (attribute != NO_ATTRIBUTE)
		args.append(attribute);
	else
		args.append(kTTSym_value);
	
	// Replace none TTnames
	JamomaApplication->sendMessage(kTTSym_ConvertToTTName, args);
	
	*returnedSender = NULL;
	TTObjectInstantiate(TT("Sender"), TTObjectHandle(returnedSender), args);
	return kTTErrNone;
}

/**	Send Max data using a sender object */
TTErr jamoma_sender_send(TTSenderPtr aSender, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	TTValue		v;
	
	if (aSender) {
		
		jamoma_ttvalue_from_Atom(v, msg, argc, argv);
		
		return aSender->sendMessage(kTTSym_Send, v);
	}
	
	return kTTErrGeneric;
}

// Method to deal with TTReceiver
///////////////////////////////////////////////////////////////////////

/**	Create a receiver object */
TTErr jamoma_receiver_create(ObjectPtr x, SymbolPtr addressAndAttribute, TTObjectPtr *returnedReceiver)
{
	TTSymbolPtr		oscAddress, attribute;
	TTValue			args;
	TTObjectPtr		returnAddressCallback, returnValueCallback;
	TTValuePtr		returnAddressBaton, returnValueBaton;

	// Get address part and attribute part
	splitAttribute(TT(addressAndAttribute->s_name), &oscAddress, &attribute);
	
	// Make a TTReceiver object
	args.append(JamomaApplication);
	args.append(oscAddress);
	
	if (attribute != NO_ATTRIBUTE)
		args.append(attribute);
	else
		args.append(kTTSym_value);
	
	// Replace none TTnames
	JamomaApplication->sendMessage(kTTSym_ConvertToTTName, args);
	
	returnAddressCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnAddressCallback, kTTValNONE);
	returnAddressBaton = new TTValue(TTPtr(x));
	returnAddressCallback->setAttributeValue(kTTSym_baton, TTPtr(returnAddressBaton));
	returnAddressCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_address));
	args.append(returnAddressCallback);
	
	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	returnValueBaton = new TTValue(TTPtr(x));
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(returnValueCallback);
	
	*returnedReceiver = NULL;
	TTObjectInstantiate(TT("Receiver"), TTObjectHandle(returnedReceiver), args);
	
	return kTTErrNone;
}


// Method to deal with TTPresetManager
///////////////////////////////////////////////////////////////////////

/**	Create a preset manager object */
TTErr jamoma_presetManager_create(ObjectPtr x, TTObjectPtr *returnedPresetManager)
{
	TTValue			args;
	TTObjectPtr		testObjectCallback, readItemCallback, updateItemCallback, sortItemCallback, sendItemCallback;
	TTValuePtr		testObjectBaton, readItemBaton, updateItemBaton, sortItemBaton, sendItemBaton;
	TTValue			attr;
	
	// prepare arguments
	args.append(JamomaApplication);
	
	testObjectCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &testObjectCallback, kTTValNONE);
	testObjectBaton = new TTValue(TTPtr(x));
	testObjectCallback->setAttributeValue(kTTSym_baton, TTPtr(testObjectBaton));
	testObjectCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_test_object));
	args.append(testObjectCallback);
	
	readItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &readItemCallback, kTTValNONE);
	readItemBaton = new TTValue(TTPtr(x));
	readItemCallback->setAttributeValue(kTTSym_baton, TTPtr(readItemBaton));
	readItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_read_item));
	args.append(readItemCallback);
	
	updateItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &updateItemCallback, kTTValNONE);
	updateItemBaton = new TTValue(TTPtr(x));
	updateItemCallback->setAttributeValue(kTTSym_baton, TTPtr(updateItemBaton));
	updateItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_update_item));
	args.append(updateItemCallback);
	
	sortItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &sortItemCallback, kTTValNONE);
	sortItemBaton = new TTValue(TTPtr(x));
	sortItemCallback->setAttributeValue(kTTSym_baton, TTPtr(sortItemBaton));
	sortItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_sort_item));
	args.append(sortItemCallback);
	
	sendItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &sendItemCallback, kTTValNONE);
	sendItemBaton = new TTValue(TTPtr(x));
	sendItemCallback->setAttributeValue(kTTSym_baton, TTPtr(sendItemBaton));
	sendItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_send_item));
	args.append(sendItemCallback);
	
	*returnedPresetManager = NULL;
	TTObjectInstantiate(TT("PresetManager"), TTObjectHandle(returnedPresetManager), args);
	
	return kTTErrNone;
}

/**	Create a cue manager object */
TTErr jamoma_cueManager_create(ObjectPtr x, TTObjectPtr *returnedCueManager)
{
	TTValue			args;
	TTObjectPtr		testObjectCallback, readItemCallback, updateItemCallback, sortItemCallback, sendItemCallback;
	TTValuePtr		testObjectBaton, readItemBaton, updateItemBaton, sortItemBaton, sendItemBaton;
	TTValue			attr;
	
	// prepare arguments
	args.append(JamomaApplication);
	
	testObjectCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &testObjectCallback, kTTValNONE);
	testObjectBaton = new TTValue(TTPtr(x));
	testObjectCallback->setAttributeValue(kTTSym_baton, TTPtr(testObjectBaton));
	testObjectCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_test_object));
	args.append(testObjectCallback);
	
	readItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &readItemCallback, kTTValNONE);
	readItemBaton = new TTValue(TTPtr(x));
	readItemCallback->setAttributeValue(kTTSym_baton, TTPtr(readItemBaton));
	readItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_read_item));
	args.append(readItemCallback);
	
	updateItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &updateItemCallback, kTTValNONE);
	updateItemBaton = new TTValue(TTPtr(x));
	updateItemCallback->setAttributeValue(kTTSym_baton, TTPtr(updateItemBaton));
	updateItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_update_item));
	args.append(updateItemCallback);
	
	sortItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &sortItemCallback, kTTValNONE);
	sortItemBaton = new TTValue(TTPtr(x));
	sortItemCallback->setAttributeValue(kTTSym_baton, TTPtr(sortItemBaton));
	sortItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_sort_item));
	args.append(sortItemCallback);
	
	sendItemCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &sendItemCallback, kTTValNONE);
	sendItemBaton = new TTValue(TTPtr(x));
	sendItemCallback->setAttributeValue(kTTSym_baton, TTPtr(sendItemBaton));
	sendItemCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_send_item));
	args.append(sendItemCallback);
	
	*returnedCueManager = NULL;
	TTObjectInstantiate(TT("CueManager"), TTObjectHandle(returnedCueManager), args);
	
	return kTTErrNone;
}

/** Sets data as kTTVal1 if the node have to be part of a preset */
void jamoma_callback_test_object(TTPtr p_baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	TTObjectPtr o;
	TTNodePtr	aNode;
	TTValue		v;
	TTBoolean	selected;
	TTSymbolPtr s, absoluteAddress;
	
	// unpack baton (a t_object*)
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (address)
	data.get(0, (TTPtr*)&aNode);
	
	// Here we decide to keep nodes which binds on :
	//		- Data with @service == parameter
	//		- Viewer which binds on a Data @service == parameter
	data = kTTVal0;
	if (o = aNode->getObject()) {
		
		if (o->getName() == TT("Data")) {
			o->getAttributeValue(kTTSym_service, v);
			v.get(0, &s);
			if (s == kTTSym_parameter)
				data = kTTVal1;
			return;
		}
		
		if (o->getName() == TT("Viewer")) {
			
			// Is the viewer selected ?
			o->getAttributeValue(kTTSym_selected, v);
			v.get(0, selected);
			
			if (selected) {
				// get object binded by the viewer
				o->getAttributeValue(kTTSym_address, v);
				v.get(0, &absoluteAddress);
				JamomaDirectory->getTTNodeForOSC(absoluteAddress, &aNode);
				
				if (o = aNode->getObject()) {
					if (o->getName() == TT("Data")) {
						o->getAttributeValue(kTTSym_service, v);
						v.get(0, &s);
						if (s == kTTSym_parameter)
							data = kTTVal1;
					}	
				}
			}
			
			return;
		}
	}
}

/**  */
void jamoma_callback_read_item(TTPtr p_baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	ItemPtr		anItem;
	TTValue		v;
	TTNodePtr	aNode;
	TTSymbolPtr absoluteAddress;
	TTObjectPtr o;
	
	// unpack baton (a t_object*)
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (an item)
	data.get(0, (TTPtr*)&anItem);
	
	// DATA case : do nothing
	
	// VIEWER case : they are replaced by Data
	// so after reading they should disappear from the preset
	if (anItem->getType() == TT("Viewer")) {
		
		// get address binded by the viewer
		anItem->node->getObject()->getAttributeValue(kTTSym_address, v);
		v.get(0, &absoluteAddress);
		JamomaDirectory->getTTNodeForOSC(absoluteAddress, &aNode);
		
		// if the address binds on a Data object
		if (o = aNode->getObject()) {
			if (o->getName() == TT("Data")) {
				
				// replace the Viewer node by the Data node
				anItem->node = aNode;
			}
		}
		
		return;
	}
}


/**  */
void jamoma_callback_update_item(TTPtr p_baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	ItemPtr		anItem;
	TTValue		v, r;
	TTNodePtr	aNode;
	TTBoolean	selected;
	TTSymbolPtr type, absoluteAddress;
	TTObjectPtr o;
	
	// unpack baton (a t_object*)
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (an item)
	data.get(0, (TTPtr*)&anItem);
	
	// clear the item in any case
	anItem->clear();
	
	// DATA case
	if (anItem->getType() == TT("Data")) {
		
		anItem->update(kTTSym_value);
		anItem->update(kTTSym_priority);
		
		// If the manager have a ramp attribute
		if (!anItem->manager->getAttributeValue(kTTSym_ramp, r)) {
			
			// for integer and decimal data
			anItem->node->getObject()->getAttributeValue(kTTSym_type, v);
			v.get(0, &type);
			
			// set ramp time as global
			if (type == kTTSym_integer || type == kTTSym_decimal)
				anItem->set(kTTSym_ramp, kTTSym_global);
		}
		
		return;
	}
	
	// VIEWER case : they are replaced by Data
	// so after a first update they should disappear from the preset
	if (anItem->getType() == TT("Viewer")) {
		
		// Is the viewer selected ?
		anItem->node->getObject()->getAttributeValue(kTTSym_selected, v);
		v.get(0, selected);
		
		if (selected) {
			
			// get address binded by the viewer
			anItem->node->getObject()->getAttributeValue(kTTSym_address, v);
			v.get(0, &absoluteAddress);
			JamomaDirectory->getTTNodeForOSC(absoluteAddress, &aNode);
			
			// if the address binds on a Data object
			if (o = aNode->getObject()) {
				if (o->getName() == TT("Data")) {
					
					// replace the Viewer node by the Data node
					anItem->node = aNode;
					
					anItem->update(kTTSym_value);
					anItem->update(kTTSym_priority);
					
					// If the manager have a ramp attribute
					if (!anItem->manager->getAttributeValue(kTTSym_ramp, r)) {
						
						// for integer and decimal data
						anItem->node->getObject()->getAttributeValue(kTTSym_type, v);
						v.get(0, &type);
						
						// set ramp time as global
						if (type == kTTSym_integer || type == kTTSym_decimal)
							anItem->set(kTTSym_ramp, kTTSym_global);
					}
				}
			}
		}
		
		return;
	}
}

/**  */
void jamoma_callback_sort_item(TTPtr p_baton, TTValue& data)
{
	TTValuePtr		b;
	ObjectPtr		x;
	TTHashPtr		anItemTable;
	TTListPtr		anItemKeysSorted;
	ItemPtr			anItem;
	TTValue			hk, v;
	TTSymbolPtr		key;
	TTUInt8			i, nbItemToSort, nbItemSorted;
	TTInt8			p, priority;
	
	// unpack baton a (t_object*)
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (an item table)
	data.get(0, (TTPtr*)&anItemTable);
	
	anItemKeysSorted = new TTList();
	
	// Start by sorting item with priority to -1 
	//(-1 are for very high priority data like /model/address)
	// until all item with priority != 0 are sorted
	priority = -1;
	nbItemSorted = 0;
	nbItemToSort = anItemTable->getSize();
	anItemTable->getKeys(hk);
	while (nbItemSorted < nbItemToSort) {
		
		// for each item
		for (i=0; i<anItemTable->getSize(); i++) {
			
			// sort item with priority to i
			hk.get(i,(TTSymbolPtr*)&key);
			
			// get priority
			anItemTable->lookup(key, v);
			v.get(0, (TTPtr*)&anItem);
			if (!anItem->get(kTTSym_priority, v))
				v.get(0, p);
			else
				p = 0;
			
			if (p == priority) {
				anItemKeysSorted->append(new TTValue(key));
				nbItemSorted++;
			}
			
			// ignore item with priority to 0
			// (do it one time only, when sorting priority == -1)
			if (priority == -1 && p == 0)
				nbItemToSort--;
		}
		
		if (priority == -1)
			priority = 1;
		else
			priority++;
	}
	
	// sort item with priority to 0
	for (i=0; i<anItemTable->getSize(); i++) {
		hk.get(i,(TTSymbolPtr*)&key);
		
		// get priority
		anItemTable->lookup(key, v);
		v.get(0, (TTPtr*)&anItem);
		if (!anItem->get(kTTSym_priority, v))
			v.get(0, p);
		else
			p = 0;
		
		if (p == 0) {
			anItemKeysSorted->append(new TTValue(key));
			nbItemSorted++;
		}
	}
	
	data.clear();
	data.append((TTPtr*)anItemKeysSorted);
}

/**  */
void jamoma_callback_send_item(TTPtr p_baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	TTUInt32	ramp;
	TTSymbolPtr rampSymbol;
	ItemPtr		anItem;
	TTValue		v, r;
	
	// unpack baton a t_object*)
	b = (TTValuePtr)p_baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (an item)
	data.get(0, (TTPtr*)&anItem);
	
	// DATA case
	if (anItem->getType() == TT("Data")) {
		
		// if the item have a ramp state
		if (!anItem->get(kTTSym_ramp, r)) {
			
			// prepare a command
			anItem->get(kTTSym_value, v);
			v.append(kTTSym_ramp);
			
			// Is ramp specific to the item ?
			if (r.getType() == kTypeUInt32)
				r.get(0, ramp);
			
			// or global ?
			else if (r.getType() == kTypeSymbol) {
				r.get(0, &rampSymbol);
				if (rampSymbol == kTTSym_global)
					if (!anItem->manager->getAttributeValue(kTTSym_ramp, r))
						r.get(0, ramp);
			}
			
			// or no
			else
				anItem->send(kTTSym_value);
			
			v.append(ramp);
			anItem->node->getObject()->sendMessage(kTTSym_Command, v);
		}
		else
			anItem->send(kTTSym_value);
	}
	
	// VIEWER case : they should have been replaced by DATA

}


// Method to deal with TTInput
///////////////////////////////////////////////////////////////////////

/**	Create an input object for any signal */
TTErr jamoma_input_create(ObjectPtr x, TTObjectPtr *returnedInput, long number)
{	
	TTValue			args;
	TTObjectPtr		signalOutCallback = NULL;
	TTValuePtr		signalOutBaton;
	
	// prepare arguments
	args.append(JamomaApplication);
	args.append(TTUInt16(number));
	args.append(TT("anything"));
	
	TTObjectInstantiate(TT("callback"), &signalOutCallback, kTTValNONE);
	signalOutBaton = new TTValue(TTPtr(x));
	signalOutBaton->append(TTPtr(gensym("return_signal")));
	signalOutCallback->setAttributeValue(kTTSym_baton, TTPtr(signalOutBaton));
	signalOutCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(signalOutCallback);
	
	*returnedInput = NULL;
	TTObjectInstantiate(TT("Input"), TTObjectHandle(returnedInput), args);
	
	return kTTErrNone;
}

/**	Create an input object for audio signal */
TTErr jamoma_input_create_audio(ObjectPtr x, TTObjectPtr *returnedInput, long number)
{
	TTValue				args;
	TTObjectPtr			signalOutCallback = NULL;
	TTValuePtr			signalOutBaton;
	TTAudioSignalPtr	audioIn = NULL;
	TTAudioSignalPtr	audioOut = NULL;
	TTAudioSignalPtr	audioZero = NULL;
	
	// prepare arguments
	args.append(JamomaApplication);
	args.append(TTUInt16(number));
	args.append(TT("audio"));
	
	TTObjectInstantiate(TT("callback"), &signalOutCallback, kTTValNONE);
	signalOutBaton = new TTValue(TTPtr(x));
	signalOutBaton->append(TTPtr(gensym("return_signal")));
	signalOutCallback->setAttributeValue(kTTSym_baton, TTPtr(signalOutBaton));
	signalOutCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(signalOutCallback);
	
	TTObjectInstantiate(kTTSym_audiosignal, &audioIn, number);
	args.append((TTPtr)audioIn);
	TTObjectInstantiate(kTTSym_audiosignal, &audioOut, number);
	args.append((TTPtr)audioOut);
	TTObjectInstantiate(kTTSym_audiosignal, &audioZero, number);
	args.append((TTPtr)audioZero);
	
	*returnedInput = NULL;
	TTObjectInstantiate(TT("Input"), TTObjectHandle(returnedInput), args);
	
	return kTTErrNone;
}

/**	Send any signal to an input object */
TTErr jamoma_input_send(TTInputPtr anInput, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{	
	TTValue		v;
	
	if (anInput) {
		
		jamoma_ttvalue_from_Atom(v, msg, argc, argv);
		
		anInput->sendMessage(kTTSym_Send, v);
		return kTTErrNone;
	}
	
	return kTTErrGeneric;
}


// Method to deal with TTOutput
///////////////////////////////////////////////////////////////////////

/**	Create an output object for signal */
TTErr jamoma_output_create(ObjectPtr x, TTObjectPtr *returnedOutput, long number)
{	
	TTValue			args;
	TTObjectPtr		signalOutCallback = NULL;
	TTValuePtr		signalOutBaton;
	
	// prepare arguments
	args.append(JamomaApplication);
	args.append(TTUInt16(number));
	args.append(TT("anything"));
	
	TTObjectInstantiate(TT("callback"), &signalOutCallback, kTTValNONE);
	signalOutBaton = new TTValue(TTPtr(x));
	signalOutBaton->append(TTPtr(gensym("return_signal")));
	signalOutCallback->setAttributeValue(kTTSym_baton, TTPtr(signalOutBaton));
	signalOutCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(signalOutCallback);
	
	*returnedOutput = NULL;
	TTObjectInstantiate(TT("Output"), TTObjectHandle(returnedOutput), args);
	
	return kTTErrNone;
}

/**	Create an output object for audio signal */
TTErr jamoma_output_create_audio(ObjectPtr x, TTObjectPtr *returnedOutput, long number)
{
	TTValue				args;
	TTObjectPtr			signalOutCallback = NULL;
	TTValuePtr			signalOutBaton;
	TTAudioSignalPtr	audioIn = NULL;
	TTAudioSignalPtr	audioOut = NULL;
	TTAudioSignalPtr	audioTemp = NULL;
	TTAudioSignalPtr	audioZero = NULL;
	TTObjectPtr			mixUnit = NULL;
	TTObjectPtr			gainUnit = NULL;
	TTObjectPtr			rampMixUnit = NULL;
	TTObjectPtr			rampGainUnit = NULL;
	
	// prepare arguments
	args.append(JamomaApplication);
	args.append(TTUInt16(number));
	args.append(TT("audio"));
	
	signalOutCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &signalOutCallback, kTTValNONE);
	signalOutBaton = new TTValue(TTPtr(x));
	signalOutBaton->append(TTPtr(gensym("return_signal")));
	signalOutCallback->setAttributeValue(kTTSym_baton, TTPtr(signalOutBaton));
	signalOutCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(signalOutCallback);
	
	TTObjectInstantiate(kTTSym_audiosignal, &audioIn, number);
	args.append((TTPtr)audioIn);
	TTObjectInstantiate(kTTSym_audiosignal, &audioOut, number);
	args.append((TTPtr)audioOut);
	TTObjectInstantiate(kTTSym_audiosignal, &audioTemp, number);
	args.append((TTPtr)audioTemp);
	TTObjectInstantiate(kTTSym_audiosignal, &audioZero, number);
	args.append((TTPtr)audioZero);
	
	TTObjectInstantiate(TT("crossfade"), &mixUnit, number);
	mixUnit->setAttributeValue(TT("position"), 1.0);
	args.append((TTPtr)mixUnit);
	
	TTObjectInstantiate(TT("gain"), &gainUnit, number);
	gainUnit->setAttributeValue(TT("linearGain"), 1.0);
	args.append((TTPtr)gainUnit);
	
	TTObjectInstantiate(TT("ramp"), &rampMixUnit, number);
	args.append((TTPtr)rampMixUnit);
	TTObjectInstantiate(TT("ramp"), &rampGainUnit, number);
	args.append((TTPtr)rampGainUnit);
	
	*returnedOutput = NULL;
	TTObjectInstantiate(TT("Output"), TTObjectHandle(returnedOutput), args);
	
	return kTTErrNone;
}

/**	Send any signal to an output object */
TTErr jamoma_output_send(TTOutputPtr anOutput, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{	
	TTValue		v;
	
	if (anOutput) {
		
		jamoma_ttvalue_from_Atom(v, msg, argc, argv);
		
		anOutput->sendMessage(kTTSym_Send, v);
		return kTTErrNone;
	}
	
	return kTTErrGeneric;
}


// Method to deal with TTMapper
///////////////////////////////////////////////////////////////////////

/**	Create a mapper object */
TTErr jamoma_mapper_create(ObjectPtr x, TTObjectPtr *returnedMapper)
{
	TTValue			args;
	TTObjectPtr		returnValueCallback;
	TTValuePtr		returnValueBaton;
	
	// prepare arguments
	args.append(JamomaApplication);
	
	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	returnValueBaton = new TTValue(TTPtr(x));
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(returnValueCallback);
	
	*returnedMapper = NULL;
	TTObjectInstantiate(TT("Mapper"), TTObjectHandle(returnedMapper), args);
	
	return kTTErrNone;
}


// Method to deal with TTViewer
///////////////////////////////////////////////////////////////////////

/**	Create a viewer object */
TTErr jamoma_viewer_create(ObjectPtr x, TTObjectPtr *returnedViewer)
{
	TTValue			args;
	TTObjectPtr		returnValueCallback;
	TTValuePtr		returnValueBaton;
	
	// prepare arguments
	args.append(JamomaApplication);
	
	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	returnValueBaton = new TTValue(TTPtr(x));
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(returnValueCallback);
	
	*returnedViewer = NULL;
	TTObjectInstantiate(TT("Viewer"), TTObjectHandle(returnedViewer), args);
	
	return kTTErrNone;
}

// Method to deal with TTExplorer
///////////////////////////////////////////////////////////////////////

/**	Create an explorer object */
TTErr jamoma_explorer_create(ObjectPtr x, TTObjectPtr *returnedExplorer)
{
	TTValue			args;
	TTObjectPtr		returnValueCallback;
	TTValuePtr		returnValueBaton;
	
	// prepare arguments
	args.append(JamomaApplication);
	
	returnValueCallback = NULL;			// without this, TTObjectInstantiate try to release an oldObject that doesn't exist ... Is it good ?
	TTObjectInstantiate(TT("callback"), &returnValueCallback, kTTValNONE);
	returnValueBaton = new TTValue(TTPtr(x));
	returnValueCallback->setAttributeValue(kTTSym_baton, TTPtr(returnValueBaton));
	returnValueCallback->setAttributeValue(kTTSym_function, TTPtr(&jamoma_callback_return_value));
	args.append(returnValueCallback);
	
	*returnedExplorer = NULL;
	TTObjectInstantiate(TT("Explorer"), TTObjectHandle(returnedExplorer), args);
	
	return kTTErrNone;
}

// Method to deal with TTDeviceManager
///////////////////////////////////////////////////////////////////////

/**	Create a deviceManager object */
TTErr jamoma_deviceManager_create(ObjectPtr x, SymbolPtr name, TTObjectPtr *returnedDeviceManager)
{
	TTValue			args;
	
	// Make a TTDeviceManager object
	args.append(JamomaApplication);
	args.append(TT(name->s_name));
	
	*returnedDeviceManager = NULL;
	TTObjectInstantiate(TT("DeviceManager"), TTObjectHandle(returnedDeviceManager), args);
	
	return kTTErrNone;
}

// Method to return data
///////////////////////////////////////////////////////////////////////

void jamoma_callback_return_address(TTPtr baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	TTSymbolPtr	address;
	
	// unpack baton (a t_object* and the name of the method to call)
	b = (TTValuePtr)baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (address)
	data.get(0, &address);
	
	// send data to a data using the return_value method
	object_method(x, gensym("return_address"), SymbolGen(address->getCString()), 0, 0);
}

void jamoma_callback_return_value(TTPtr baton, TTValue& v)
{
	TTValuePtr	b;
	ObjectPtr	x;
	SymbolPtr	msg, method;
	long		argc = 0;
	AtomPtr		argv = NULL;
	
	// unpack baton (a t_object* and the name of the method to call (default : jps_return_value))
	b = (TTValuePtr)baton;
	b->get(0, (TTPtr*)&x);
	
	if (b->getSize() == 2) {
		b->get(1, (TTPtr*)&method);
		if (method == NULL || method == _sym_nothing)
			return;
		}
	else
		method = gensym("return_value");

	jamoma_ttvalue_to_Msg_Atom(v, &msg, &argc, &argv);
	
	// send data to an external using the return_value method
	object_method(x, method, msg, argc, argv);
	
	sysmem_freeptr(argv);
}

/** Return any signal */
void jamoma_callback_return_signal(TTPtr baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	SymbolPtr	msg;
	long		argc = 0;
	AtomPtr		argv = NULL;
	
	// unpack baton (a t_object*)
	b = (TTValuePtr)baton;
	b->get(0, (TTPtr*)&x);
	
	jamoma_ttvalue_to_Msg_Atom(data, &msg, &argc, &argv);
	
	// send signal using the return_signal method
	object_method(x, gensym("return_signal"), msg, argc, argv);
	
	sysmem_freeptr(argv);
}

/** Return audio signal */
void jamoma_callback_return_signal_audio(TTPtr baton, TTValue& data)
{
	TTValuePtr	b;
	ObjectPtr	x;
	TTPtr		signal;
	long		i, argc = 0;
	AtomPtr		argv = NULL;
	
	// unpack baton (a t_object*)
	b = (TTValuePtr)baton;
	b->get(0, (TTPtr*)&x);
	
	// unpack data (signal)
	argc = data.getSize();
	argv = (AtomPtr)sysmem_newptr(sizeof(t_atom) * argc);
	for (i=0; i<argc; i++) {
		data.get(i, (TTPtr*)&signal);
		atom_setobj(argv+i, signal);
	}
	
	// send signal using the return_signal method
	object_method(x, gensym("return_signal"), _sym_nothing, argc, argv);
	
	sysmem_freeptr(argv);
}

// Method to deal with TTValue
/////////////////////////////////////////

/** Make a Message prepended Atom array from a TTValue (!!! this method allocate memory for the Atom array ! free it after ! */
void jamoma_ttvalue_to_Msg_Atom(const TTValue& v, SymbolPtr *msg, AtomCount *argc, AtomPtr *argv)
{
	AtomCount	i;
	
	*msg = _sym_nothing;
	*argc = v.getSize();
	if (!(*argv)) // otherwise use memory passed in
		*argv = (AtomPtr)sysmem_newptr(sizeof(t_atom) * (*argc));
	
	if (*argc && !(v == kTTValNONE)) {
		for (i=0; i<*argc; i++) {
			if(v.getType(i) == kTypeFloat32 || v.getType(i) == kTypeFloat64){
				TTFloat64	value;
				v.get(i, value);
				atom_setfloat((*argv)+i, value);
				*msg = _sym_float;
			}
			else if(v.getType(i) == kTypeSymbol){
				TTSymbolPtr	value = NULL;
				v.get(i, &value);
				atom_setsym((*argv)+i, gensym((char*)value->getCString()));
				//*msg = _sym_symbol;
			}
			else{	// assume int
				TTInt32	value;
				v.get(i, value);
				atom_setlong((*argv)+i, value);
				*msg = _sym_int;
			}
		}
		
		if (i>1) {
			if (atom_gettype(*argv) == A_SYM) {
				*msg = atom_getsym(*argv);
				*argc = (*argc)-1;
				*argv = (*argv)+1;
			}
			else
				*msg = _sym_list;
		}
	}
	else {
		*msg = _sym_bang;
		*argc = 0;
		*argv = NULL;
	}
}

/** Make an Atom array from a TTValue (!!! this method allocate memory for the Atom array ! free it after ! */
void jamoma_ttvalue_to_Atom(const TTValue& v, AtomCount *argc, AtomPtr *argv)
{
	AtomCount	i;
	
	*argc = v.getSize();
	if (!(*argv)) // otherwise use memory passed in
		*argv = (AtomPtr)sysmem_newptr(sizeof(t_atom) * (*argc));
	
	if (*argc && !(v == kTTValNONE)) {
		for (i=0; i<*argc; i++) {
			if(v.getType(i) == kTypeFloat32 || v.getType(i) == kTypeFloat64){
				TTFloat64	value;
				v.get(i, value);
				atom_setfloat((*argv)+i, value);
			}
			else if(v.getType(i) == kTypeSymbol){
				TTSymbolPtr	value = NULL;
				v.get(i, &value);
				atom_setsym((*argv)+i, gensym((char*)value->getCString()));
			}
			else{	// assume int
				TTInt32	value;
				v.get(i, value);
				atom_setlong((*argv)+i, value);
			}
		}
	}
	else {
		*argc = 0;
		*argv = NULL;
	}
}

/** Make a TTValue from Atom array */
void jamoma_ttvalue_from_Atom(TTValue& v, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	AtomCount	i, start;
	
	if ((msg == _sym_bang || msg == _sym_nothing) && argc == 0)
		v = kTTValNONE;
	else {
		
		// add msg to the value
		if (msg != _sym_nothing && msg != _sym_int && msg != _sym_float && msg != _sym_symbol && msg != _sym_list) {
			v.setSize(argc+1);
			v.set(0, TT(msg->s_name));
			start = 1;
		}
		else {
			v.setSize(argc);
			start = 0;
		}
			
		// convert Atom to TTValue
		for (i=0; i<argc; i++) 
		{
			if (atom_gettype(argv+i) == A_LONG)
				v.set(i+start, (int)atom_getlong(argv+i));
			else if (atom_gettype(argv+i) == A_FLOAT)
				v.set(i+start, atom_getfloat(argv+i));
			else if (atom_gettype(argv+i) == A_SYM)
				v.set(i+start, TT(atom_getsym(argv+i)->s_name));
		}
	}
}

/** Convert a TTSymbolPtr "MyObjectMessage" into a SymbolPtr "my/object/message" 
 or return NULL if the TTSymbolPtr doesn't begin by an uppercase letter */
SymbolPtr jamoma_TTName_To_MaxName(TTSymbolPtr TTName)
{
	TTSymbolPtr MaxName = convertTTNameInAddress(TTName);
	if (MaxName)
		return gensym((char*)MaxName->getCString());
	else
		return NULL;
}

/** Load an external for internal use. Returns true if successful */
TTBoolean jamoma_extern_load(SymbolPtr objectname, AtomCount argc, AtomPtr argv, ObjectPtr *object)
{
	t_class *c = NULL;
	t_object *p = NULL;
	
	c = class_findbyname(jps_box, objectname);
	if (!c) {
		p = (t_object *)newinstance(objectname, 0, NULL);
		if (p) {
			c = class_findbyname(jps_box, objectname);
			freeobject(p);
			p = NULL;
		}
		else {
			error("jamoma: could not load extern (%s) within the core", objectname->s_name);
			return false;
		}
	}
	
	if (*object != NULL) { // if there was an object set previously, free it first...
		object_free(*object);
		*object = NULL;
	}
	
	*object = (t_object *)object_new_typed(CLASS_BOX, objectname, argc, argv);
	return true;
}

/** Get the Context Node relative to a jcom.external if it is possible (else return the root)
	This method have to be defered low while the Context is not registered in the namespace.
	see jcom.init to get an example */
TTNodePtr jamoma_context_get_node(ObjectPtr x, TTSymbolPtr contextType)
{
	TTValue		v;
	TTList		whereToSearch, aContextList;
	long		nbLevel = 0;
	SymbolPtr	objclass = NULL, _sym_jcomhub, _sym_jcomparam, _sym_jcommessage, _sym_jcomreturn, _sym_share;
	TTNodePtr	contextNode;
	TTPtr		contextPtr;
	ObjectPtr	obj;
	TTBoolean	subscriberExist = false;	
	
	// Get the context list 
	jamoma_subscriber_get_context_list_method(x, contextType, &aContextList, &nbLevel);
	
	// Get the last context patcher 
	// (the first Model or View patcher above our object)
	if (aContextList.isEmpty())
		return JamomaDirectory->getRoot();
	
	aContextList.getTail().get(1, (TTPtr*)&contextPtr);

	// Start to look for other suscribed jcom.external
	obj = object_attr_getobj(contextPtr, _sym_firstobject);
	
	// TODO : cache those t_symbol else where ...
	_sym_jcomhub = gensym("jcom.hub");
	_sym_jcomparam = gensym("jcom.parameter");
	_sym_jcommessage = gensym("jcom.message");
	_sym_jcomreturn = gensym("jcom.return");
	_sym_share = gensym("share_context_node");
	while (obj) {
		objclass = object_attr_getsym(obj, _sym_maxclass);
		if (objclass == _sym_jcomhub || 
			objclass == _sym_jcomparam || 
			objclass == _sym_jcommessage || 
			objclass == _sym_jcomreturn) {
			
			// at least one subscriber exists
			subscriberExist = true;
			
			// ask it the contextNode
			object_method(object_attr_getobj(obj, _sym_object), _sym_share, &contextNode);
			
			if (contextNode)
				break;
		}
		obj = object_attr_getobj(obj, _sym_nextobject);
	}
	
	// if there are other suscribed jcom.external
	// return their contextNode (even if NULL)
	if (subscriberExist)
		return contextNode;
	
	// otherwise return the root
	else
		return JamomaDirectory->getRoot();
}

/** Convenient method to get the patcher easily */
ObjectPtr jamoma_patcher_get(ObjectPtr obj)
{
	ObjectPtr patcher = NULL;
	object_obex_lookup(obj, SymbolGen("#P"), &patcher);
	
	// If obj is in a bpatcher, the patcher is NULL
	if (!patcher){
		patcher = object_attr_getobj(obj, _sym_parentpatcher);
	}
	
	return patcher;
}


// Don't pass memory in for this function!  It will allocate what it needs
// -- then the caller is responsible for freeing
void jamoma_patcher_get_args(ObjectPtr patcher, AtomCount *argc, AtomPtr *argv)
{
	SymbolPtr	hierarchy = jamoma_patcher_get_hierarchy(patcher);
	ObjectPtr	box = object_attr_getobj(patcher, _sym_box);
	ObjectPtr	textfield = NULL;
	char			*text = NULL;
	unsigned long	textlen = 0;
	
	if (hierarchy == _sym_bpatcher)
		object_attr_getvalueof(box, SymbolGen("args"), argc, argv);
	
	else if (hierarchy == _sym_subpatcher) {
		textfield = object_attr_getobj(box, SymbolGen("textfield"));
		object_method(textfield, SymbolGen("gettextptr"), &text, &textlen);
		atom_setparse(argc, argv, text);
	}
	else {
		*argc = 0;
		*argv = NULL;
	}
}

/** Get the hierarchy of the patcher : bpatcher, subpatcher or top level one*/
SymbolPtr jamoma_patcher_get_hierarchy(ObjectPtr patcher)
{
	ObjectPtr box = object_attr_getobj(patcher, _sym_box);
	SymbolPtr objclass = NULL;
	
	if (box)
		objclass = object_classname(box);
	
	if (objclass == _sym_bpatcher)
		return objclass;
	
	else if (objclass == _sym_newobj)
		return _sym_subpatcher;
	
	else
		return _sym_topmost;
}

/** Get the context from the upper hub in the patcher */
void jamoma_patcher_get_context(ObjectPtr patcher, TTSymbolPtr *returnedContext)
{
	SymbolPtr	context, _sym_jcomhub, _sym_context;
	ObjectPtr	obj;
		
		// Look for jcom.hubs in the patcher
		obj = object_attr_getobj(patcher, _sym_firstobject);
		
		// TODO : cache those t_symbol else where ...
		_sym_jcomhub = gensym("jcom.hub");
		_sym_context = gensym("context");
		context = _sym_none;
		while (obj) {
			if (object_attr_getsym(obj, _sym_maxclass) == _sym_jcomhub) {
				
				// ask it his context attribute
				context = object_attr_getsym(obj, _sym_context);
				
				if (context != _sym_none)
					break;
			}
			obj = object_attr_getobj(obj, _sym_nextobject);
		}
		
		*returnedContext = TT(context->s_name);
		object_post((ObjectPtr)patcher, "context = %s", (*returnedContext)->getCString());
}

/** Get the class of the patcher from the file name (removing .model and .view convention name if they exist) */
void jamoma_patcher_get_class(ObjectPtr patcher, TTSymbolPtr context, TTSymbolPtr *returnedClass)
{
	char			*isCtxPatcher, *last_dot, *to_split;;
	SymbolPtr		hierarchy, patcherName, filename;
	TTString		addSlash;
	long			len, pos, patcherNameLen;
	
	hierarchy = jamoma_patcher_get_hierarchy(patcher);
	patcherName = object_attr_getsym(patcher, _sym_name);
	
	// if the patcher name have the .context at the end
	// Strip .context from the patch name
	isCtxPatcher = strstr(patcherName->s_name, context->getCString());
	if (isCtxPatcher) {
		patcherNameLen = strlen(patcherName->s_name) - strlen(context->getCString()) - 1;
		to_split = (char *)malloc(sizeof(char)*(patcherNameLen+1));
		strncpy(to_split, patcherName->s_name, patcherNameLen);
		to_split[patcherNameLen] = NULL;
		patcherName = gensym(to_split);										// TODO : replace each "." by the Uppercase of the letter after the "."
	}
	
	// case where the patcher is embedded in a contexted patcher
	if ((context != kTTSym_none) && (hierarchy == _sym_bpatcher || hierarchy == _sym_subpatcher))
		// extract class from the file name
		filename = object_attr_getsym(patcher, _sym_filename);
	
	// case where the object is in a subpatcher
	else if (hierarchy == _sym_subpatcher)
		// ignore this level
		jamoma_patcher_get_class(jamoma_patcher_get(patcher), context, returnedClass);

	// case where the user is editing the module
	else if (hierarchy == _sym_topmost)
		// extract class from the file name
		filename = object_attr_getsym(patcher, _sym_filename);
	
	else {
		*returnedClass = kTTSymEmpty;
		return;
	}
	
	// extract class name
	if (isCtxPatcher) {
		to_split = (char *)malloc(sizeof(char)*(strlen(filename->s_name)+1));
		strcpy(to_split, filename->s_name);
		
		// find the dot before .context
		len = strlen(to_split);
		last_dot = strrchr(to_split,'.');
		pos = (long)last_dot - (long)to_split - strlen(context->getCString()) - 1;
	}
	else {
		*returnedClass = kTTSymEmpty;
		return;
	}
	
	if (last_dot > 0) {
		to_split[pos] = NULL;	// split to keep only the name part
		*returnedClass = TT(to_split);
	}
	else
		*returnedClass = kTTSymEmpty;
	
	object_post((ObjectPtr)patcher, "class = %s", (*returnedClass)->getCString());
}

/** Get the context and the class of an object */
void jamoma_patcher_get_context_class(ObjectPtr obj,  TTSymbolPtr *returnedContext, TTSymbolPtr *returnedClass)
{
	ObjectPtr patcher = jamoma_patcher_get(obj);
	
	if (patcher) {
		jamoma_patcher_get_context(patcher, returnedContext);
		jamoma_patcher_get_class(patcher, *returnedContext, returnedClass);
	}
	else {
		*returnedContext = kTTSym_none;
		*returnedClass = kTTSymEmpty;
	}
}

/** returned the N inside "pp/xx[N]/yyy" and a format string as "pp/xx.%d/yy" and a format string as "pp/xx.%s/yy" */
long jamoma_parse_bracket(t_symbol *s, char **si_format, char **ss_format)
{
	int len, flen, pos, i_num = 1;
	char *start_bracket = NULL;
	char *end_bracket = NULL;
	char *to_parse = NULL;
	
	if (s != _sym_nothing) {
		
		to_parse = (char *)malloc(sizeof(char)*(strlen(s->s_name)+1));
		
		strcpy(to_parse,s->s_name);
		
		// find '[' and ']' in the instance
		start_bracket = strrchr(to_parse,'[');
		end_bracket = strrchr(to_parse,']');
		
		// if both exist, keep only what there is beetween
		if (start_bracket && end_bracket) {
			
			sscanf(start_bracket+1, "%d", &i_num);
			
			if (i_num) {
				
				// prepare memory
				pos = (int)start_bracket - (int)to_parse;
				len = (int)end_bracket - (int)start_bracket;		// the lenght of the "[N]" part
				flen = strlen(to_parse) - len + 2;					// +3 for \%d
				*si_format = (char *)malloc(sizeof(char)*(flen+1));
				*ss_format = (char *)malloc(sizeof(char)*(flen+1));	// only a * instead of \%d
				
				// edit a format string for interger
				strncpy(*si_format, to_parse, pos);
				(*si_format)[pos] = '\%';
				(*si_format)[pos+1] = 'd';
				(*si_format)[pos+2] = '\0';
				strncat(*si_format, end_bracket+1, strlen(end_bracket));
				(*si_format)[flen+1] = '\0';
				
				// edit a format string for symbol
				strncpy(*ss_format, to_parse, pos);
				(*ss_format)[pos] = '\%';
				(*ss_format)[pos+1] = 's';
				(*ss_format)[pos+2] = '\0';
				strncat(*ss_format, end_bracket+1, strlen(end_bracket));
				(*ss_format)[flen+1] = '\0';
				
				free(to_parse);
			}
			
			return i_num;
		}
		
		return -1;
	}
	
	*si_format = NULL;
	*ss_format = NULL;
	return NULL;	
}

/** edit a new instance of the given format address using interger */
void jamoma_edit_numeric_instance(char* format, t_symbol **returnedName, long i)
{
	char *s_num;
	long len;
	
	if (i > 0) {
		len = strlen(format) + (long)trunc(log10(i)); // note : %d (lenght = 2) is replaced by 1 character (0::9), 2 charecters (10 :: 99), 3 char...
		s_num = (char *)malloc(sizeof(char)*len);
		snprintf(s_num, len, format, i);
		*returnedName = gensym(s_num);
		free(s_num);
	}
}

/** edit a new instance of the given format address using string */
void jamoma_edit_string_instance(char* format, t_symbol **returnedName,  char* s)
{
	char *s_str;
	long len;
	
	if (s) {
		len = strlen(format) + strlen(s);
		s_str = (char *)malloc(sizeof(char)*len);
		snprintf(s_str, len, format, s);
		*returnedName = gensym(s_str);
		free(s_str);
	}
}

/** Parse #N inside address and replace them by parent patcher arguments if there are */
SymbolPtr jamoma_parse_dieze(ObjectPtr x, SymbolPtr address)
{
	TTString	diezeStr, argsStr, addressStr = address->s_name;
	SymbolPtr	hierarchy;
	ObjectPtr	patcher  = jamoma_patcher_get(x);
	char		dieze[5];
	char		args[64];
	size_t		found = 0;
	long		i, sd, sa;
	AtomCount	ac = 0;
	AtomPtr		av = NULL;
	
	// If x is in a bpatcher, the patcher is NULL
	if (!patcher){
		patcher = object_attr_getobj(x, _sym_parentpatcher);
	}
	
	if (patcher) {
		
		hierarchy = jamoma_patcher_get_hierarchy(patcher);
		
		// Try to get the patcher arguments
		jamoma_patcher_get_args(patcher, &ac, &av);
		if ((hierarchy == _sym_subpatcher)) {
			av++;
			ac--;
		}
		
		// if there are arguments
		if (ac > 0 && av) {
			
			i = 1;
			do {
				
				// prepare to parse #i
				snprintf(dieze, sizeof(dieze), "#%li", i);
				found = addressStr.find(dieze);
				
				// if #i found
				if (found != string::npos) {
					
					// get av+i atom
					if (i-1 < ac) {
						
						if (atom_gettype(av+i-1) == A_LONG)
							snprintf(args, sizeof(args), "%li", atom_getlong(av+i-1));
						else if (atom_gettype(av+i-1) == A_SYM)
							snprintf(args, sizeof(args), "%s", atom_getsym(av+i-1)->s_name);
						else {
							i++;
							continue;
						}
						
						diezeStr = dieze;
						argsStr	= args;
						sd = diezeStr.size();
						sa = argsStr.size();
						addressStr.replace(found, sd, args, sa);
					}
				}
				i++;
				
			} while (i-1 < ac); // while there are argument
			
			return gensym((char*)addressStr.data());
		}
	}
	
	return address;
}


// Files
///////////////////////////////////////////////


/** Get BOOT style filepath from args or, if no args open a dialog to write a file */
TTSymbolPtr jamoma_file_write(ObjectPtr x, AtomCount argc, AtomPtr argv, char* default_filename)
{
	char 			fullpath[MAX_PATH_CHARS];		// for storing the absolute path of the file
	short 			err, path;						// pathID#, error number
	t_filehandle	file_handle;					// a reference to our file (for opening it, closing it, etc.)
	long			filetype = 'TEXT', outtype;		// the file type that is actually true
	SymbolPtr		userpath;
	TTSymbolPtr		result = kTTSymEmpty;
	
	// Give a path ...
	if (argc && argv) {
		if (atom_gettype(argv) == A_SYM) {
			userpath = atom_getsym(argv);
			
			if (userpath != _sym_nothing) {
				// Use BOOT style path
				path = 0;
				path_nameconform(userpath->s_name, fullpath, PATH_STYLE_NATIVE, PATH_TYPE_BOOT);// Copy symbol argument to a local string
				
				// Create a file using Max API
				path_createsysfile(fullpath, path, filetype, &file_handle);
				
				result = TT(fullpath);
			}
		}
	} 
	
	// ... or open a dialog
	if (result == kTTSymEmpty) {
		
		saveas_promptset("Save Preset...");												// Instructional Text in the dialog
		err = saveasdialog_extended(default_filename, &path, &outtype, &filetype, 1);	// Returns 0 if successful
		if (!err) { // User Cancelled
			
			// Create a file using Max API
			path_createsysfile(default_filename, path, filetype, &file_handle);
			
			// Use BOOT style path
			jcom_file_get_path(path, default_filename, fullpath);
			
			result = TT(fullpath);
		}
	}
	
	return result;
}

/** Get BOOT style filepath grom args or, if no args open a dialog to read a file */
TTSymbolPtr jamoma_file_read(ObjectPtr x, AtomCount argc, AtomPtr argv)
{
	char 			filepath[MAX_FILENAME_CHARS];	// for storing the name of the file locally
	char 			fullpath[MAX_PATH_CHARS];		// path and name passed on to the xml parser
	short 			path;							// pathID#
    long			filetype = 'TEXT', outtype;		// the file type that is actually true
	SymbolPtr		userpath;
	TTSymbolPtr		result = kTTSymEmpty;
	
	// Give a path ...
	if (argc && argv) {
		if (atom_gettype(argv) == A_SYM) {
			userpath = atom_getsym(argv);
			
			if (userpath != _sym_nothing) {
				// Use BOOT style path
				path = 0;
				path_nameconform(userpath->s_name, fullpath, PATH_STYLE_NATIVE, PATH_TYPE_BOOT);// Copy symbol argument to a local string
				
				result = TT(fullpath);
			}
		}
	}
	
	// ... or open a dialog
	if (result == kTTSymEmpty)
		if (!open_dialog(filepath, &path, &outtype, &filetype, 1)) {	// Returns 0 if successful
			jcom_file_get_path(path, filepath, fullpath);
			result = TT(fullpath);
		}
	
	return result;
}


/** Function the translates a Max path+filename combo into a correct absolutepath */
// TODO: remove this function once we've completed the transition to Max5, as path_topathname() is fixed for Max5
void jcom_file_get_path(short in_path, char *in_filename, char *out_filepath)
{
	char path[4096];
	
	path_topathname(in_path, in_filename, path);
	
#ifdef MAC_VERSION
	char *temppath;
	temppath = strchr(path, ':');
	*temppath = '\0';
	temppath += 1;
	
	// at this point temppath points to the path after the volume, and out_filepath points to the volume
	sprintf(out_filepath, "/Volumes/%s%s", path, temppath);
#else // WIN_VERSION
	strcpy(out_filepath, path);
#endif
}
