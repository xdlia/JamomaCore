/* 
 * Jamoma N-Dimensional Matrix Data Class
 * Copyright © 2011, Timothy Place
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_MATRIX_H__
#define __TT_MATRIX_H__

#include "TTFoundation.h"
#include "TTDataObject.h"

typedef TTByte* TTBytePtr;	///< Data is a pointer to some bytes.


/**	Two types for the numbers used to indicate rows and columns.
	This is so that we can have multiple overrides of functions that take the numbers in either order.

	For example, linear algebra-related matrices will likely access elements in TTRowID, TTColumnID order.
	However, video processing objects will likely access elements in TTColumnID, TTRowID order.
 
	While C internally is indexed beginning at zero, the interface we create to the matrix data is a one-based.
	We do this to be consistent with mathematical and engineering conventions and as used by applications
	such as Octave and Matlab.
 */
typedef TTInt32 TTRowID;
typedef TTInt32 TTColumnID;


/****************************************************************************************************/
// Class Specification

/**	An N-dimensional matrix of compound values.	*/
class TTFOUNDATION_EXPORT TTMatrix : public TTDataObject {
	TTCLASS_SETUP(TTMatrix)
	
	TTBytePtr			mData;					///< matrix of values
	vector<TTUInt32>	mDimensions;			///< N dimensions, each int specifying the size of that dimension
	TTUInt8				mElementCount;			///< how many elements (parts) per value (e.g. 2 for complex numbers, 4 for colors, default = 1)
	TTUInt32			mComponentCount;		///< mDimension[0] * mDimension[1] ...
	TTUInt8				mComponentStride;		///< how many bytes from one the beginning one matrix component to the next
	TTUInt32			mDataCount;				///< mComponentCount * mElementCount (e.g. total number of floats or ints in the matrix)
	TTSymbolPtr			mType;					///< "uint8", "float32", etc. --> kTypeUInt8, kTypeUInt16, kTypeInt32, kTypeUInt64, kTypeFloat32, or kTypeFloat64
	TTUInt8				mTypeSizeInBytes;		///< number of bytes present in mType
	TTUInt32			mDataSize;				///< mTypeSizeInBytes * mDataCount
	TTBoolean			mDataIsLocallyOwned;	///< If false, then we are referencing outside memory which we don't own
	
	
	/**	Internal method that resizes memory allocated when various attributes change.	*/
	TTErr resize();
	
	/**	Attribute accessor	*/
	TTErr setType(const TTValue& aType);

	/**	Attribute accessor	*/
	TTErr setElementCount(const TTValue& newElementCount);

	/**	Run unit tests.	*/	
	virtual TTErr test(TTValue& returnedTestInfo);
	
public:
	
	/**	Attribute accessor	*/
	TTErr setDimensions(const TTValue& someNewDimensions);
	
	/**	Attribute accessor	*/
	TTErr getDimensions(TTValue& returnedDimensions) const;
	

	TTErr clear();
	TTErr fill(const TTValue& aValue);

	
	/**	Get the value of a component located at any location in an N-dimensional matrix.
		All dimension indices begin counting at one.	*/
	TTErr get(TTValue& aValue) const;

	/**	Get the value of a component located at (i,j) in a 2-dimensional matrix.
		The first location in the matrix is (1,1).
		In order to provide some degree of efficiency, the data passed-in is not bounds checked --
		you must ensure that you are passing memory that is at least mComponentStride bytes large.
	 
		In fact, you should pass a compound type if you want more than one of the primitive types.
		For example, pass a pointer to a TTComplex if you want two doubles.
	 */
	template<typename T>
	TTErr get2d(TTRowID i, TTColumnID j, T& data)
	{
		//TTUInt32 m = mDimensions[0];
		TTUInt32 n = mDimensions[1];
		
		i -= 1;	// convert to zero-based indices for data access
		j -= 1;	// convert to zero-based indices for data access
		
		data = *(T*)(mData + (i*n+j) * mComponentStride);	
		return kTTErrNone;
	}
	
	
	template<typename T>
	TTErr get2d(TTRowID i, TTColumnID j, TTUInt32 element, T& data)
	{
		//TTUInt32 m = mDimensions[0];
		TTUInt32 n = mDimensions[1];
		
		i -= 1;			// convert to zero-based indices for data access
		j -= 1;			// convert to zero-based indices for data access
		element -=1;	// convert to zero-based indices for data access
		
		data = *(T*)((mData + (i*n+j) * mComponentStride) + element);	
		return kTTErrNone;
	}

	
	/**	Set the value of a component located at any location in an N-dimensional matrix.
	 All dimension indices begin counting at one.		*/
	TTErr set(const TTValue& aValue);

