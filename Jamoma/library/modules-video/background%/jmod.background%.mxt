max v2;#N vpatcher 302 82 1180 463;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P hidden newex 447 166 65 196617 pvar Record;#P window linecount 2;#P hidden newex 447 188 246 196617 jcom.parameter record @type msg_int @description "Turn on recording of the background image.";#P objectname record;#P toggle 111 28 15 0;#P objectname Record;#P user umenu 5 28 100 196647 1 64 44 1;#X add Select mode;#X add Subtraction;#X add Foreground mask;#P objectname Mode;#P window linecount 1;#P hidden newex 44 281 49 196617 jcom.out;#P hidden inlet 144 165 13 0;#P hidden comment 159 166 65 196617 VIDEO INPUT;#P hidden newex 144 182 52 196617 jcom.in 1;#P hidden newex 44 230 47 196617 pcontrol;#P hidden newex 44 209 78 196617 jcom.pass open;#P hidden newex 445 92 57 196617 pvar Mode;#P window linecount 2;#P hidden newex 445 114 278 196617 jcom.parameter mode @type msg_int @description "Choose between four different background subtraction models.";#P objectname mode;#P window linecount 1;#P hidden message 99 86 125 196617 /documentation/generate;#B color 3;#P hidden comment 59 308 75 196617 VIDEO OUTPUT;#P hidden outlet 44 308 13 0;#P hidden newex 44 257 110 196617 jalg.background%.mxt;#P hidden comment 15 84 79 196617 command input;#P window linecount 2;#P hidden newex 1 109 378 196617 jcom.hub jmod.background% @size 1U-half @module_type video @algorithm_type jitter @description "Two different types of video background subtraction";#P objectname jcom.hub;#P hidden outlet 1 171 13 0;#P hidden inlet 1 84 13 0;#P comment 130 25 66 196617 Record background;#B frgb 149 149 149;#P bpatcher 0 0 256 60 0 0 jcom.gui.mxt 0;#P objectname jcom.gui;#P hidden connect 2 0 4 0;#P hidden fasten 9 0 4 0 104 105 6 105;#P hidden connect 4 0 3 0;#P hidden fasten 14 1 12 0 170 204 49 204;#P hidden connect 12 0 13 0;#P hidden connect 13 0 6 0;#P hidden fasten 12 1 6 0 117 250 49 250;#P hidden connect 6 0 17 0;#P hidden connect 17 0 7 0;#P hidden connect 16 0 14 0;#P hidden connect 14 0 6 1;#P hidden fasten 10 0 11 0 450 149 439 149 439 88 450 88;#P hidden connect 11 0 10 0;#P hidden fasten 20 0 21 0 452 223 441 223 441 162 452 162;#P hidden connect 21 0 20 0;#P pop;