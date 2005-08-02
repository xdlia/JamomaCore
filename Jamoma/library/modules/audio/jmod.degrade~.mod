max v2;
#N vpatcher 8 44 789 482;
#P window setfont "Sans Serif" 9.;
#P hidden message 140 121 43 9109513 autodoc;
#P window linecount 4;
#P hidden newex 0 140 249 9109513 jmod.hub $0_ jmod.degrade~ @size 1U-half @module_type audio @num_inputs 2 @num_outputs 2 @description Emulate the use of lower sample-rates and bit-resolution;
#P window linecount 1;
#P hidden comment 14 121 79 9109513 command input;
#P hidden inlet 0 121 13 0;
#P window linecount 2;
#P hidden message 418 166 72 9109513 \; jmod.init bang;
#P window linecount 3;
#P hidden newex 255 143 79 9109513 pattrstorage @autorestore 0 @savemode 0;
#X client_rect 155 333 818 823;
#X storage_rect 0 0 640 240;
#P objectname jmod.degrade~;
#P hidden inlet 20 -20 13 0;
#P hidden outlet 164 67 13 0;
#P flonum 104 25 40 9 0 0 8224 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P window linecount 2;
#P hidden newex 278 4 394 9109513 jmod.parameter.mxt $0_ sr_ratio @type msg_float @range 0. 1. @clipmode both @ramp 1 @description A ratio of the emulated sample-rate to the global sample-rate.;
#P objectname jmod.parameter;
#P window linecount 3;
#P hidden newex 278 37 318 9109513 jmod.parameter.mxt $0_ bitdepth @type msg_int @range 1 24 @clipmode both @ramp 1 @repetitions 0 @description "The number of bits that will be retained in each sample - use this for bit crunching effects";
#P objectname jmod.parameter[1];
#P hidden inlet 82 -18 13 0;
#P window linecount 1;
#P comment 54 44 53 9109513 Bit depth;
#B frgb 172 172 172;
#P number 104 42 35 9 0 0 8224 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P comment 16 27 85 9109513 sample rate ratio;
#B frgb 172 172 172;
#P hidden newex 265 207 120 9109513 poly~ jmod.degrade~.alg;
#P hidden comment 15 -30 105 9109513 ----signal inputs----;
#P hidden outlet 0 204 13 0;
#P hidden outlet 246 67 13 0;
#P bpatcher 0 0 256 60 0 0 jmod.gui.mxt 0 $0_;
#P objectname jmod.gui.1Uh.a.stereo.mxt;
#P hidden comment 164 79 101 9109513 ---signal outputs---;
#P hidden connect 14 0 1 0;
#P lcolor 6;
#P hidden connect 20 0 19 0;
#P hidden connect 17 0 19 0;
#P hidden connect 19 0 3 0;
#P hidden connect 9 0 1 1;
#P lcolor 6;
#P hidden connect 11 0 12 0;
#P hidden connect 10 0 7 0;
#P hidden fasten 5 0 1 2 270 242 684 242 684 -17 169 -17;
#P hidden connect 1 2 13 0;
#P hidden connect 15 0 19 1;
#P hidden fasten 5 1 1 3 380 231 674 231 674 -9 251 -9;
#P hidden connect 1 3 2 0;
#P hidden connect 19 2 15 0;
#P hidden fasten 19 1 5 0 124 199 270 199;
#P hidden fasten 1 0 5 0 5 101 270 101;
#P lcolor 6;
#P hidden connect 12 0 11 0;
#P hidden connect 7 0 10 0;
#P hidden fasten 1 1 5 1 87 98 380 98;
#P lcolor 6;
#P pop;