	/**	Set the value of a component located at (i,j) in a 2-dimensional matrix.	
		The first location in the matrix is (1,1).
		In order to provide some degree of efficiency, the data passed-in is not bounds checked --
		you must ensure that you are passing memory that is at least mComponentStride bytes large.
	 
	 
		In fact, you should pass a compound type if you want more than one of the primitive types.
		For example, pass a pointer to a TTComplex if you want two doubles.
	 */
	template<typename T>
	TTErr set2d(TTRowID i, TTColumnID j, T data)
	{
		//TTUInt32 m = mDimensions[0];
		TTUInt32 n = mDimensions[1];
		
		i -= 1;	// convert to zero-based indices for data access
		j -= 1;	// convert to zero-based indices for data access
		
		*(T*)(mData + (i*n+j) * mComponentStride) = data;
		
		return kTTErrNone;
	}
	
	
	template<typename T>
	TTErr set2d(TTRowID i, TTColumnID j, TTUInt32 element, T data)
	{
		//TTUInt32 m = mDimensions[0];
		TTUInt32 n = mDimensions[1];
		
		i -= 1;			// convert to zero-based indices for data access
		j -= 1;			// convert to zero-based indices for data access
		element -=1;	// convert to zero-based indices for data access
		
		*(T*)(mData + ((i*n+j) * mComponentStride) + element) = data;
		
		return kTTErrNone;
	}
	
	
	TTSymbolPtr	getTypeAsSymbol()
	{
		return mType;
	}
	
	TTUInt32 getDataCount()
	{
		return mDataCount;
	}
	
	TTUInt32 getComponentStride()
	{
		return mComponentStride;
	}
	
	TTUInt32 getElementCount()
	{
		return mElementCount;
	}
	
	
	/**	You must proceed to set the various attributes, dimensions, etc. to match the data format of the matrix you are referencing.

		One caveat regards data alignment.  Jitter, for example, aligns rows on 16-byte boundaries.
		In this case, a 4x10 matrix (using the m-by-n convention rather than Jitter's width-by-height convention) of 32-bit ints, 
		all with a value of "4" will look like this:
	 
		4, 4, 4, 4,   4, 4, 4, 4,   4, 4, 0, 0
		4, 4, 4, 4,   4, 4, 4, 4,   4, 4, 0, 0
		4, 4, 4, 4,   4, 4, 4, 4,   4, 4, 0, 0
		4, 4, 4, 4,   4, 4, 4, 4,   4, 4, 0, 0
	 
		Thus, the rows are really of a dimension length 12 instead of 10 and the total size of the matrix scales as well.
		
		For the time being, we do not handle this case.  
		Jitter users must dimension their matrices so that the row size in bytes is a multiple of 16.
		This is not actually hard to do for most purposes.  For example:
	 
		float64, element count of 1, width is a multiple of 2 (an even number)
		float32 or int32, element count of 1, width is a multiple of 4
		uint8, element count of 1, width is a multiple of 16 (which includes 80, 160, 320, 640, ...), but 
			element count of 4 (i.e. color pixels) width should be a multiple of values.
	 */
	void referenceExternalData(TTPtr aDataPointer)
	{
		
		// TODO: see TTAudioSignal for more robust handling of freeing mData here, etc.
		// TODO: see the destructor, because there is also the issue of refcounting the data references?
		// for now we will just leak the memory until the design is complete
		mDataIsLocallyOwned = NO;
		mData = (TTBytePtr)aDataPointer;
	}
	
	
	/**	Copy the data from one matrix into another.	*/
	static TTErr copy(const TTMatrix& source, TTMatrix& dest);
	static TTErr copy(const TTMatrix* source, TTMatrix* dest)
	{
		return TTMatrix::copy(*source, *dest);
	}

	
	/**	Set dimensions, element count, datatype, etc. (i.e. the metadata describing a matrix)
	 to match the another matrix which is passed-in as an argument.	*/
	TTErr adaptTo(const TTMatrix& anotherMatrix);
	TTErr adaptTo(const TTMatrix* anotherMatrix)
	{
		return adaptTo(*anotherMatrix);
	}
	
	/** Return a pointer to the matrix data, and lock the matrix so that others cannot access the data.
		If matrix is already locked, this function waits until it becomes free. */
	TTBytePtr getLockedPointer()
	{
		// TODO: actually lock the data and add spin-lock with atomic access
		// NOTE: when locked, we cannot resize, change type, etc. either...
		
		return mData;
	}
	
	/**	Release a locked pointer obtained using getLockedPointer().	*/
	void releaseLockedPointer()
	{
		// TODO: see above.
		// NOTE: we could also cache the pointer in getLockedPointer() and match it to this.
		// But maybe that makes not sense.
	}

};


typedef TTMatrix* TTMatrixPtr;
typedef TTMatrix& TTMatrixRef;


#define TTMATRIX_PROCESS_MATRICES_WITH_NAMED_TEMPLATE(template_name, input_matrix, output_matrix) \
	if (input_matrix->getTypeAsSymbol() == kTTSym_uint8) \
		err = template_name<TTUInt8>(input_matrix, output_matrix); \
	else if (input_matrix->getTypeAsSymbol() == kTTSym_int32) \
		err = template_name<TTInt32>(input_matrix, output_matrix); \
	else if (input_matrix->getTypeAsSymbol() == kTTSym_float32) \
		err = template_name<TTFloat32>(input_matrix, output_matrix); \
	else if (input_matrix->getTypeAsSymbol() == kTTSym_float64) \
		err = template_name<TTFloat64>(input_matrix, output_matrix); \
	else \
		err = kTTErrInvalidType;


#endif // __TT_MATRIX_H__

