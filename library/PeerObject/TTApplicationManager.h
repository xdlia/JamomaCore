/* 
 * An Application Manager Object
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_APPLICATION_MANAGER_H__
#define __TT_APPLICATION_MANAGER_H__

#include "TTModular.h"

class PluginFactories;

class TTApplication;
typedef TTApplication* TTApplicationPtr;

class Plugin;
typedef Plugin* PluginPtr;

/**	TTApplicationManager ... TODO : an explanation
 
 
 */

// Macro to retreive any application by name
#define getApplication(applicationName) TTApplicationManagerGetApplication(applicationName)

// Macro to retreive local application
#define getLocalApplication TTApplicationManagerGetApplication(kTTSym_localApplicationName)

// Macro to retreive a plugin by name
#define getPlugin(pluginName) TTApplicationManagerGetPlugin(pluginName)

class TTMODULAR_EXPORT TTApplicationManager : public TTDataObject
{
	TTCLASS_SETUP(TTApplicationManager)
	
public:

	TTHashPtr			mApplications;			///< hash table containing <TTSymbolPtr applicationName, TTApplicationPtr anApplication>
												///< one of them can be registered with kTTSym_local instead of his name
	TTHashPtr			mPlugins;				///< hash table containing <TTSymbolPtr pluginName, TTPluginPtr aPlugin>
	
private:
	
	TTValue				mApplicationNames;		///< ATTRIBUTE : all registered application names
	TTValue				mPluginNames;			///< ATTRIBUTE : all loaded plugin names	
	
	PluginFactories*	mPluginFactories;		///< the plugin factories
	
	TTObjectPtr			mCurrentApplication;	///< used for ReadFromXml mechanism
	
	
	/** Get all application names */
	TTErr getApplicationNames(TTValue& value);
	
	/** Get all plugin names */
	TTErr getPluginNames(TTValue& value);
	// TODO : TTErr getPluginIsLoaded(TTValue& value); // with value containing the name of the plugin
	
	/** Add an application giving <TTSymbolPtr applicationName, applicationPointer> */
	TTErr Add(const TTValue& value);
	
	/** Remove an application */
	TTErr Remove(const TTValue& value);
	
	/** Set Parameters of a Plugin <TTSymbolPtr pluginName, TTHashPtr pluginParameters> */
	TTErr PluginSetParameters(const TTValue& value);
	// TODO : void pluginSetCommParameter(TTString pluginName, TTString parameterName, TTString parameterValue)
	// TODO : void pluginGetCommParameter(TTString pluginName, TTString parameterName)
	// to -- we should use the attribute mecanism. Is a Plugin can't be a TTObject ?
	
	/** Lauch the reception thread mecanism of a Plugin <TTSymbolPtr pluginName> */
	TTErr PluginLaunch(const TTValue& value);
	
	/** Scan all plugin's network in oder to add distant application automatically */
	TTErr PluginScanAllApplication();
	
	/**  needed to be handled by a TTXmlHandler 
		 read/write local and distant applications setup */
	TTErr WriteAsXml(const TTValue& value);
	TTErr ReadFromXml(const TTValue& value);
	
	friend TTApplicationPtr TTMODULAR_EXPORT TTApplicationManagerGetApplication(TTSymbolPtr anAddress);
	friend PluginPtr TTMODULAR_EXPORT TTApplicationManagerGetPlugin(TTSymbolPtr pluginName);
	
	friend TTErr TTMODULAR_EXPORT TTApplicationManagerDirectoryCallback(TTPtr baton, TTValue& data);
	friend TTErr TTMODULAR_EXPORT TTApplicationManagerAttributeCallback(TTPtr baton, TTValue& data);
	
	friend TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationDiscover(TTSymbolPtr whereToDiscover, TTValue& returnedNodes, TTValue& returnedLeaves, TTValue& returnedAttributes);
	friend TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationListen(TTApplicationPtr appWhereToSend, TTSymbolPtr whereToListen, TTSymbolPtr attributeToListen, TTBoolean enableListening);
	friend TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationSet(TTSymbolPtr whereToSet, TTSymbolPtr attributeToSet, const TTValue& value);
	friend TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationGet(TTSymbolPtr whereToGet, TTSymbolPtr attributeToGet, TTValue& returnedValue);
};

typedef TTApplicationManager* TTApplicationManagerPtr;

/**	To get an application with an application name (or either from an address)
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							a TTApplicationPtr */
TTApplicationPtr TTMODULAR_EXPORT TTApplicationManagerGetApplication(TTSymbolPtr anAddress);

/**	To get a plugin with a plugin name
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							a TTApplicationPtr */
PluginPtr TTMODULAR_EXPORT TTApplicationManagerGetPlugin(TTSymbolPtr pluginName);

/**	Called when the local application directory send a notification
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationDirectoryCallback(TTPtr baton, TTValue& data);

/**	Called when a local application object attribute send a notification
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationAttributeCallback(TTPtr baton, TTValue& data);

/**	Called when the distant application wants to discover the local application directory
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationDiscover(TTSymbolPtr whereToDiscover, TTValue& returnedNodes, TTValue& returnedLeaves, TTValue& returnedAttributes);

/**	Called when the distant application wants to listen the local application directory
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationListen(TTApplicationPtr appWhereToSend, TTSymbolPtr whereToListen, TTSymbolPtr attributeToListen, TTBoolean enableListening);

/**	Called when the distant application wants to set an object attribute of the local application
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationSet(TTSymbolPtr whereToSet, TTSymbolPtr attributeToSet, const TTValue& value);

/**	Called when the distant application wants to get an object attribute of the local application
 note : it uses the extern TTModularApplications variable
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTApplicationManagerLocalApplicationGet(TTSymbolPtr whereToGet, TTSymbolPtr attributeToGet, TTValue& returnedValue);

/**	To iterate on the mPlugins HashTable
 @param	baton						..
 @param	data						..
 @return							void */
void TTMODULAR_EXPORT TTApplicationManagerStartPlugins(const TTPtr target, const TTKeyVal& iter);

/**	To iterate on the mPlugins HashTable
 @param	baton						..
 @param	data						..
 @return							void */
void TTMODULAR_EXPORT TTApplicationManagerStopPlugins(const TTPtr target, const TTKeyVal& iter);

#endif // __TT_APPLICATION_MANAGER_H__
