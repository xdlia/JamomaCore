max v2;#N vpatcher 44 49 1250 786;#P origin -103 -1467;#P window setfont "Sans Serif" 9.;#P newex 212 596 27 196617 * 3;#P window linecount 4;#P hidden message 8 662 328 196617 script hidden connect pvar_directivity_preset 1 directivity_preset 0 \, script hidden connect directivity_preset 0 pvar_directivity_preset 0 \, script hidden connect directivity_preset 1 mic-preset 0 \, script hidden connect mic-preset 0 parameter_directivity 0;#P window linecount 1;#P hidden newex 8 587 27 196617 t b i;#P window linecount 3;#P hidden newex 25 616 350 196617 sprintf script new directivity_preset newex 990 30 270 196617 jcom.message microphones/%ld/directivity/preset @type msg_symbol @priority %ld @description "Directivity_preset_for_the_microphone %ld";#P window linecount 1;#N vpatcher 431 307 1031 707;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P message 371 102 31 196617 0.25;#P message 200 102 31 196617 0.75;#P message 257 102 23 196617 0.5;#P message 428 102 17 196617 0.;#P window linecount 0;#P message 143 102 23 196617 1.;#P newex 143 65 352 196617 route Omni Subcardioid Cardioid Supercardioid Hypercardioid Figure-eight;#P outlet 143 270 15 0;#P inlet 143 46 15 0;#P comment 40 103 73 196617 check this.....;#P connect 1 0 3 0;#P connect 3 0 4 0;#P connect 5 0 2 0;#P connect 8 0 2 0;#P connect 6 0 2 0;#P connect 7 0 2 0;#P connect 4 0 2 0;#P connect 3 1 7 0;#P connect 3 2 6 0;#P connect 3 4 8 0;#P connect 3 5 5 0;#P pop;#P newobj 1136 45 73 196617 p mic-presets;#P objectname mic-preset;#P newex 830 0 121 196617 pvar directivity_menu 2;#P objectname pvar_directivity_preset;#P user ubumenu 332 0 71 196617 0 0 1 0;#X setrgb 181 181 181 25 25 25 50 50 50 4 4 4 141 141 141 112 112 112;#X add ---;#X add Omni;#X add Subcardioid;#X add Cardioid;#X add Supercardioid;#X add Hypercardioid;#X add Figure-eight;#X prefix_set 0 0 <none> 0;#P objectname directivity_menu;#P newex 269 75 55 196617 delay 100;#N vpatcher 616 360 1216 760;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P hidden message 145 119 56 196617 frgb 0 0 0;#P hidden message 244 118 64 196617 rgb1 66 0 2;#P outlet 123 260 15 0;#P inlet 211 54 15 0;#P window linecount 0;#P hidden message 27 117 81 196617 brgb 16 255 37;#P connect 1 0 0 0;#P connect 0 0 2 0;#P connect 3 0 2 0;#P connect 4 0 2 0;#P connect 1 0 4 0;#P connect 1 0 3 0;#P pop;#P hidden newobj 269 99 46 196617 p colors;#P user jsui 0 1 25 14 1 0 0 jcom.jsui_texttoggle.js on off 68 68 68 225 225 225 121 255 15;#P objectname ACTIVE;#P user jsui 96 205 25 14 1 0 0 jcom.jsui_texttoggle.js on off 68 68 68 225 225 225 121 255 15;#P objectname ACTIVE-old;#N vpatcher 10 59 610 459;#P window setfont "Sans Serif" 9.;#P newex 50 50 51 196617 route set;#P newex 51 71 68 196617 jcom.miditoa;#P inlet 50 30 15 0;#P outlet 51 93 15 0;#P connect 1 0 3 0;#P connect 3 0 2 0;#P connect 2 0 0 0;#P pop;#P newobj 758 77 48 196617 p midi2a;#P objectname miditoa;#P newex 751 6 68 196617 jcom.atomidi;#P objectname atomidi;#P message 921 115 53 196617 0. \, \$1 50;#P newex 921 132 40 196617 line 0.;#P objectname storage;#P newex 921 95 43 196617 float 0.;#P newex 942 58 97 196617 if $f1 > 0. then $f1;#P objectname if_store;#P button 1260 225 15 0;#P message 1216 225 23 196617 0.;#P objectname zero;#P newex 1245 187 41 196617 sel 1 0;#P objectname sel_active;#P newex 249 476 27 196617 * 3;#P window linecount 3;#P hidden message 45 542 269 196617 script hidden connect pvar_aktive 0 parameter_aktive 0 \, script hidden connect parameter_aktive 0 pvar_aktive 0 \, script hidden connect parameter_aktive 1 sel_active 0;#P window linecount 1;#P hidden newex 45 467 27 196617 t b i;#P window linecount 3;#P hidden newex 62 496 381 196617 sprintf script new parameter_aktive newex 750 180 270 196617 jcom.parameter microphones/%ld/mute @type msg_int @range 0 1 @clipmode both @priority %ld @repetitions 0 @description "Muting_of_the_microphone %ld";#P window linecount 1;#P newex 739 147 67 196617 pvar ACTIVE;#P objectname pvar_aktive;#P message 658 85 30 196617 bang;#P message 602 82 53 196617 defeat \$1;#P inlet 601 0 15 0;#P newex 601 60 144 196617 jcom.oscroute /freeze /clear;#P user jcom.meter~ 452 5 66 6;#P inlet 575 2 15 0;#P window linecount 4;#P hidden message 1117 406 307 196617 script hidden connect atomidi 0 parameter_gain 0 \, script hidden connect parameter_gain 0 miditoa 0 \, script hidden connect parameter_gain 1 if_store 0 \, script hidden connect storage 0 parameter_gain 0 \, script hidden connect zero 0 parameter_gain 0;#P window linecount 1;#P hidden newex 1284 337 27 196617 * 3;#P hidden newex 1098 302 27 196617 t b i;#P window linecount 3;#P hidden newex 1109 360 296 196617 sprintf script new parameter_gain newex 700 70 270 196617 jcom.parameter.gain microphones/%ld/gain @priority %ld @repetitions 0 @description "Gain_of_of_the_microphone %ld";#P window linecount 1;#N vpatcher 749 58 1349 458;#P outlet 123 260 15 0;#P inlet 211 54 15 0;#P window setfont "Sans Serif" 9.;#P hidden message 375 121 64 196617 rgb2 66 0 2;#P hidden message 27 117 94 196617 rgb2 164 153 128;#P hidden message 253 117 92 196617 frgb 181 181 181;#P hidden message 137 120 93 196617 brgb 100 100 100;#P outlet 387 261 15 0;#P connect 5 0 3 0;#P connect 1 0 6 0;#P connect 3 0 6 0;#P connect 2 0 6 0;#P connect 5 0 1 0;#P connect 5 0 2 0;#P connect 5 0 4 0;#P connect 2 0 0 0;#P connect 1 0 0 0;#P connect 4 0 0 0;#P pop;#P hidden newobj 347 68 46 196617 p colors;#N thispatcher;#Q end;#P hidden newobj 349 112 61 196617 thispatcher;#N vpatcher 188 431 335 589;#P button 41 33 15 0;#P window setfont "Sans Serif" 9.;#P newex 41 54 50 196617 deferlow;#P outlet 41 103 15 0;#P inlet 41 15 15 0;#P connect 0 0 3 0;#P connect 3 0 2 0;#P pop;#P hidden newobj 349 89 14 196617 p;#P hidden newex 345 24 48 196617 loadbang;#P hidden button 404 26 15 0;#P hidden newex 346 45 50 196617 deferlow;#P window setfont "Sans Serif" 12.;#P comment 402 0 13 196620 ||;#B frgb 198 0 65;#P bpatcher 415 2 36 13 0 0 jcom.numberslider.mxt 0 1. 0. 1. @size 40 14;#P objectname gain_mic;#P window setfont "Sans Serif" 9.;#P flonum 167 0 35 9 0 0 8224 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname Z;#P flonum 131 0 35 9 0 0 8224 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname Y;#P bpatcher 295 2 36 13 0 0 jcom.numberslider.mxt 0 0. 0. 1. @size 40 14 @frgb 181 181 181;#P objectname dir_mic;#P window setfont "Sans Serif" 12.;#P comment 279 0 13 196620 ||;#B frgb 198 0 65;#P window setfont "Sans Serif" 9.;#P hidden newex 936 341 27 196617 * 3;#P hidden newex 765 314 27 196617 t b i;#P window linecount 4;#P hidden newex 782 358 317 196617 sprintf script new parameter_directivity newex 990 70 270 196617 jcom.parameter microphones/%ld/directivity/ratio @type msg_float @range 0. 1. @clipmode both @priority %ld @repetitions 0 @description "Directivity_value_of_the_microphone %ld.";#P window linecount 2;#P hidden message 773 414 270 196617 script hidden connect dir_mic 0 parameter_directivity 0 \, script hidden connect parameter_directivity 0 dir_mic 0;#P window linecount 1;#P message 80 266 14 196617 1;#P hidden newex 561 349 27 196617 * 3;#P hidden newex 388 330 27 196617 t b i;#P window linecount 3;#P hidden newex 405 368 357 196617 sprintf script new parameter2 newex 830 245 270 196617 jcom.parameter microphones/%ld/angle @type msg_list @priority %ld @repetitions 0 @description "orientation_[azimut&elevation]_of_the_microphone %ld";#P window linecount 2;#P hidden message 388 415 235 196617 script connect list2parameter2 10 parameter2 0 \, script connect parameter2 0 list2parameter2 10;#P window linecount 1;#P newex 684 225 144 196617 jcom.list2parameter 2;#P objectname list2parameter2;#P hidden newex 719 198 39 196617 pvar E;#P objectname pvar_E;#P hidden newex 675 197 41 196617 pvar A;#P objectname pvar_A;#P flonum 248 0 32 9 -90. 90. 8227 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname E;#P flonum 215 0 33 9 0 0 8224 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname A;#P window setfont "Sans Serif" 12.;#P comment 202 0 13 196620 ||;#B frgb 198 0 65;#P window setfont "Sans Serif" 9.;#P hidden newex 184 342 83 196617 expr ($f1*2)+1;#P newex 191 182 166 196617 jcom.list2parameter.mxt 3;#P objectname list2parameter;#P hidden newex 7 321 31 196617 t b i;#P hidden newex 7 264 67 196617 loadmess $1;#P hidden newex 7 286 96 196617 if $i1 != 0 then $i1;#P window linecount 3;#P hidden newex 28 363 351 196617 sprintf script new parameter newex 391 200 270 196617 jcom.parameter microphones/%ld/position @type msg_list @priority %ld @repetitions 0 @description "Position_in_xyz_coodinate_of_the_microphone %ld";#P window linecount 2;#P hidden message 7 419 223 196617 script connect list2parameter 10 parameter 0 \, script connect parameter 0 list2parameter 10;#P window linecount 1;#N thispatcher;#Q end;#P hidden newobj 655 717 61 196617 thispatcher;#P newex 280 152 39 196617 pvar Z;#P objectname pvar_Z;#P newex 234 151 40 196617 pvar Y;#P objectname pvar_Y;#P newex 192 151 40 196617 pvar X;#P objectname pvar_X;#P flonum 95 0 35 9 0 0 8224 3 198 198 198 221 221 221 222 222 222 0 0 0;#P objectname X;#P comment 25 2 72 196617 microphone $1;#B frgb 172 172 172;#P user panel -1 -1 526 19;#X brgb 80 80 80;#X frgb 255 255 255;#X border 1;#X rounded 0;#X shadow 0;#X done;#P hidden connect 67 0 66 0;#P hidden connect 10 0 9 0;#P fasten 24 0 9 0 85 283 12 283;#P hidden connect 9 0 11 0;#P connect 11 0 7 0;#P connect 9 0 73 0;#P connect 73 0 74 0;#P connect 73 1 72 0;#P fasten 11 1 8 0 33 350 33 350;#P connect 9 0 53 0;#P connect 53 0 54 0;#P connect 53 1 52 0;#P fasten 11 1 13 0 33 339 189 339;#P connect 3 0 12 0;#P fasten 12 0 3 0 196 206 182 206 182 150 197 150;#P connect 75 0 72 1;#P hidden connect 13 0 8 1;#P connect 4 0 12 1;#P connect 73 1 75 0;#P connect 5 0 12 2;#P fasten 12 1 4 0 211 210 177 210 177 144 239 144;#P connect 55 0 52 1;#P connect 53 1 55 0;#P connect 35 0 68 0;#P connect 68 0 67 0;#P fasten 12 2 5 0 226 214 172 214 172 139 285 139;#P hidden connect 40 0 30 0;#P hidden connect 36 0 35 0;#P hidden connect 37 0 35 0;#P hidden connect 35 0 40 0;#P hidden connect 40 1 38 0;#P hidden connect 40 0 38 0;#P hidden connect 38 0 39 0;#P connect 73 1 72 2;#P fasten 11 1 8 2 33 338 373 338;#P fasten 9 0 22 0 12 308 393 308;#P fasten 22 0 20 0 393 415 393 415;#P connect 22 1 21 0;#P hidden connect 40 1 33 0;#P hidden connect 64 0 33 0;#P connect 53 1 52 2;#P hidden connect 50 0 46 0;#P hidden connect 49 0 46 0;#P hidden connect 45 0 46 0;#P lcolor 6;#P fasten 22 1 23 0 410 345 566 345;#P hidden connect 23 0 21 1;#P connect 48 0 47 0;#P connect 47 0 49 0;#P connect 72 0 6 0;#P connect 26 0 6 0;#P connect 74 0 6 0;#P fasten 21 0 6 0 410 412 660 412;#P connect 54 0 6 0;#P fasten 44 0 6 0 1122 466 660 466;#P connect 25 0 6 0;#P hidden fasten 7 0 6 0 12 462 660 462;#P fasten 20 0 6 0 393 467 660 467;#P hidden fasten 8 0 6 0 33 408 660 408;#P connect 52 0 6 0;#P fasten 41 0 6 0 1114 452 660 452;#P connect 47 1 50 0;#P fasten 19 0 17 0 689 250 671 250 671 193 680 193;#P fasten 17 0 19 0 680 222 689 222;#P fasten 18 0 19 1 724 218 702 218;#P fasten 19 1 18 0 702 257 668 257 668 186 724 186;#P hidden connect 33 0 63 0;#P fasten 22 1 21 2 410 345 756 345;#P fasten 9 0 27 0 12 308 770 308;#P connect 27 0 25 0;#P fasten 27 1 26 0 787 348 787 348;#P connect 58 0 60 0;#P connect 60 0 62 0;#P connect 62 0 61 0;#P hidden connect 28 0 26 1;#P fasten 27 1 28 0 787 338 941 338;#P connect 59 0 60 1;#P fasten 27 1 26 2 787 338 1093 338;#P connect 9 0 42 0;#P connect 42 1 41 0;#P connect 42 0 44 0;#P connect 56 0 57 0;#P connect 43 0 41 1;#P connect 56 1 58 0;#P fasten 42 1 43 0 1120 327 1289 327;#P fasten 42 1 41 2 1120 326 1400 326;#P pop;