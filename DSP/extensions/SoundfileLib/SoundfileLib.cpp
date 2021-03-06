/* 
 * SoundfileLib -- Operate on Soundfiles
 * Extension Class for Jamoma DSP
 * Copyright © 2010, Timothy Place
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTDSP.h"
#include "TTSoundfile.h"
#include "TTSoundfileLoader.h"
#include "TTSoundfilePlayer.h"
#include "TTSoundfileRecorder.h"


extern "C" TT_EXTENSION_EXPORT TTErr TTLoadJamomaExtension_SoundfileLib(void)
{
	TTFoundationInit();
	TTDSPInit();
	
    TTSoundfile::registerClass();
//	TTSoundfileLoader::registerClass();
	TTSoundfilePlayer::registerClass();
	TTSoundfileRecorder::registerClass();
	
	return kTTErrNone;
}

