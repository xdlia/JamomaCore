max v2;
#N vpatcher 33 91 432 664;
#P window setfont "Sans Serif" 9.;
#P hidden newex 69 374 114 9109513 jcom.out~ 2;
#P hidden newex 69 313 143 9109513 jcom.in~ 2;
#P number 190 30 43 9 0 0 8225 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname Right;
#P window linecount 2;
#P hidden newex 38 77 297 9109513 jcom.message delay @ramp linear @repetitions 1 @range 0 1000000 @description "Delay time in samples to be applied to both channels.";
#P objectname jcom.parameter.mxb[9];
#P number 71 30 43 9 0 0 8225 139 198 198 198 221 221 221 222 222 222 0 0 0;
#P objectname Left;
#P window linecount 1;
#P comment 132 32 66 9109513 delay right;
#B frgb 172 172 172;
#P comment 22 32 48 9109513 delay left;
#B frgb 172 172 172;
#P hidden message 119 459 125 9109513 /documentation/generate;
#P hidden newex 12 198 57 9109513 pvar Right;
#P window linecount 2;
#P hidden newex 12 223 351 9109513 jcom.parameter delay/right @type msg_int @ramp linear @repetitions 0 @range 0 1000000 @clipmode both @description "Delay time in samples for right channel.";
#P objectname jcom.parameter[2];
#P window linecount 1;
#P hidden newex 12 124 52 9109513 pvar Left;
#P window linecount 2;
#P hidden newex 19 488 228 9109513 jcom.hub jmod.delay~ @size 1U-half @module_type audio @description "Sample-accurate stereo delay.";
#P objectname jcom.hub;
#P window linecount 1;
#P hidden comment 33 459 79 9109513 command input;
#P hidden inlet 19 459 13 0;
#P hidden message 246 459 23 9109513 /init;
#P hidden inlet 69 294 13 0;
#P hidden outlet 70 404 13 0;
#P window linecount 2;
#P hidden newex 12 149 347 9109513 jcom.parameter delay/left @type msg_int @ramp linear @repetitions 0 @range 0 1000000 @clipmode both @description "Delay time in samples for left channel.";
#P objectname jcom.parameter;
#P hidden inlet 202 294 13 0;
#P window linecount 1;
#P hidden newex 69 348 114 9109513 poly~ jalg.delay~.mxt;
#P hidden comment 92 294 105 9109513 ----signal inputs----;
#P hidden outlet 19 535 13 0;
#P hidden outlet 121 404 13 0;
#P hidden comment 70 418 101 9109513 ---signal outputs---;
#P bpatcher 0 0 256 60 0 0 jcom.gui.mxt 0;
#P objectname jcom.gui.1Uh.a.stereo.mxt;
#P hidden connect 21 1 14 0;
#P hidden fasten 7 0 14 0 17 185 7 185 7 117 17 117;
#P hidden connect 14 0 7 0;
#P hidden connect 21 1 16 0;
#P hidden fasten 15 0 16 0 17 259 7 259 7 191 17 191;
#P hidden connect 16 0 15 0;
#P hidden connect 11 0 13 0;
#P hidden fasten 17 0 13 0 124 480 24 480;
#P hidden fasten 10 0 13 0 251 482 24 482;
#P hidden connect 13 0 3 0;
#P hidden connect 9 0 23 0;
#P hidden connect 23 2 5 0;
#P hidden connect 23 0 5 0;
#P hidden connect 5 0 24 0;
#P hidden connect 24 0 8 0;
#P hidden connect 24 1 2 0;
#P hidden fasten 23 1 5 1 118 344 178 344;
#P hidden connect 5 1 24 1;
#P hidden connect 6 0 23 1;
#P pop;
