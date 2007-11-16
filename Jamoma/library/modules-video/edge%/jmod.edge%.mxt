max v2;
#N vpatcher 541 277 1264 775;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P hidden newex 143 425 58 196617 jcom.out 1;
#P hidden newex 212 215 52 196617 jcom.in 1;
#P user ubumenu 112 40 60 196617 0 1 1 0;
#X add Sobel;
#X add Prewitt;
#X add Robcross;
#X prefix_set 0 0 <none> 0;
#X pattrmode 1;
#P objectname Algorithm;
#P hidden newex 69 317 47 196617 pcontrol;
#P hidden newex 69 296 84 196617 jcom.pass /open;
#P hidden newex 351 99 88 196617 pvar Algorithm 3;
#P hidden message 99 86 125 196617 /documentation/generate;
#B color 3;
#P window linecount 2;
#P hidden newex 351 128 288 196617 jcom.parameter algorithm @type msg_symbol @description "Choose the type of.mxtorithm to use for the edge detection.";
#P objectname algorithm;
#P hidden newex 351 47 334 196617 jcom.parameter thresh @type msg_float @ramp linear.sched @description "Edge detection threshold - pixels below the threshold are set to black.";
#P objectname thresh;
#P window linecount 1;
#P hidden newex 351 27 64 196617 pvar Thresh;
#P flonum 112 20 35 9 0 0 8224 3 181 181 181 221 221 221 255 255 255 0 0 0;
#P objectname Thresh;
#P comment 71 22 39 196617 thresh;
#B frgb 149 149 149;
#P comment 58 41 53 196617 algorithm;
#B frgb 149 149 149;
#P hidden comment 158 410 75 196617 VIDEO OUTPUT;
#P hidden outlet 143 453 13 0;
#P hidden inlet 212 194 13 0;
#P hidden comment 227 194 65 196617 VIDEO INPUT;
#P hidden newex 143 379 79 196617 jalg.edge%.mxt;
#P hidden message 227 86 31 196617 /init;
#B color 3;
#P hidden comment 15 84 79 196617 command input;
#P window linecount 2;
#P hidden newex 1 114 282 196617 jcom.hub jmod.edge% @size 1U-half @module_type video @algorithm_type jitter @description "Glowing Edges Effect";
#P objectname jcom.hub;
#P hidden outlet 1 171 13 0;
#P hidden inlet 1 84 13 0;
#P bpatcher 0 0 256 60 0 0 jcom.gui.mxt 0;
#P objectname jcom.gui;
#P hidden fasten 17 0 3 0 104 105 6 105;
#P hidden connect 1 0 3 0;
#P hidden fasten 5 0 3 0 232 107 6 107;
#P hidden connect 3 0 2 0;
#P hidden connect 22 1 19 0;
#P hidden connect 19 0 20 0;
#P hidden fasten 19 1 6 0 148 348 148 348;
#P hidden fasten 20 0 6 0 74 356 148 356;
#P hidden connect 6 0 23 0;
#P hidden connect 23 0 9 0;
#P hidden connect 8 0 22 0;
#P hidden connect 22 0 6 1;
#P hidden fasten 15 0 14 0 356 81 346 81 346 18 356 18;
#P hidden connect 14 0 15 0;
#P hidden fasten 16 0 18 0 356 159 345 159 345 89 356 89;
#P hidden fasten 18 1 16 0 395 121 356 121;
#P pop;
