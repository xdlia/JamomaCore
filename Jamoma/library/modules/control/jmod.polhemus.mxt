max v2;#N vpatcher 70 44 888 440;#P origin 10 -64;#P window setfont "Sans Serif" 9.;#P user umenu 184 28 39 196647 1 64 44 1;#X add 1000;#X add 500;#X add 100;#X add 50;#P hidden newex 476 231 90 196617 pvar sample_rate;#P window linecount 2;#P hidden newex 476 253 314 196617 jcom.parameter sample_rate @type msg_int @ramp 1 @repetitions 0 @range -1 1000 @clipmode low @description "Turn polling on";#P objectname sample_rate[1];#P number 143 28 35 9 -1 0 8225 3 0 0 0 221 221 221 222 222 222 0 0 0;#P objectname sample_rate;#P user jsui 47 27 20 15 1 0 0 jcom.jsui_texttoggle.js off on;#P objectname status;#P window linecount 1;#P hidden newex 476 158 49 196617 pvar init;#P window linecount 2;#P hidden newex 476 180 257 196617 jcom.message init @type generic @clipmode none @description "Initialization of devices";#P objectname jcom.parameter[3];#P window linecount 1;#P hidden newex 476 81 62 196617 pvar status;#P window linecount 2;#P hidden newex 476 103 223 196617 jcom.parameter status @type toggle @clipmode none @description "Turn polling on";#P objectname status[1];#P window linecount 1;#P hidden newex 175 164 45 196617 pcontrol;#P hidden newex 175 140 91 196617 jcom.pass open;#P hidden message 38 69 50 196617 /autodoc;#P window linecount 2;#P hidden message 16 229 66 196617 \; max refresh;#P hidden message 16 195 75 196617 \; jcom.init bang;#P window linecount 1;#P hidden newex 175 256 114 196617 jalg.polhemus.mxt $0_;#P window linecount 2;#P hidden newex 16 94 329 196617 jcom.hub jmod.polhemus @size 1U-half @module_type control @description "Use polhemus.";#P objectname jcom.hub;#P hidden inlet 16 70 13 0;#P hidden outlet 16 167 13 0;#P window linecount 3;#P hidden newex 350 94 79 196617 pattrstorage @autorestore 0 @savemode 0;#X client_rect 14 59 654 299;#X storage_rect 0 0 640 240;#P objectname u054000310;#P window linecount 1;#P hidden message 281 223 153 196617 /hi_on 0;#P hidden newex 281 201 61 196617 prepend set;#P comment 88 30 63 196617 sample rate;#P bpatcher 0 0 256 62 0 0 jcom.gui.mxt 0 $0_;#P objectname jcom.gui.1Uh.a.stereo;#P hidden fasten 11 0 7 0 43 88 21 88;#P hidden connect 6 0 7 0;#P hidden connect 7 0 5 0;#P hidden connect 7 1 12 0;#P hidden connect 12 0 13 0;#P hidden fasten 12 1 8 0 261 192 180 192;#P hidden connect 13 0 8 0;#P hidden fasten 12 1 2 0 261 178 286 178;#P hidden connect 2 0 3 0;#P hidden fasten 14 0 15 0 481 136 469 136 469 76 481 76;#P hidden connect 15 0 14 0;#P hidden connect 17 0 16 0;#P hidden fasten 20 0 21 0 481 286 469 286 469 226 481 226;#P hidden connect 21 0 20 0;#P pop;