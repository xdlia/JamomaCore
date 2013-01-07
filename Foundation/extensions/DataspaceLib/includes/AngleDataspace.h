/* 
 * Jamoma DataspaceLib: AngleDataspac.h
 * Copyright © 2007, Nils Peters
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __ANGLEDATASPACE_H__
#define __ANGLEDATASPACE_H__

#include "TTDataspace.h"


/****************************************************************************************************/

class RadianUnit : public TTDataObjectBase, public TTDataspaceUnit {
	TTCLASS_SETUP(RadianUnit)
public:
	void convertToNeutral(const TTValue& input, TTValue& output);
	void convertFromNeutral(const TTValue& input, TTValue& output);	
};

class DegreeUnit : public TTDataObjectBase, public TTDataspaceUnit {
	TTCLASS_SETUP(DegreeUnit)
public:
	void convertToNeutral(const TTValue& input, TTValue& output);
	void convertFromNeutral(const TTValue& input, TTValue& output);	
};


/****************************************************************************************************/

class AngleDataspace : public TTDataObjectBase, public TTDataspace {
	TTCLASS_SETUP(AngleDataspace)
    
    /**	Unit Tests	*/
	virtual TTErr test(TTValue& returnedTestInfo);
};


#endif // __ANGLEDATASPACE_H__
