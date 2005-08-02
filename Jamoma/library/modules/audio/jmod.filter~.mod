max v2;
#N vpatcher 47 58 808 782;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 123 397 33 9109513 atodb;
#P message 103 108 43 9109513 autodoc;
#P window linecount 2;
#P message 47 668 65 9109513 \; max refresh;
#P user umenu 6 30 70 9109543 1 64 46 1;
#X add lowpass;
#X add highpass;
#X add bandpass;
#X add bandstop;
#X add peaknotch;
#X add lowshelf;
#X add highshelf;
#P objectname FilterType;
#P window linecount 1;
#P newex 262 21 124 9109513 r $0_xxx_to_filtergraph;
#P newex 46 613 124 9109513 s $0_xxx_to_filtergraph;
#N vpatcher 14 59 611 388;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 267 143 33 9109513 dbtoa;
#P window linecount 0;
#P comment 401 232 119 9109513 Set message to 6nd inlet;
#P outlet 96 274 15 0;
#P newex 96 232 215 9109513 pak set 1200. 1. 1.;
#P newex 335 119 50 9109513 route set;
#P inlet 199 50 15 0;
#P newex 267 119 50 9109513 route set;
#P inlet 267 50 15 0;
#P newex 199 119 50 9109513 route set;
#P inlet 335 50 15 0;
#P comment 405 121 100 9109513 Get rid of set;
#P connect 7 0 8 0;
#P connect 2 0 7 1;
#P connect 1 0 2 0;
#P connect 10 0 7 2;
#P connect 3 0 4 0;
#P connect 4 0 10 0;
#P connect 6 0 7 3;
#P connect 5 0 6 0;
#P pop;
#P newobj 46 589 124 9109513 p PrepareForFiltergraph~;
#P flonum 113 19 40 9 30. 11025. 8227 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname CenterFreq;
#P newex 205 444 75 9109513 pvar FilterGain;
#P newex 205 368 39 9109513 pvar Q;
#P newex 205 527 83 9109513 pvar CenterFreq;
#P newex 205 257 89 9109513 pvar FilterType 2;
#P newex 51 343 93 9109513 pvar FilterGraph 7;
#P window linecount 2;
#P message 47 638 72 9109513 \; jmod.init bang;
#P window linecount 3;
#P newex 161 128 81 9109513 pattrstorage @autorestore 0 @savemode 0;
#X client_rect 14 59 654 299;
#X storage_rect 0 0 640 240;
#P objectname jmod.filter~;
#P window linecount 2;
#P newex 262 45 270 9109513 jmod.message $0_ filtergraph @description "Messages to filtergraph. See the MSP reference for further details";
#P flonum 113 32 40 9 0. 100. 8227 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname Q;
#P window linecount 3;
#P newex 205 282 290 9109513 jmod.parameter $0_ filtertype @type menu @description "What kind of filter to use. Possible values: lowpass | highpass | bandpass | bandstop | peaknotch | lowshelf | highshelf";
#P objectname jmod.parameter.mxb;
#P window linecount 2;
#P newex 205 468 373 9109513 jmod.parameter $0_ filtergain @type msg_float @range -24 24 @clipmode both @ramp 1 @repetitions 0 @description "Gain (dB)";
#P objectname jmod.parameter.mxb[3];
#P newex 205 392 305 9109513 jmod.parameter $0_ q @type msg_float @ramp 1 @range 0. 100. @clipmode both @repetitions 0 @description "Resonance (Q)";
#P objectname jmod.parameter.mxb[2];
#P newex 205 548 334 9109513 jmod.parameter $0_ cf @type msg_float @range 30. 11025. @clipmode both @ramp 1 @repetitions 0 @description "Center frequency (Hz)";
#P objectname jmod.parameter.mxb[1];
#P window linecount 1;
#P comment 90 34 27 9109513 Q/S;
#B frgb 172 172 172;
#P flonum 113 45 40 9 -24. 24. 8227 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname FilterGain;
#P comment 98 21 18 9109513 cf;
#B frgb 172 172 172;
#P comment 90 47 25 9109513 gain;
#B frgb 172 172 172;
#P newex 262 208 108 9109513 poly~ jmod.filter~.alg;
#P window setfont "Sans Serif" 9.;
#P user filtergraph~ 166 20 88 39 21 9 20. 22050. 0.0625 16. 0 1 1 0 0 1 1;
#X frgb 99 99 99;
#X brgb 173 173 173;
#X rgb2 0 0 0;
#X rgb3 84 84 84;
#X rgb4 0 0 0;
#X rgb5 118 121 166;
#X rgb6 122 74 74;
#X rgb7 255 22 22;
#X linmarkers 5512.5 11025. 16537.5;
#X logmarkers 50. 500. 5000.;
#X nfilters 1;
#X setfilter 0 1 1 0 0 1548. 1. 1. 30. 11025. 0.0625 16. 0. 25.;
#X done;
#P objectname FilterGraph;
#P window setfont "Sans Serif" 9.;
#P hidden comment 175 81 101 9109513 ---signal outputs---;
#P comment 14 109 79 9109513 command input;
#P hidden outlet 244 67 13 0;
#P hidden inlet 59 -21 13 0;
#P hidden comment 58 -35 105 9109513 ----signal inputs----;
#P outlet 0 214 13 0;
#P hidden inlet 82 -21 13 0;
#P hidden outlet 183 67 13 0;
#P inlet 0 109 13 0;
#P bpatcher 0 0 256 60 0 0 jmod.gui.mxt 0 $0_;
#P objectname jmod.gui.1Uh.a.stereo.mxb;
#P window linecount 3;
#P comment 201 596 257 9109513 Convertion from freq \, gain and q to biquad coeffisients has to take place inside the poly~ (.alg) in case the poly is up- or downsampled.;
#P window linecount 5;
#P newex 0 128 157 9109513 jmod.hub $0_ jmod.filter~ @size 1U-half @module_type audio @num_inputs 2 @num_outputs 2 @description "Stereo 2nd order IIR filter based on biquad~";
#P hidden connect 8 0 2 0;
#P connect 3 0 0 0;
#P fasten 37 0 0 0 108 125 5 125;
#P connect 0 0 6 0;
#P connect 19 0 32 0;
#P connect 32 0 33 0;
#P fasten 21 1 26 0 490 335 56 335;
#P hidden connect 5 0 2 1;
#P connect 20 0 32 1;
#P connect 26 2 38 0;
#P connect 24 0 0 1;
#P connect 18 0 32 2;
#P connect 0 2 24 0;
#P hidden fasten 13 0 2 2 267 232 553 232 553 -12 169 -12;
#P hidden connect 23 0 12 0;
#P lcolor 6;
#P hidden connect 2 2 4 0;
#P fasten 21 0 27 0 210 326 198 326 198 252 210 252;
#P fasten 27 1 21 0 289 278 210 278;
#P fasten 19 0 29 0 210 424 199 424 199 359 210 359;
#P connect 29 0 19 0;
#P connect 26 3 19 0;
#P fasten 20 0 30 0 210 500 198 500 198 440 210 440;
#P connect 38 0 20 0;
#P connect 30 0 20 0;
#P fasten 18 0 28 0 210 580 201 580 201 521 210 521;
#P connect 26 1 18 0;
#P connect 28 0 18 0;
#P hidden connect 34 0 12 5;
#P hidden connect 2 3 9 0;
#P hidden fasten 13 1 2 3 365 228 548 228 548 -5 251 -5;
#P hidden fasten 2 0 13 0 5 105 267 105;
#P lcolor 6;
#P fasten 0 1 13 0 78 204 267 204;
#P hidden fasten 2 1 13 1 87 102 365 102;
#P lcolor 6;
#P pop;
