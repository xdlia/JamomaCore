max v2;#N vpatcher 700 44 1223 638;#P origin 0 -1045;#P hidden inlet 412 170 13 0;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P hidden comment 427 171 65 196617 VIDEO INPUT;#P user multiSlider 28 29 127 17 0. 1. 1 2936 47 0 0 2 0 0 1;#M frgb 91 91 91;#M brgb 173 173 173;#M rgb2 127 127 127;#M rgb3 0 0 0;#M rgb4 37 52 91;#M rgb5 74 105 182;#M rgb6 112 158 18;#M rgb7 149 211 110;#M rgb8 187 9 201;#M rgb9 224 62 37;#M rgb10 7 114 128;#P objectname xfade;#P hidden newex 180 171 47 196617 pcontrol;#P hidden newex 180 148 78 196617 jmod.pass open;#P hidden newex 10 259 59 196617 pvar xfade;#P window linecount 2;#P hidden newex 10 281 320 196617 jmod.parameter $0_ /xfade @type msg_float @ramp 1 @repetitions 0 @range 0. 1. @clipmode both @description "Crossfade value";#P objectname jmod.parameter.mxt[2];#P window linecount 1;#P hidden message 99 86 50 196617 /autodoc;#B color 3;#P window linecount 3;#P hidden newex 417 105 79 196617 pattrstorage @autorestore 0 @savemode 0;#X client_rect 782 465 1336 822;#X storage_rect 0 0 640 240;#P objectname u225001184;#P window linecount 1;#P hidden comment 195 227 75 196617 VIDEO OUTPUT;#P hidden outlet 180 227 13 0;#P hidden inlet 322 171 13 0;#P hidden comment 337 172 65 196617 VIDEO INPUT;#P hidden newex 180 200 295 196617 jmod.xfade%.alg;#P window linecount 2;#P hidden message 386 316 72 196617 \; jmod.init bang;#B color 3;#P window linecount 1;#P hidden comment 15 84 79 196617 command input;#P window linecount 2;#P hidden newex 1 109 403 196617 jmod.hub $0_ jmod.xfade% @size 1U-half @module_type video @algorithm_type jitter @num_inputs 2 @num_outputs 1 @description "Crossfade between two video sources.";#P objectname jmod.hub;#P hidden outlet 1 171 13 0;#P hidden inlet 1 84 13 0;#P bpatcher 0 0 256 60 0 0 jmod.gui.mxt 0 $0_;#P objectname jmod.gui;#P hidden fasten 6 0 0 0 185 221 501 221 501 4 5 4;#P hidden connect 1 0 3 0;#P hidden fasten 12 0 3 0 104 105 6 105;#P hidden connect 3 0 2 0;#P hidden fasten 13 0 14 0 15 316 4 316 4 250 15 250;#P hidden connect 14 0 13 0;#P hidden connect 3 1 15 0;#P hidden connect 15 0 16 0;#P hidden fasten 15 1 6 0 253 193 185 193;#P hidden connect 16 0 6 0;#P hidden connect 6 0 9 0;#P hidden connect 8 0 6 1;#P hidden connect 11 0 3 1;#P hidden connect 3 2 11 0;#P hidden connect 19 0 6 2;#P pop;