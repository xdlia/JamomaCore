max v2;
#N vpatcher 274 162 786 555;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P hidden message 101 133 43 196617 autodoc;
#N vpatcher 14 59 212 274;
#P window setfont "Sans Serif" 9.;
#P newex 101 95 53 196617 prepend 1;
#P outlet 53 155 15 0;
#P newex 53 125 58 196617 zl join;
#P newex 53 68 58 196617 zl slice 1;
#P inlet 53 39 15 0;
#P connect 0 0 1 0;
#P connect 1 0 2 0;
#P connect 2 0 3 0;
#P connect 1 1 4 0;
#P connect 4 0 2 1;
#P pop;
#P hidden newobj 4 321 61 196617 p formating;
#P hidden newex 8 252 58 196617 pvar shape;
#P hidden newex 8 286 55 196617 pvar mode;
#P hidden newex 4 341 63 196617 pvar curpos;
#P window linecount 2;
#P hidden newex 74 286 404 196617 jmod.parameter $0_ calc_mode @type menu @description "choose the calculation mode for the crossfade: fast uses a lookup table while precisision performs trig calculations";
#P objectname jmod.parameter.mxb[2];
#P hidden newex 74 252 275 196617 jmod.parameter $0_ shape @type menu @description "Choose the shape of the crossfade: linear or equal-power";
#P objectname jmod.parameter.mxb[3];
#P window linecount 3;
#P hidden newex 74 321 384 196617 jmod.parameter $0_ position @type msg_float @range 1. 2. @ramp 1 @description "set the position of the crossfade.  1 is entirely source 1 - 2 is entirely source 2 - positions in the middle are a location between source one and two.";
#P objectname jmod.parameter.mxb[1];
#P window linecount 1;
#P comment 116 26 37 196617 shape:;
#B frgb 172 172 172;
#P comment 94 45 68 196617 calc_mode:;
#B frgb 172 172 172;
#P user ubumenu 150 41 101 196617 0 1 1 0;
#X add FastMode;
#X add PrecisionMode;
#X prefix_set 0 0 0 0;
#X pattrmode 1;
#P objectname mode;
#P user ubumenu 150 22 101 196617 0 1 1 0;
#X add EqualPowerFade;
#X add LinearFade;
#X prefix_set 0 0 0 0;
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
#P flonum 86 18 34 9 1. 2. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;
#P noclick;
#P comment 5 20 89 196617 Current Position:;
#B frgb 172 172 172;
#P hidden inlet 90 -25 15 0;
#P hidden inlet 66 -25 15 0;
#P window linecount 2;
#P hidden message 46 200 72 196617 \; jmod.init bang;
#P hidden inlet 32 -26 15 0;
#P hidden outlet 196 65 15 0;
#P window linecount 1;
#P hidden comment 177 82 101 196617 ---signal outputs---;
#P hidden comment 14 133 79 196617 command input;
#P hidden inlet 8 -26 15 0;
#P hidden newex 249 204 128 196617 poly~ jmod.crossfade~.alg;
#P hidden comment 13 -44 105 196617 ----signal inputs----;
#P hidden outlet 0 214 15 0;
#P hidden outlet 245 65 15 0;
#P hidden inlet 0 133 13 0;
#P bpatcher 0 0 256 60 0 0 jmod.gui.mxt 0 $0_;
#P objectname jmod.gui.1Uh.a.stereo.mxb;
#P window linecount 3;
#P hidden newex 400 152 79 196617 pattrstorage @autorestore 0 @savemode 0;
#X client_rect 10 59 650 299;
#X storage_rect 0 0 640 240;
#P objectname jmod.crossfade~;
#P hidden newex 0 152 395 196617 jmod.hub $0_ jmod.crossfade~ @size 1U-half @module_type audio @num_inputs 4 @num_outputs 2 @description "Allows crossfades between 2 stereo sources. The first two inputs are the first source while the second 2 inputs are the second source.";
#P hidden connect 8 0 2 0;
#P hidden connect 3 0 0 0;
#P hidden connect 30 0 0 0;
#P hidden connect 0 0 5 0;
#P hidden connect 23 0 29 0;
#P hidden connect 29 0 26 0;
#P hidden connect 24 0 28 0;
#P hidden connect 25 0 27 0;
#P hidden connect 12 0 2 1;
#P hidden connect 28 0 24 0;
#P hidden connect 27 0 25 0;
#P hidden connect 26 0 23 0;
#P hidden connect 18 0 17 0;
#P lcolor 6;
#P hidden connect 14 0 2 2;
#P hidden connect 15 0 2 3;
#P hidden fasten 7 0 2 4 254 233 490 233 490 -22 201 -22;
#P hidden connect 2 4 11 0;
#P hidden fasten 7 1 2 5 372 228 485 228 485 -16 250 -16;
#P hidden connect 2 5 4 0;
#P hidden connect 0 1 7 0;
#P hidden fasten 2 0 7 0 5 127 254 127;
#P lcolor 6;
#P hidden fasten 2 1 7 1 54 124 293 124;
#P lcolor 6;
#P hidden fasten 2 2 7 2 103 121 332 121;
#P lcolor 6;
#P hidden fasten 2 3 7 3 152 118 371 118;
#P lcolor 6;
#P hidden connect 1 0 0 1;
#P hidden connect 0 2 1 0;
#P pop;
