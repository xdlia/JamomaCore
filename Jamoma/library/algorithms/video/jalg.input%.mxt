max v2;#N vpatcher 249 44 732 458;#P origin 10 16;#P window setfont "Sans Serif" 9.;#N vpatcher 259 132 430 285;#P outlet 55 72 15 0;#P inlet 55 30 15 0;#P connect 0 0 1 0;#P pop;#P newobj 55 107 37 196617 p thru;#P comment 67 359 65 196617 Dump output;#N vpatcher 576 77 1026 431;#P window setfont "Sans Serif" 9.;#P newex 37 48 108 196617 jcom.oscroute /synth;#P newex 203 212 122 196617 pak dim 320 240;#P message 37 213 72 196617 planecount \$1;#P number 141 139 26 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P toggle 71 139 15 0;#P newex 71 163 80 196617 qmetro 2;#P newex 37 246 121 196617 jit.noise 1 char 320 240;#P newex 37 85 381 196617 jcom.oscroute /noise/planes /noise/on /noise/rate /noise/size/x /noise/size/y;#P inlet 37 21 15 0;#P outlet 37 301 15 0;#P connect 1 0 9 0;#P connect 9 0 2 0;#P connect 2 0 7 0;#P connect 4 0 3 0;#P fasten 8 0 3 0 208 238 42 238;#P connect 7 0 3 0;#P connect 3 0 0 0;#P fasten 2 1 4 0 116 158 76 158;#P connect 5 0 4 0;#P fasten 2 2 4 1 190 159 146 159;#P connect 6 0 4 1;#P connect 2 3 8 1;#P connect 2 4 8 2;#P pop;#P newobj 313 179 117 196617 p video-synthesis-stuff;#N vpatcher 18 44 1061 611;#P origin 0 -16;#P toggle 559 313 15 0;#P window setfont "Sans Serif" 9.;#P newex 559 294 60 196617 loadmess 0;#P window linecount 1;#P message 559 332 62 196617 enable \$1 1;#P newex 559 351 47 196617 pcontrol;#N comlet Audio-right;#P outlet 628 411 15 0;#N comlet Audio-left;#P outlet 559 410 15 0;#N vpatcher 456 121 1100 400;#P inlet 83 56 15 0;#P window setfont "Sans Serif" 9.;#P newex 286 75 27 196617 + 1;#P newex 503 105 30 196617 !/ 1.;#P comment 459 104 51 196617 pitch scaling factor;#P number 286 96 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P newex 286 126 43 196617 gate~ 2;#P newex 50 125 43 196617 gate~ 2;#P newex 319 158 194 196617 pfft~ jcom.gizmo_transpose.mxt 4096 4;#P flonum 503 127 35 9 0. 0 1 3 0 0 0 221 221 221 222 222 222 0 0 0;#P newex 83 158 194 196617 pfft~ jcom.gizmo_transpose.mxt 4096 4;#P newex 83 75 100 196617 spigot~ from-movie;#P inlet 503 56 15 0;#P inlet 286 56 15 0;#P outlet 286 191 15 0;#P outlet 50 191 15 0;#P fasten 10 0 8 0 291 115 55 115;#P connect 8 0 0 0;#P fasten 5 0 0 0 88 184 55 184;#P connect 14 0 4 0;#P connect 4 0 8 1;#P connect 8 1 5 0;#P fasten 6 0 5 1 508 150 272 150;#P connect 2 0 13 0;#P connect 13 0 10 0;#P connect 10 0 9 0;#P connect 9 0 1 0;#P fasten 7 0 1 0 324 184 291 184;#P fasten 4 1 9 1 178 120 324 120;#P connect 9 1 7 0;#P connect 3 0 12 0;#P connect 12 0 6 0;#P connect 6 0 7 1;#P pop;#P newobj 559 372 79 196617 p pitch-shifting;#P newex 138 63 84 196617 jcom.pass /read;#P newex 138 41 98 196617 jcom.oscroute /file;#P window linecount 0;#P newex 740 240 54 196617 jcom.thru;#P message 740 155 88 196617 cancelframedump;#P newex 676 123 41 196617 sel 1 0;#P message 676 155 60 196617 framedump;#P newex 618 189 93 196617 prepend looppoints;#P newex 45 282 86 196617 r global_tomovie;#P newex 36 260 73 196617 r $0_tomovie;#N vpatcher 10 59 320 285;#P window setfont "Sans Serif" 9.;#P newex 50 50 164 196617 jcom.pass read moviedim duration;#P newex 50 87 32 196617 print;#P inlet 50 30 15 0;#P connect 0 0 2 0;#P connect 2 2 1 0;#P connect 2 1 1 0;#P connect 2 0 1 0;#P pop;#P newobj 274 330 67 196617 p print-stuff;#P button 354 192 15 0;#P newex 354 212 91 196617 pack dim 320 240;#P toggle 578 148 15 0;#P flonum 578 168 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P message 560 189 39 196617 vol \$1;#P newex 344 368 118 196617 jcom.pass time duration;#N vpatcher 20 74 175 202;#P outlet 74 65 15 0;#P inlet 74 35 15 0;#P connect 0 0 1 0;#P pop;#P newobj 344 416 37 196617 p thru;#N vpatcher 20 74 175 202;#P outlet 74 65 15 0;#P inlet 74 35 15 0;#P connect 0 0 1 0;#P pop;#P newobj 173 453 37 196617 p thru;#P window linecount 2;#P newex 173 400 69 196617 t getduration getmoviedim;#P window linecount 1;#P newex 173 367 156 196617 route read moviedim framedump;#P newex 216 300 51 196617 t gettime;#P newex 216 278 49 196617 qlim 250;#P newex 354 168 65 196617 route native;#P flonum 515 168 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P message 502 189 45 196617 time \$1;#P flonum 457 168 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P message 444 189 44 196617 rate \$1;#P toggle 312 172 15 0;#P message 299 193 43 196617 loop \$1;#P newex 240 204 45 196617 t stop 0;#P newex 225 182 49 196617 t 1 start;#P newex 225 159 41 196617 sel 1 0;#P toggle 225 134 15 0;#P newex 225 233 51 196617 qmetro 2;#P user umenu 354 145 62 196647 1 64 161 1;#X add native size;#X add 640 480;#X add 320 240;#X add 160 120;#X add 80 60;#P objectname file_size;#P newex 368 241 64 196617 prepend dim;#P newex 138 330 125 196617 jit.qt.movie @autostart 0;#P newex 212 88 533 196617 jcom.oscroute /read /on /loop /size /rate /counter /audio /loop_points /framedump;#P inlet 138 19 15 0;#P outlet 138 528 15 0;#P outlet 344 528 15 0;#P window linecount 0;#P comment 660 365 100 196617 I don't expect this to work yet \, since we cannot mix jcom.out and jcom.out~;#P comment 656 290 129 196617 Trond added 2007-07-15:;#B color 14;#P comment 656 304 311 196617 I am defaulting this to mute to save CPU. I am not convinced that this should be part of the module at all \, due to increase in DSP CPU usage (on my MacBookPro the subpatch introduce a 6% increase). Instead it could be taken care of by a separate transposing module.;#B color 14;#P connect 5 0 42 0;#P connect 42 0 43 0;#P fasten 10 0 7 0 230 270 143 270;#P fasten 32 0 7 0 359 270 143 270;#P fasten 29 0 7 0 565 270 143 270;#P fasten 8 0 7 0 373 270 143 270;#P fasten 15 0 7 0 304 270 143 270;#P fasten 17 0 7 0 449 270 143 270;#P fasten 19 0 7 0 507 270 143 270;#P fasten 23 0 7 0 221 323 143 323;#P fasten 26 0 7 0 178 482 119 420 119 305;#P connect 13 1 7 0;#P connect 14 0 7 0;#P fasten 36 0 7 0 50 316 143 316;#P fasten 35 0 7 0 41 329 143 329;#P fasten 41 0 7 0 745 270 143 270;#P connect 43 0 7 0;#P connect 7 0 4 0;#P fasten 7 1 24 0 258 356 178 356;#P connect 24 0 25 0;#P connect 25 1 26 0;#P connect 25 0 26 0;#P connect 43 1 6 0;#P connect 10 0 22 0;#P connect 22 0 23 0;#P connect 11 0 12 0;#P connect 6 1 12 0;#P connect 12 0 13 0;#P connect 13 0 10 0;#P connect 14 1 10 0;#P connect 12 1 14 0;#P connect 7 1 34 0;#P connect 16 0 15 0;#P connect 6 2 15 0;#P fasten 7 1 28 0 258 356 349 356;#P connect 28 0 27 0;#P connect 28 1 27 0;#P connect 27 0 3 0;#P connect 6 3 9 0;#P fasten 9 1 21 0 411 164 359 164;#P connect 21 0 33 0;#P connect 33 0 32 0;#P fasten 21 1 8 0 414 236 373 236;#P connect 24 1 32 1;#P lcolor 4;#P connect 18 0 17 0;#P connect 6 4 17 0;#P connect 20 0 19 0;#P connect 6 5 19 0;#P connect 49 0 50 0;#P connect 50 0 48 0;#P connect 48 0 47 0;#P connect 47 0 44 0;#P connect 44 0 45 0;#P connect 30 0 29 0;#P connect 6 6 29 0;#P connect 31 0 30 0;#P connect 6 7 37 0;#P connect 44 1 46 0;#P connect 6 8 39 0;#P connect 39 0 38 0;#P fasten 39 1 40 0 696 147 745 147;#P connect 37 0 41 0;#P connect 38 0 41 0;#P connect 40 0 41 0;#P pop;#P newobj 195 179 89 196617 p video-file-stuff;#N vpatcher 184 44 817 666;#P origin 209 -25;#P window setfont "Sans Serif" 9.;#P window linecount 0;#P newex 48 44 116 196617 jcom.oscroute /camera;#P newex 352 136 48 196617 loadbang;#P newex 289 136 58 196617 r jcom.init;#P newex 350 565 70 196617 s $1_camera;#P objectname thru2[2];#P newex 195 565 66 196617 s $1_device;#P objectname thru2[1];#P outlet 107 565 15 0;#P inlet 48 22 15 0;#N vpatcher 20 74 179 221;#P outlet 34 68 15 0;#P inlet 34 39 15 0;#P connect 0 0 1 0;#P pop;#P newobj 195 391 43 196617 p thru3;#P objectname thru3;#N vpatcher 20 74 179 221;#P outlet 34 68 15 0;#P inlet 34 39 15 0;#P connect 0 0 1 0;#P pop;#P newobj 107 391 43 196617 p thru2;#P objectname thru2;#P user umenu 188 135 52 196647 1 64 151 1;#X add 640 480;#X add 320 240;#X add 160 120;#X add 80 60;#P objectname camera_size;#P newex 188 157 64 196617 prepend dim;#P newex 289 162 54 196617 onebang 1;#P newex 63 157 49 196617 t close 0;#P newex 48 135 46 196617 t 1 open;#P newex 48 112 41 196617 sel 1 0;#P newex 195 444 25 196617 iter;#P newex 290 465 38 196617 t clear;#P newex 428 465 38 196617 t clear;#P message 350 510 45 196617 input \$1;#P user ubumenu 350 489 145 196617 0 1 1 0;#X prefix_set 0 0 <none> 0;#X pattrmode 1;#P newex 350 465 75 196617 prepend append;#P newex 350 444 25 196617 iter;#P message 195 510 58 196617 vdevice \$1;#P user ubumenu 195 489 145 196617 0 1 1 0;#X add "DV Video";#X add "IIDC FireWire Video";#X add "USB Video Class Video";#X prefix_set 0 0 <none> 0;#X pattrmode 1;#P newex 195 465 75 196617 prepend append;#P newex 195 414 112 196617 route vdevlist inputlist;#P message 352 202 59 196617 getinputlist;#P message 289 202 59 196617 getvdevlist;#P message 118 161 44 196617 settings;#N vpatcher 20 74 179 221;#P outlet 34 68 15 0;#P inlet 34 39 15 0;#P connect 0 0 1 0;#P pop;#P newobj 107 253 43 196617 p thru1;#P objectname thru1;#P toggle 60 89 15 0;#P newex 48 186 51 196617 qmetro 2;#P objectname qmetro;#P newex 48 69 364 196617 jcom.oscroute /on /settings /size /device /camera;#N vpatcher 607 201 1020 515;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P message 50 227 165 196617 script connect qmetro 0 grabber 0;#P window linecount 0;#P newex 92 110 88 196617 append 320 240;#P newex 92 88 262 196617 prepend script new grabber newex 107 304 98 196617;#P message 50 198 158 196617 script connect grabber 1 thru3 0;#P message 64 178 158 196617 script connect grabber 0 thru2 0;#P message 78 158 158 196617 script connect thru1 0 grabber 0;#P newex 50 50 53 196617 t b b b s;#P inlet 50 20 15 0;#P outlet 50 279 15 0;#P connect 1 0 2 0;#P connect 2 0 5 0;#P connect 2 0 8 0;#P connect 8 0 0 0;#P connect 3 0 0 0;#P connect 4 0 0 0;#P connect 7 0 0 0;#P connect 5 0 0 0;#P connect 2 1 4 0;#P connect 2 2 3 0;#P connect 2 3 6 0;#P connect 6 0 7 0;#P pop;#P newobj 476 102 85 196617 p script-grabber;#N vpatcher 796 44 1196 390;#P window setfont "Sans Serif" 9.;#P message 168 119 14 196617 1;#P message 122 121 34 196617 2047;#P newex 113 50 45 196617 loadbang;#P newex 50 75 51 196617 onebang 1;#P newex 273 156 28 196617 sel 0;#P newex 273 187 87 196617 print grab.ERROR;#P comment 57 177 21 196617 win;#P newex 127 200 67 196617 t jit.qt.grab;#P newex 50 200 69 196617 t jit.dx.grab;#P message 50 98 30 196617 sysv;#P newex 50 156 87 196617 split 1 2047;#P newex 50 121 36 196617 gestalt;#P newex 50 50 58 196617 r jcom.init;#P comment 139 177 26 196617 mac;#P outlet 50 261 15 0;#P fasten 12 0 11 0 118 71 55 71;#P connect 2 0 11 0;#P connect 11 0 5 0;#P connect 5 0 3 0;#P connect 13 0 4 0;#P connect 14 0 4 0;#P connect 3 0 4 0;#P connect 4 0 6 0;#P connect 7 0 0 0;#P connect 6 0 0 0;#P connect 4 1 7 0;#P fasten 3 1 10 0 81 146 278 146;#P connect 10 1 9 0;#P pop;#P newobj 476 66 81 196617 p check-system;#P window linecount 1;#N thispatcher;#Q end;#P newobj 476 139 68 196617 thispatcher;#P newex 107 304 98 196617 jit.qt.grab 320 240;#P newex 107 304 98 196617 jit.qt.grab 320 240;#P newex 107 304 98 196617 jit.qt.grab 320 240;#P objectname grabber;#P connect 32 0 38 0;#P connect 38 0 6 0;#P connect 6 0 24 0;#P connect 8 0 24 0;#P connect 24 0 25 0;#P connect 25 0 7 0;#P connect 26 1 7 0;#P connect 24 1 26 0;#P fasten 20 0 9 0 355 532 527 532 527 246 112 246;#P fasten 16 0 9 0 200 539 527 539 527 246 112 246;#P fasten 11 0 9 0 294 233 112 233;#P connect 10 0 9 0;#P fasten 12 0 9 0 357 233 112 233;#P connect 25 1 9 0;#P connect 26 0 9 0;#P connect 28 0 9 0;#P connect 7 0 0 0;#P connect 7 0 2 0;#P connect 7 0 1 0;#P connect 9 0 0 0;#P connect 9 0 2 0;#P connect 9 0 1 0;#P connect 0 0 30 0;#P connect 2 0 30 0;#P connect 1 0 30 0;#P connect 30 0 33 0;#P connect 6 1 10 0;#P connect 6 2 29 0;#P fasten 29 1 28 0 235 154 193 154;#P connect 0 1 31 0;#P connect 2 1 31 0;#P connect 1 1 31 0;#P connect 31 0 13 0;#P connect 13 0 23 0;#P connect 23 0 14 0;#P fasten 22 0 15 0 295 485 200 485;#P connect 6 3 15 0;#P connect 14 0 15 0;#P connect 15 0 16 0;#P connect 14 0 34 0;#P connect 22 0 34 0;#P fasten 37 0 27 0 357 157 294 157;#P connect 36 0 27 0;#P connect 27 0 11 0;#P fasten 13 0 22 0 200 438 295 438;#P fasten 13 1 17 0 251 434 355 434;#P connect 17 0 18 0;#P fasten 21 0 19 0 433 485 355 485;#P connect 6 4 19 0;#P connect 18 0 19 0;#P connect 19 0 20 0;#P connect 18 0 35 0;#P connect 21 0 35 0;#P fasten 27 0 12 0 294 190 357 190;#P fasten 13 1 21 0 251 434 433 434;#P connect 4 0 5 0;#P connect 5 0 3 0;#P pop;#P newobj 55 179 109 196617 p video-grabber-stuff;#N vpatcher 310 207 799 559;#P outlet 131 277 15 0;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 215 93 32 196617 sel 1;#P newex 135 93 32 196617 sel 1;#P message 54 215 74 196617 /camera_on 0;#P message 207 215 95 196617 /synth_noise_on 0;#P message 131 215 56 196617 /file_on 0;#P newex 55 93 32 196617 sel 1;#P newex 55 60 251 196617 jcom.oscroute /camera_on /file_on /synth_noise_on;#P inlet 55 30 15 0;#P window linecount 8;#P comment 341 115 100 196617 Not very elegant \, but this ensures that only one metro is running at a time. This was easier to implement than trying to have one main metro.;#P connect 7 0 6 0;#P connect 8 0 6 0;#P connect 1 0 2 0;#P connect 2 0 3 0;#P connect 3 0 4 0;#P connect 8 0 4 0;#P connect 6 0 9 0;#P connect 4 0 9 0;#P connect 5 0 9 0;#P connect 2 1 7 0;#P connect 3 0 5 0;#P connect 7 0 5 0;#P connect 2 2 8 0;#P pop;#P newobj 71 71 92 196617 p turn-off-metros;#P inlet 55 37 15 0;#P comment 189 359 65 196617 Video output;#N comlet video output;#P outlet 195 339 15 0;#P outlet 84 339 15 0;#P connect 3 0 9 0;#P connect 4 0 9 0;#P connect 9 0 5 0;#P connect 3 0 4 0;#P connect 6 1 0 0;#P connect 9 0 6 0;#P connect 7 0 1 0;#P connect 6 0 1 0;#P connect 5 0 1 0;#P connect 9 0 7 0;#P pop;