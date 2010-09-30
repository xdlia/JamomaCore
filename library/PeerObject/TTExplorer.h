/* 
 * A Namespace Explorer Object
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_EXPLORER_H__
#define __TT_EXPLORER_H__

#include "TTModular.h"


/**	TTExplorer ... TODO : an explanation

 
 */

class TTMODULAR_EXPORT TTExplorer : public TTObject
{
	TTCLASS_SETUP(TTExplorer)
	
public:
	
	TTSymbolPtr			mAddress;						///< ATTRIBUTE : 
	TTSymbolPtr			mLookfor;						///< ATTRIBUTE : what the explorer is looking for from the address (Children, Instance, Attribute, ObjectType)
	TTValue				mEqual;							///< ATTRIBUTE : each found elements have to be equal to one element of this attribute (use KTTValNone to don't use this)
	TTValue				mDifferent;						///< ATTRIBUTE : each found elements have to be different from all elements of this attribute (use KTTValNone to don't use this)
	
private:
	
	TTNodeDirectoryPtr	mDirectory;						///< the directory
	TTCallbackPtr		mObserver;						///< a life cycle observer
	TTCallbackPtr		mReturnValueCallback;			///< a way to return back value to the owner of this explorer
	TTNodePtr			mTempNode;						///< remember the node on which the exploration have been done (Children and Instances cases)
	TTSymbolPtr			mTempName;						///< remember the name on which the exploration have been done (Instances case)
	TTSymbolPtr			mTempParent;					///< remember the parent address (Instances case)
	TTSymbolPtr			mTempObserve;					///< remember the observed address (Instances case)
	TTHashPtr			mResult;						///< hash table containing all elements found by the explorer
		
public:
	
	TTErr Explore();
	// TODO : TTErr Dump();
	
private :
	
	TTErr setLookfor(const TTValue& value);
	TTErr setAddress(const TTValue& value);
	TTErr setUpdate(const TTValue& value);
	
	TTErr getObjectsByType(TTValue& value);
	
	TTErr writeAsXml(const TTValue& value);
	TTErr readFromXml(const TTValue& value);
	
	/* TODO :
	 TTErr WriteAsText(const TTValue& value);			// pass an text buffer ?
	 TTErr ReadFromText(const TTValue& value);			// pass an text buffer ?
	 */
	
	friend TTErr TTMODULAR_EXPORT TTExplorerDirectoryCallback(TTPtr baton, TTValue& data);
};

typedef TTExplorer* TTExplorerPtr;

/**	
 @param	baton						..
 @param	data						..
 @return							an error code */
TTErr TTMODULAR_EXPORT TTExplorerDirectoryCallback(TTPtr baton, TTValue& data);

#endif // __TT_EXPLORER_H__
