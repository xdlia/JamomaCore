/* 
 * TTModular Library
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */


#include "TTModular.h"

// Statics and Globals
static bool TTModularHasInitialized = false;

TTApplicationManagerPtr	TTModularApplications = NULL;

TTHashPtr TTModularNamespaces = NULL;

/****************************************************************************************************/

void TTModularInit()
{	
	// Initialized Foundation framework
	TTFoundationInit();
	
	// DEBUG NodeLib
	//TTObjectPtr test;
	//TTObjectInstantiate(TT("nodelib.test"), &test, kTTValNONE);
	//test->sendMessage(TT("test"));
	
	if (!TTModularHasInitialized) {
		
		TTModularHasInitialized = true;
		
		// register classes -- both internal and external
		TTApplication::registerClass();
		TTApplicationManager::registerClass();
		TTContainer::registerClass();
		TTCue::registerClass();
		TTCueManager::registerClass();
		TTData::registerClass();
		TTExplorer::registerClass();
		TTInput::registerClass();
		TTMapper::registerClass();
		TTMapperManager::registerClass();
		TTMirror::registerClass();
		TTOpmlHandler::registerClass();
		TTOutput::registerClass();
		TTPreset::registerClass();
		TTPresetManager::registerClass();
		TTReceiver::registerClass();
		TTSender::registerClass();
		TTScript::registerClass();
		TTSubscriber::registerClass();
		TTTextHandler::registerClass();
		TTViewer::registerClass();
		TTXmlHandler::registerClass();
		
		// TODO: someday implement these so that we have project-scoped caches and don't stuff everything into the foundation?
		TTModularSymbolCacheInit();
		//TTModularValueCacheInit();
		
		// to - this a very strange bug : the two first toString() parsing on number failed !?!
		// so here are two parsing to avoid this strange bug for instant ...
		TTString s;
		TTValue v;
		
		s = "0.001";
		v = s;
		v.fromString();
		
		v.clear();
		s = "1";
		v = s;
		v.fromString();
		
		// Create the Modular application manager with no application inside
		TTObjectInstantiate(TT("ApplicationManager"), TTObjectHandle(&TTModularApplications), kTTValNONE);
		
		// Create a hash table to manage namespace selections
		TTModularNamespaces = new TTHash();
		
#ifdef TT_DEBUG
		TTLogMessage("Modular -- Version %s -- Debugging Enabled\n", TTMODULAR_VERSION_STRING);
#else
		TTLogMessage("Modular -- Version %s\n", TTMODULAR_VERSION_STRING);
#endif

	}
}

void TTModularCreateLocalApplication(TTString applicationStr, TTString xmlConfigFilePath)
{
	TTValue				args;
	TTApplicationPtr	anApplication = NULL;
	
	if (TTModularApplications) {
		
		// if the local application doesn't exist yet
		if (!getLocalApplication) {
			
			// create the application
			args = TTValue(TT(applicationStr.data()));
			TTObjectInstantiate(TT("Application"), TTObjectHandle(&anApplication), args);
			
			// set it as local application
			args = TTValue((TTPtr)anApplication);
			TTModularApplications->setAttributeValue(TT("localApplication"), args);
			
			// Read xml configuration file
			TTXmlHandlerPtr anXmlHandler = NULL;
			TTObjectInstantiate(TT("XmlHandler"), TTObjectHandle(&anXmlHandler), kTTValNONE);
			
			anXmlHandler->setAttributeValue(kTTSym_object, args);
			
			args = TTValue(TT(xmlConfigFilePath));
			anXmlHandler->sendMessage(TT("Read"), args, kTTValNONE);
		}
		else
			TTLogMessage("Modular -- \"%s\" application already exists", getLocalApplicationName->getCString());
	}
}

TTNodeAddressItemPtr	TTModularNamespacesLookup(TTSymbolPtr namespaceName)
{
	TTNodeAddressItemPtr	aNamespace = NULL;
	TTValue			v;
	
	if (namespaceName != kTTSymEmpty) {
		
		if (!TTModularNamespaces->lookup(namespaceName, v))
			v.get(0, (TTPtr*)&aNamespace);
		
		else {
			aNamespace = new TTNodeAddressItem();
			
			v = TTValue((TTPtr)aNamespace);
			TTModularNamespaces->append(namespaceName, v);
		}
	}

	return aNamespace;
}

#ifdef TT_PLATFORM_LINUX
int main(void)
{
	// TODO: should we call TTModularInit() here?
	return 0;
}
#endif