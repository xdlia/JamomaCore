/* 
 *	split≈
 *	External object for Jamoma Multicore
 *	Copyright © 2008 by Timothy Place
 * 
 *	License: This code is licensed under the terms of the GNU LGPL
 *	http://www.gnu.org/licenses/lgpl.html 
 */

#include "maxMulticore.h"

#define thisTTClass			TTMulticoreSplit
#define thisTTClassName		"multicore.split"
#define thisTTClassTags		"audio, multicore"


/**	The split≈ object takes a single input signal and splits it out	into N output signals */
class TTMulticoreSplit : public TTAudioObject {
	TTCLASS_SETUP(TTMulticoreSplit)

	vector<TTUInt16>	mSplitChannels;	///< The number of channels in each of N groups of signals

	TTErr setGroups(const TTValueRef args)
	{
		TTUInt16 numArgs = args.getSize();
	
		mSplitChannels.resize(numArgs);
		for (TTUInt16 i=0; i<numArgs; i++) 
			args.get(i, mSplitChannels[i]);
		return kTTErrNone;
	}
	
	TTErr getGroups(TTValueRef args)
	{
		TTUInt16 numArgs = mSplitChannels.size();
		
		args.setSize(numArgs);
		for (TTUInt16 i=0; i<numArgs; i++)
			args.set(i, mSplitChannels[i]);
		return kTTErrNone;
	}
		
	TTErr processAudio(TTAudioSignalArrayPtr inputs, TTAudioSignalArrayPtr outputs)
	{
		TTAudioSignal&	in = inputs->getSignal(0);
		TTUInt16		channelOffset = 0;
		
		for (TTUInt16 i=0; i < outputs->numAudioSignals; i++) {
			TTAudioSignal&	out = outputs->getSignal(i);
			TTUInt16		numChannels = mSplitChannels[i];
			
			// TODO: we don't really want to alloc this memory every time!
			out.setmaxNumChannels(numChannels);
			out.setnumChannels(numChannels);
			TTAudioSignal::copySubset(in, out, channelOffset, channelOffset+numChannels-1);
			channelOffset += numChannels;
		}
		return kTTErrNone;
	}
	
};


TT_AUDIO_CONSTRUCTOR_EXPORT
{
	addAttributeWithGetterAndSetter(Groups, kTypeUInt16);

	setAttributeValue(TT("maxNumChannels"), arguments);		
	setProcessMethod(processAudio);
}


// Destructor
TTMulticoreSplit::~TTMulticoreSplit()
{
	;
}


int main(void)
{
	WrappedClassOptionsPtr	options = new WrappedClassOptions;
	TTValue					value(0);

	TTMulticoreInit();
	TTMulticoreSplit::registerClass();
	
	options->append(TT("argumentDefinesNumOutlets"), value);
	return wrapAsMaxMulticore(TT("multicore.split"), "jcom.split≈", NULL, options);
}

