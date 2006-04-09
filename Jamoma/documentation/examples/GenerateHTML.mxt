max v2;
#N vpatcher 19 39 1046 852;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 135 350 27 9109513 qlim;
#P newex 142 210 27 9109513 qlim;
#N vpatcher 15 55 615 455;
#P window setfont "Sans Serif" 9.;
#P newex 90 95 47 9109513 tosymbol;
#P newex 90 73 211 9109513 sprintf %s/documentation/html/modules/%s.html;
#P newex 50 50 172 9109513 regexp (.*)/library/modules/.*/(.*)\\\\.mod;
#P inlet 50 30 15 0;
#P outlet 90 119 15 0;
#P connect 1 0 2 0;
#P connect 2 1 3 0;
#P connect 3 0 4 0;
#P connect 4 0 0 0;
#P pop;
#P newobj 212 437 49 9109513 p genpath;
#P newex 104 486 126 9109513 prepend /themodule/autodoc;
#P newex 104 463 118 9109513 zl reg;
#P newex 104 440 27 9109513 qlim;
#P newex 104 568 157 9109513 route /themodule/autodoc_complete;
#P newex 104 546 118 9109513 r jmod.remote.fromModule;
#P newex 104 509 108 9109513 s jmod.remote.toModule;
#P button 142 192 15 0;
#P newex 104 658 27 9109513 qlim;
#P newex 104 591 27 9109513 qlim;
#P newex 104 418 54 9109513 delay 5000;
#P newex 104 396 27 9109513 qlim;
#P window linecount 2;
#P message 169 397 69 9109513 \; jmod.init bang;
#P window linecount 1;
#P newex 104 374 75 9109513 b 2;
#P newex 104 350 27 9109513 qlim;
#P newex 104 328 54 9109513 delay 1000;
#P message 177 637 108 9109513 script delete /themodule;
#P newex 104 614 83 9109513 b 2;
#N thispatcher;
#Q end;
#P newobj 281 668 54 9109513 thispatcher;
#P window linecount 2;
#P newex 281 343 141 9109513 prepend script new /themodule newex 450 450 35 472055817;
#P comment 8 167 73 9109513 just the module file names...;
#P window setfont "Sans Serif" 12.;
#P comment 116 24 154 9109516 GENERATE NEW HTML FOR ALL MODULES!;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 85 170 89 9109513 regexp .*/(.*\\\\.mod);
#P message 104 696 39 9109513 resume;
#P newex 104 636 54 9109513 delay 1000;
#P newex 104 263 27 9109513 t b l;
#P newex 129 290 68 9109513 print MODULE;
#P newex 255 277 27 9109513 - 1;
#P newex 221 253 44 9109513 t pause i;
#P newex 191 231 40 9109513 uzi;
#P comment 227 195 52 9109513 num items;
#P number 191 194 35 9 0 0 0 139 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 191 170 67 9109513 route populate;
#P button 85 27 29 0;
#P message 85 64 43 9109513 populate;
#P newex 134 106 68 9109513 prepend prefix;
#P newex 134 84 61 9109513 absolutepath;
#P message 134 64 43 9109513 modules;
#P comment 468 69 175 9109513 - needs return of "/autodoc done";
#P comment 471 242 226 9109513 D. Remove the module;
#P window linecount 2;
#P comment 482 208 226 9109513 iii. actually send the /autodoc message with the dstpath as an argument;
#P comment 483 177 226 9109513 ii. from that path generate a new path for where the html should go;
#P window linecount 1;
#P comment 483 160 226 9109513 i. get the path of the module;
#P comment 474 140 226 9109513 C. Send it the /autodoc message;
#P comment 473 121 226 9109513 B. Initialize it;
#P comment 473 102 226 9109513 A. Create it;
#P comment 271 233 98 9109513 2. For each module...;
#P user ubumenu 85 141 138 9109513 0 1 1 0;
#X add audio;
#X add audio/jmod.ambi.decode~.mod;
#X add audio/jmod.ambi.encodeM~.mod;
#X add audio/jmod.crossfade~.mod;
#X add audio/jmod.degradeM~.mod;
#X add audio/jmod.degrade~.mod;
#X add audio/jmod.echo~.mod;
#X add audio/jmod.filterM~.mod;
#X add audio/jmod.filter~.mod;
#X add audio/jmod.input~.mod;
#X add audio/jmod.limiter~.mod;
#X add audio/jmod.noisegateM~.mod;
#X add audio/jmod.noisegate~.mod;
#X add audio/jmod.output~.mod;
#X add audio/jmod.saturation~.mod;
#X add control;
#X add control/jmod.control.mod;
#X add control/jmod.cuelist.mod;
#X add control/jmod.hi.mod;
#X add control/jmod.mapper.mod;
#X add control/jmod.oscnet.mod;
#X add control/jmod.qmetro.mod;
#X add video;
#X add video/jmod.brcosa%.mod;
#X add video/jmod.edge%.mod;
#X add video/jmod.mblur%.mod;
#X add video/jmod.motion%.mod;
#X add video/jmod.op%.mod;
#X add video/jmod.orsize%.mod;
#X add video/jmod.wake%.mod;
#X prefix_set 0 0 E:/Electrotap/Jamoma/library/modules/ 3;
#P comment 224 142 186 9109513 1. Build a list of Modules in the searchpath;
#P comment 461 37 100 9109513 NEEDS IN THE HUB;
#P comment 475 51 175 9109513 - autodoc needs to be a legit message;
#P window linecount 9;
#P comment 8 336 72 9109513 all of this delaying and deferring is here mostly from superstition \, not because of any testing or rational reason...;
#P comment 8 552 72 9109513 when the HTML generation is done \, the module sends us a message - then we can clean up and move on to the next module...;
#P connect 19 0 18 0;
#P connect 17 0 5 0;
#P connect 18 0 5 0;
#P fasten 25 0 5 0 260 303 414 303 414 133 90 133;
#P fasten 5 1 30 0 154 164 90 164;
#P connect 30 1 27 0;
#P connect 27 0 37 0;
#P connect 37 0 38 0;
#P connect 54 0 39 0;
#P connect 39 0 41 0;
#P connect 41 0 42 0;
#P connect 42 0 49 0;
#P connect 49 0 50 0;
#P connect 50 0 51 0;
#P connect 51 0 46 0;
#P connect 47 0 48 0;
#P connect 48 0 43 0;
#P connect 43 0 35 0;
#P connect 35 0 28 0;
#P connect 28 0 44 0;
#P fasten 53 0 29 0 147 238 90 257 90 686 109 686;
#P connect 44 0 29 0;
#P connect 27 1 26 0;
#P connect 19 0 15 0;
#P connect 15 0 16 0;
#P connect 16 0 17 0;
#P connect 38 0 54 0;
#P connect 30 3 45 0;
#P connect 45 0 53 0;
#P connect 39 1 40 0;
#P connect 35 1 36 0;
#P fasten 5 2 20 0 218 164 196 164;
#P connect 20 0 21 0;
#P connect 24 0 23 0;
#P connect 21 0 23 0;
#P fasten 29 0 23 0 109 724 439 724 439 225 196 225;
#P lcolor 14;
#P connect 5 1 52 0;
#P lcolor 14;
#P connect 52 0 50 1;
#P connect 23 2 24 0;
#P connect 24 1 25 0;
#P fasten 27 1 33 0 126 321 286 321;
#P connect 36 0 34 0;
#P connect 33 0 34 0;
#P pop;
