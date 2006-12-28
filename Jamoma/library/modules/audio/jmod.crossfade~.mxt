max v2;
#N vpatcher 72 49 532 617;
#P window setfont "Sans Serif" 9.;
#P hidden newex 65 318 209 9109513 jcom.in~ 4;
#P hidden newex 74 206 96 9109513 pvar position_float;
#P hidden message 116 447 125 9109513 /documentation/generate;
#N vpatcher 14 59 212 274;
#P window setfont "Sans Serif" 9.;
#P newex 101 95 53 9109513 prepend 1;
#P outlet 53 155 15 0;
#P newex 53 125 58 9109513 zl join;
#P newex 53 68 58 9109513 zl slice 1;
#P inlet 53 39 15 0;
#P connect 0 0 1 0;
#P connect 1 0 2 0;
#P connect 2 0 3 0;
#P connect 1 1 4 0;
#P connect 4 0 2 1;
#P pop;
#P hidden newobj 8 156 61 9109513 p formating;
#P hidden newex 8 78 58 9109513 pvar shape;
#P hidden newex 8 112 55 9109513 pvar mode;
#P hidden newex 8 176 64 9109513 pvar curpos;
#P window linecount 2;
#P hidden newex 74 112 355 9109513 jcom.parameter mode @type menu @description "choose the calculation mode for the crossfade: fast uses a lookup table while precisision performs trig calculations";
#P objectname jcom.parameter.mxb[2];
#P hidden newex 74 78 253 9109513 jcom.parameter shape @type menu @description "Choose the shape of the crossfade: linear or equal-power";
#P objectname jcom.parameter.mxb[3];
#P window linecount 3;
#P hidden newex 74 156 356 9109513 jcom.parameter position @type msg_float @range 1. 2. @ramp linear @description "set the position of the crossfade.  1 is entirely source 1 - 2 is entirely source 2 - positions in the middle are a location between source one and two.";
#P objectname jcom.parameter.mxb[1];
#P window linecount 1;
#P comment 116 26 37 9109513 shape:;
#B frgb 172 172 172;
#P comment 94 45 68 9109513 calc_mode:;
#B frgb 172 172 172;
#P user ubumenu 150 41 101 9109513 0 1 1 0;
#X add FastMode;
#X add PrecisionMode;
#X prefix_set 0 0 0 0;
#X pattrmode 1;
#P objectname mode;
#P user ubumenu 150 22 101 9109513 0 1 1 0;
#X add EqualPowerFade;
#X add LinearFade;
#X prefix_set 0 0 0 0;
#X pattrmode 1;
#P objectname shape;
#P user multiSlider 5 32 107 14 1. 2. 1 2936 47 0 0 2 0 0 0;
#M frgb 131 144 178;
#M brgb 224 225 194;
#M rgb2 127 127 127;
#M rgb3 0 0 0;
#M rgb4 37 52 91;
#M rgb5 74 105 182;
#M rgb6 112 158 18;
#M rgb7 149 211 110;
#M rgb8 187 9 201;
#M rgb9 224 62 37;
#M rgb10 7 114 128;
#P objectname curpos;
#P flonum 86 18 34 9 1. 2. 8227 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P noclick;
#P objectname position_float;
#P comment 5 20 89 9109513 Current Position:;
#B frgb 172 172 172;
#P hidden inlet 263 293 15 0;
#P hidden inlet 197 293 15 0;
#P hidden message 244 447 23 9109513 /init;
#P hidden inlet 131 293 15 0;
#P hidden outlet 65 381 15 0;
#P hidden comment 89 381 84 9109513 ---signal outputs---;
#P hidden comment 29 444 79 9109513 command input;
#P hidden inlet 65 293 15 0;
#P hidden newex 65 354 128 9109513 poly~ jalg.crossfade~.mxt;
#P hidden comment 123 276 105 9109513 ----signal inputs----;
#P hidden outlet 15 527 15 0;
#P hidden outlet 182 381 15 0;
#P hidden inlet 15 445 13 0;
#P window linecount 3;
#P hidden newex 15 474 323 9109513 jcom.hub jmod.crossfade~ @size 1U-half @module_type audio @description "Allows crossfades between 2 stereo sources. The first two inputs are the first source while the second 2 inputs are the second source";
#P objectname jcom.hub;
#P window linecount 1;
#P hidden comment 173 209 189 9109513 The number box is only used for display;
#P bpatcher 0 0 256 60 0 0 jcom.gui.mxt 0;
#P objectname jcom.gui.1Uh.a.stereo.mxb;
#P hidden connect 24 0 28 0;
#P hidden connect 25 0 27 0;
#P hidden connect 23 0 29 0;
#P hidden connect 29 0 26 0;
#P hidden fasten 30 0 2 0 121 467 20 467;
#P hidden connect 3 0 2 0;
#P hidden fasten 13 0 2 0 249 469 20 469;
#P hidden connect 2 0 5 0;
#P hidden connect 8 0 32 0;
#P hidden connect 32 4 7 0;
#P hidden connect 32 0 7 0;
#P hidden connect 7 0 11 0;
#P hidden connect 28 0 24 0;
#P hidden connect 27 0 25 0;
#P hidden connect 26 0 23 0;
#P hidden connect 23 0 31 0;
#P hidden connect 32 1 7 1;
#P hidden connect 12 0 32 1;
#P hidden connect 32 2 7 2;
#P hidden connect 32 3 7 3;
#P hidden connect 7 1 4 0;
#P hidden connect 14 0 32 2;
#P hidden connect 15 0 32 3;
#P pop;
