/* 
 * jcom.modular
 * External for Jamoma : to manage local and distant application
 *
 * By Theo de la Hogue, Copyright 2010
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html
 */

#include "TTModularClassWrapperMax.h"

#define activity_out 0
#define config_out 1
#define dump_out 2

// Definitions
void	WrapTTApplicationManagerClass(WrappedClassPtr c);
void	WrappedApplicationManagerClass_new(TTPtr self, AtomCount argc, AtomPtr argv);

void	appmg_assist(TTPtr self, void *b, long msg, long arg, char *dst);

void	appmg_application_configuration(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	appmg_plugin_configuration(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	appmg_configuration(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);

void	appmg_read(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	appmg_doread(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	appmg_read_again(TTPtr self);
void	appmg_doread_again(TTPtr self);

void	appmg_write(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	appmg_dowrite(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv);
void	appmg_write_again(TTPtr self);
void	appmg_dowrite_again(TTPtr self);

void	appmg_return_value(TTPtr self, t_symbol *msg, long argc, t_atom *argv);

int TTCLASSWRAPPERMAX_EXPORT main(void)
{
	ModularSpec *spec = new ModularSpec;
	spec->_wrap = &WrapTTApplicationManagerClass;
	spec->_new = &WrappedApplicationManagerClass_new;
	spec->_any = NULL;
	
	return wrapTTModularClassAsMaxClass(TT("ApplicationManager"), "jcom.modular", NULL, spec);
}

void WrapTTApplicationManagerClass(WrappedClassPtr c)
{
	class_addmethod(c->maxClass, (method)appmg_assist,						"assist",						A_CANT, 0L);
	
	class_addmethod(c->maxClass, (method)appmg_return_value,				"return_value",					A_CANT, 0);
	
	class_addmethod(c->maxClass, (method)appmg_application_configuration,	"application/configuration",	A_GIMME, 0);
	class_addmethod(c->maxClass, (method)appmg_plugin_configuration,		"plugin/configuration",			A_GIMME, 0);
	class_addmethod(c->maxClass, (method)appmg_configuration,				"configuration",				A_GIMME, 0);
	
	class_addmethod(c->maxClass, (method)appmg_read,						"read",							A_GIMME, 0);
	class_addmethod(c->maxClass, (method)appmg_write,						"write",						A_GIMME, 0);
	
	class_addmethod(c->maxClass, (method)appmg_read_again,					"read/again",					0);
	class_addmethod(c->maxClass, (method)appmg_write_again,					"write/again",					0);
}

void WrappedApplicationManagerClass_new(TTPtr self, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	SymbolPtr					localApplicationName;
	TTXmlHandlerPtr				aXmlHandler;
	TTValue						v, args;
 	long						attrstart = attr_args_offset(argc, argv);			// support normal arguments
	
	// optionnaly change the local application name (default : Jamoma)
	if (attrstart && argv) 
		localApplicationName = atom_getsym(argv);
	
	// our wrapped object is the application manager
	x->wrappedObject = (TTObjectPtr)TTModularApplications;
	
	// TODO : change the local application name
	
	// Make two outlets
	x->outlets = (TTHandle)sysmem_newptr(sizeof(TTPtr) * 2);
	x->outlets[config_out] = outlet_new(x, NULL);					// anything outlet to output configuration
	x->outlets[activity_out] = outlet_new(x, NULL);					// anything outlet to output activity
	
	// Prepare Internals hash to store XmlHanler and TextHandler object
	x->internals = new TTHash();
	
	// create internal TTXmlHandler
	aXmlHandler = NULL;
	TTObjectInstantiate(TT("XmlHandler"), TTObjectHandle(&aXmlHandler), args);
	v = TTValue(TTPtr(aXmlHandler));
	x->internals->append(TT("XmlHandler"), v);
	v = TTValue(TTPtr(x->wrappedObject));
	aXmlHandler->setAttributeValue(kTTSym_object, v);
	
	attr_args_process(x, argc, argv);
}

// Method for Assistance Messages
void appmg_assist(TTPtr self, void *b, long msg, long arg, char *dst)
{
	if (msg==1) 						// Inlet
		strcpy(dst, "input");
	else {								// Outlets
		switch(arg) {
			case activity_out:
				strcpy(dst, "activity");
				break;
			case config_out:
				strcpy(dst, "configuration");
				break;
			case dump_out:
				strcpy(dst, "dumpout");
				break;
		}
 	}
}

void appmg_application_configuration(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTSymbolPtr			applicationName;
	TTApplicationPtr	anApplication;
	TTValue				v;
	AtomCount			ac = 0;
	AtomPtr				av = NULL;
	
	if (argc && argv) {
		
		if (atom_gettype(argv) == A_SYM) {
			
			applicationName = TT(atom_getsym(argv)->s_name);
			anApplication = TTApplicationManagerGetApplication(applicationName);
			
			if (anApplication) {
				anApplication->getAttributeValue(TT("pluginNames"), v);
				
				v.prepend(applicationName);
				jamoma_ttvalue_to_Atom(v, &ac, &av);
				outlet_anything(x->outlets[config_out], msg, ac, av);
			}
			else
				object_post((ObjectPtr)x, "%s is not an application", applicationName->getCString());
		}
	}
}

void appmg_plugin_configuration(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTSymbolPtr			pluginName;
	TTPluginHandlerPtr	aPlugin;
	TTValue				v;
	AtomCount			ac = 0;
	AtomPtr				av = NULL;
	
	if (argc && argv) {
		
		if (atom_gettype(argv) == A_SYM) {
			
			pluginName = TT(atom_getsym(argv)->s_name);
			aPlugin = TTApplicationManagerGetPlugin(pluginName);
			
			if (aPlugin) {
				aPlugin->getAttributeValue(TT("parameterNames"), v);
				
				v.prepend(pluginName);
				jamoma_ttvalue_to_Atom(v, &ac, &av);
				outlet_anything(x->outlets[config_out], msg, ac, av);
			}
			else
				object_post((ObjectPtr)x, "%s is not a plugin", pluginName->getCString());
		}
	}
}

void appmg_configuration(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTSymbolPtr			applicationName, pluginName, parameterName;
	TTApplicationPtr	anApplication;
	TTHashPtr			pluginParameters, parameters;
	TTValue				v;
	AtomCount			ac = 0;
	AtomPtr				av = NULL;
	TTErr				err;
	
	if (argc && argv) {
		
		if (atom_gettype(argv) == A_SYM) {
			applicationName = TT(atom_getsym(argv)->s_name);
			anApplication = TTApplicationManagerGetApplication(applicationName);
			
			if (anApplication) {
				anApplication->getAttributeValue(TT("pluginParameters"), v);
				v.get(0, (TTPtr*)&pluginParameters);
				
				if (atom_gettype(argv+1) == A_SYM) {
					pluginName = TT(atom_getsym(argv+1)->s_name);
					err = pluginParameters->lookup(pluginName, v);
					v.get(0, (TTPtr*)&parameters);
					
					if (!err && atom_gettype(argv+2) == A_SYM) {
						parameterName = TT(atom_getsym(argv+2)->s_name);
						err = parameters->lookup(parameterName, v);
						
						if (!err) {
							v.prepend(parameterName);
							v.prepend(pluginName);
							v.prepend(applicationName);
							jamoma_ttvalue_to_Atom(v, &ac, &av);
							outlet_anything(x->outlets[config_out], msg, ac, av);
						}
						else
							object_post((ObjectPtr)x, "%s is not a parameter of %s plugin", parameterName->getCString(), pluginName->getCString());
					}
					else
						object_post((ObjectPtr)x, "%s is not a plugin of %s application", pluginName->getCString(), applicationName->getCString());
				}
			}
			else
				object_post((ObjectPtr)x, "%s is not an application", applicationName->getCString());
		}
	}
}

void appmg_read(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	defer(self, (method)appmg_doread, msg, argc, argv);
}

void appmg_doread(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{	
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue			o, v;
	TTSymbolPtr		fullpath;
	TTXmlHandlerPtr	aXmlHandler = NULL;
	TTErr			tterr;
	
	if (x->wrappedObject) {
		
		fullpath = jamoma_file_read((ObjectPtr)x, argc, argv);
		v.append(fullpath);
		
		tterr = x->internals->lookup(TT("XmlHandler"), o);
		
		if (!tterr) {
			
			o.get(0, (TTPtr*)&aXmlHandler);
			
			critical_enter(0);
			aXmlHandler->sendMessage(TT("Read"), v);
			critical_exit(0);
		}
	}
}

void appmg_read_again(TTPtr self)
{
	defer(self, (method)appmg_doread_again, NULL, 0, NULL);
}

void appmg_doread_again(TTPtr self)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTXmlHandlerPtr	aXmlHandler = NULL;
	TTValue			o;
	TTErr			tterr;
	
	tterr = x->internals->lookup(TT("XmlHandler"), o);
	
	if (!tterr) {
		
		o.get(0, (TTPtr*)&aXmlHandler);
		
		critical_enter(0);
		aXmlHandler->sendMessage(TT("ReadAgain"));
		critical_exit(0);
	}
}

void appmg_write(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	defer(self, (method)appmg_dowrite, msg, argc, argv);
}

void appmg_dowrite(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	char 			filename[MAX_FILENAME_CHARS];
	TTSymbolPtr		fullpath;
	TTValue			o, v;
	TTXmlHandlerPtr	aXmlHandler;
	TTErr			tterr;
	
	if (x->wrappedObject) {
		
		// TODO : find a default XML File Name using the name of the patch
		snprintf(filename, MAX_FILENAME_CHARS, "ApplicationConfig.xml");
		fullpath = jamoma_file_write((ObjectPtr)x, argc, argv, filename);
		v.append(fullpath);
		
		tterr = x->internals->lookup(TT("XmlHandler"), o);
		
		if (!tterr) {
			o.get(0, (TTPtr*)&aXmlHandler);
			
			critical_enter(0);
			aXmlHandler->sendMessage(TT("Write"), v);
			critical_exit(0);
		}
	}
}

void appmg_write_again(TTPtr self)
{
	defer(self, (method)appmg_dowrite_again, NULL, 0, NULL);
}

void appmg_dowrite_again(TTPtr self)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTXmlHandlerPtr	aXmlHandler = NULL;
	TTValue			o;
	TTErr			tterr;
	
	tterr = x->internals->lookup(TT("XmlHandler"), o);
	
	if (!tterr) {
		
		o.get(0, (TTPtr*)&aXmlHandler);
		
		critical_enter(0);
		aXmlHandler->sendMessage(TT("WriteAgain"));
		critical_exit(0);
	}
}

void appmg_return_value(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	outlet_anything(x->outlets[activity_out], msg, argc, argv);
}