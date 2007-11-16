max v2;
#N vpatcher 163 71 686 665;
#P origin 0 -1024;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#N vpatcher 734 44 1174 416;
#P window setfont "Sans Serif" 9.;
#P window linecount 0;
#P message 114 280 78 196617 /brightness \$1;
#P message 234 280 69 196617 /contrast \$1;
#P newex 114 214 73 196617 clip -200 200;
#P newex 114 244 109 196617 scale -200 200 -3. 5.;
#P newex 182 115 21 196617 t 1;
#P newex 182 93 32 196617 sel 0;
#P newex 108 115 21 196617 t 0;
#P newex 50 146 47 196617 gate 1 1;
#P newex 234 214 73 196617 clip -200 200;
#P newex 234 244 109 196617 scale -200 200 5. -3.;
#P window linecount 3;
#P user com 240 87 97 196617 26;
#K set 0 18025 28260 8291 26721 28263 25888 26990 8301 28533 29541 8304 28531 26996 26991 28192 29807 8291 28526 29810 28524 8308 26725 8303 26214 29541 29742;
#K end;
#P window linecount 1;
#P newex 50 169 94 196617 unpack 0 0 0 0 0 0;
#P newex 87 93 52 196617 route 2 4;
#P newex 87 71 105 196617 jcom.pwindow.mouse;
#P inlet 87 29 15 0;
#P outlet 114 324 15 0;
#P connect 11 0 8 0;
#P connect 9 0 8 0;
#P connect 8 0 4 0;
#P connect 1 0 2 0;
#P connect 2 0 3 0;
#P connect 3 0 8 1;
#P connect 3 1 9 0;
#P connect 4 4 13 0;
#P connect 13 0 12 0;
#P connect 12 0 15 0;
#P connect 15 0 0 0;
#P connect 14 0 0 0;
#P connect 2 1 10 0;
#P connect 10 0 11 0;
#P connect 4 5 7 0;
#P connect 7 0 6 0;
#P connect 6 0 14 0;
#P pop;
#P hidden newobj 28 209 73 196617 p mouse-stuff;
#P hidden newex 28 184 163 196617 jcom.oscroute /preview_dumpout;
#P objectname jcom.hub[1];
#P hidden newex 377 269 49 196617 jcom.out;
#P hidden inlet 377 140 13 0;
#P hidden comment 392 141 65 196617 VIDEO INPUT;
#P hidden newex 377 157 52 196617 jcom.in 1;
#P window linecount 2;
#P hidden user com 329 555 146 196617 28;
#K set 0 16748 25976 24942 25701 29216 21093 26227 30061 8266 25966 29541 28265 30067 3432 29812 28730 12079 28021 29545 25441 27751 25971 29813 29285 29486 30057 28462 28271;
#K end;
#P window linecount 1;
#P hidden newex 125 272 177 196617 jcom.oscroute /brightness /contrast;
#P hidden newex 188 207 47 196617 pcontrol;
#P hidden newex 188 184 78 196617 jcom.pass open;
#P hidden newex 26 533 90 196617 pvar monochrome;
#P window linecount 2;
#P hidden newex 26 555 230 196617 jcom.parameter monochrome @type msg_toggle @description "Monochrome image - 0 is default";
#P objectname monochrome[1];
#P window linecount 1;
#P comment 98 42 66 196617 monochrome;
#B frgb 149 149 149;
#P user radiogroup 160 40 18 16;
#X size 1;
#X offset 16;
#X inactive 0;
#X itemtype 1;
#X flagmode 0;
#X set 0;
#X done;
#P objectname monochrome;
#P hidden newex 25 453 80 196617 pvar saturation;
#P window linecount 2;
#P hidden newex 25 475 364 196617 jcom.parameter saturation @type msg_float @ramp linear.sched @repetitions 0 @range 0. 4. @clipmode none @description "Saturation of image - 1 is default";
#P objectname saturation[1];
#P flonum 56 41 35 9 0 0 8224 3 181 181 181 221 221 221 255 255 255 0 0 0;
#P objectname saturation;
#P flonum 143 22 35 9 0 0 8224 3 149 149 149 221 221 221 255 255 255 0 0 0;
#P objectname contrast;
#P flonum 56 22 35 9 0. 0 8225 3 181 181 181 221 221 221 255 255 255 0 0 0;
#P objectname brightness;
#P window linecount 1;
#P comment 5 42 56 196617 saturation;
#B frgb 149 149 149;
#P comment 98 24 48 196617 contrast;
#B frgb 149 149 149;
#P comment 4 24 57 196617 brightness;
#B frgb 149 149 149;
#P hidden newex 24 365 72 196617 pvar contrast;
#P hidden message 99 86 125 196617 /documentation/generate;
#B color 3;
#P window linecount 2;
#P hidden newex 24 393 356 196617 jcom.parameter contrast @type msg_float @ramp linear.sched @repetitions 0 @range 0. 4. @clipmode none @description "Contrast of image - 1 is default";
#P objectname contrast[1];
#P hidden newex 24 313 365 196617 jcom.parameter brightness @type msg_float @ramp linear.sched @repetitions 0 @range 0. 4. @clipmode none @description "Brightness of image - 1 is default";
#P objectname brightness[1];
#P window linecount 1;
#P hidden newex 24 287 81 196617 pvar brightness;
#P hidden comment 392 296 75 196617 VIDEO OUTPUT;
#P hidden outlet 377 296 13 0;
#P hidden newex 188 236 199 196617 jalg.brcosa%.mxt;
#P window linecount 2;
#P hidden message 401 510 72 196617 \; jcom.init bang;
#B color 3;
#P window linecount 1;
#P hidden comment 15 84 79 196617 command input;
#P window linecount 2;
#P hidden newex 1 109 385 196617 jcom.hub jmod.brcosa% @size 1U-half @module_type video @algorithm_type jitter @description "Simple image controls";
#P objectname jcom.hub;
#P hidden outlet 1 171 13 0;
#P hidden inlet 1 84 13 0;
#P bpatcher 0 0 256 60 0 0 jcom.gui.mxt 0;
#P objectname jcom.gui;
#P hidden fasten 12 0 3 0 104 105 6 105;
#P hidden connect 1 0 3 0;
#P hidden connect 3 0 2 0;
#P hidden fasten 10 0 9 0 29 347 19 347 19 284 29 284;
#P hidden fasten 28 0 10 0 130 308 29 308;
#P hidden connect 9 0 10 0;
#P hidden fasten 11 0 13 0 29 431 18 431 18 361 29 361;
#P hidden fasten 28 1 11 0 213 387 29 387;
#P hidden connect 13 0 11 0;
#P hidden fasten 20 0 21 0 30 510 19 510 19 444 30 444;
#P hidden connect 21 0 20 0;
#P hidden fasten 24 0 25 0 31 590 20 590 20 524 31 524;
#P hidden connect 25 0 24 0;
#P hidden fasten 3 0 34 0 6 161 33 161;
#P hidden connect 34 0 35 0;
#P hidden fasten 35 0 28 0 33 249 130 249;
#P hidden fasten 30 1 26 0 403 179 193 179;
#P hidden connect 26 0 27 0;
#P hidden fasten 35 0 6 0 33 231 193 231;
#P hidden connect 27 0 6 0;
#P hidden fasten 26 1 6 0 261 229 193 229;
#P hidden connect 32 0 30 0;
#P hidden connect 30 0 6 1;
#P hidden connect 6 1 33 0;
#P hidden connect 33 0 7 0;
#P pop;
