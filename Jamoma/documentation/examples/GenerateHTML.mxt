max v2;#N vpatcher 464 55 1296 824;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 375 545 40 196617 print a;#P newex 374 575 40 196617 print b;#P newex 302 263 27 196617 qlim;#P newex 289 239 27 196617 qlim;#P newex 286 214 27 196617 qlim;#P newex 78 214 56 196617 unpack s s;#P newex 316 81 182 196617 regexp !\\\\.svn.*/(jmod\\\\..*\\\\.mxt);#N vpatcher 50 59 650 459;#P window setfont "Sans Serif" 9.;#P newex 50 99 51 196617 tosymbol;#P newex 50 126 100 196617 sprintf %s/modules;#P message 136 149 33 196617 clear;#P newex 50 148 82 196617 prepend prefix;#P newex 50 70 61 196617 absolutepath;#P message 50 50 42 196617 library;#P inlet 50 30 15 0;#P outlet 50 196 15 0;#P connect 1 0 2 0;#P connect 2 0 3 0;#P connect 3 0 7 0;#P connect 7 0 6 0;#P connect 6 0 4 0;#P connect 4 0 0 0;#P connect 5 0 0 0;#P pop;#P newobj 142 67 60 196617 p;#P newex 112 581 46 196617 sel done;#P newex 143 353 27 196617 qlim;#P newex 283 294 27 196617 qlim;#N vpatcher 117 105 717 505;#P window setfont "Sans Serif" 9.;#P newex 90 140 47 196617 tosymbol;#P newex 90 97 211 196617 sprintf %s/documentation/html/modules/%s.html;#P newex 50 50 215 196617 regexp (.*)/library/modules/.*/(.*)\\\\.mxt;#P inlet 50 30 15 0;#P outlet 90 164 15 0;#P connect 1 0 2 0;#P connect 2 1 3 0;#P connect 3 0 4 0;#P connect 4 0 0 0;#P pop;#P newobj 220 440 49 196617 p genpath;#P newex 112 489 214 196617 prepend /themodule/documentation/generate;#P newex 112 466 118 196617 zl reg;#P newex 112 443 27 196617 qlim;#P newex 112 561 203 196617 route /themodule/documentation/generate;#P newex 112 541 188 196617 jcom.receive jcom.remote.module.from;#P newex 112 512 161 196617 jcom.send jcom.remote.module.to;#P button 267 194 15 0;#P newex 112 668 27 196617 qlim;#P newex 112 602 27 196617 qlim;#P newex 112 421 68 196617 delay 5000;#P newex 112 399 27 196617 qlim;#P newex 112 377 75 196617 b 2;#P newex 112 353 27 196617 qlim;#P newex 112 331 68 196617 delay 1000;#P message 185 647 127 196617 script delete /themodule;#P newex 112 624 83 196617 b 2;#N thispatcher;#Q end;#P newobj 337 671 68 196617 thispatcher;#P window linecount 2;#P newex 337 346 160 196617 prepend script new /themodule newex 450 450 35 472055817;#P comment 6 170 87 196617 just the module file names...;#P window setfont "Sans Serif" 12.;#P comment 124 27 154 196620 GENERATE NEW HTML FOR ALL MODULES!;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P newex 93 173 245 196617 regexp .*/(audio|video|control)/(jmod\\\\..*\\\\.mxt);#P message 112 699 39 196617 resume;#P newex 112 646 68 196617 delay 1000;#P newex 112 266 27 196617 t b l;#P newex 137 293 68 196617 print MODULE;#P newex 408 280 27 196617 - 1;#P newex 374 256 44 196617 t pause i;#P newex 344 234 40 196617 uzi;#P comment 380 198 52 196617 num items;#P number 344 197 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;#P newex 344 173 81 196617 route populate;#P button 93 30 29 0;#P message 93 67 43 196617 populate;#P comment 563 250 226 196617 D. Remove the module;#P window linecount 2;#P comment 574 216 226 196617 iii. actually send the /autodoc message with the dstpath as an argument;#P comment 575 185 226 196617 ii. from that path generate a new path for where the html should go;#P window linecount 1;#P comment 575 168 226 196617 i. get the path of the module;#P comment 566 148 226 196617 C. Send it the /autodoc message;#P comment 565 129 226 196617 B. Initialize it;#P comment 565 110 226 196617 A. Create it;#P comment 395 236 98 196617 2. For each module...;#P user ubumenu 93 144 138 196617 0 1 1 0;#X add .svn;#X add .svn/all-wcprops;#X add .svn/entries;#X add .svn/format;#X add .svn/prop-base;#X add .svn/props;#X add .svn/text-base;#X add .svn/tmp;#X add .svn/tmp/prop-base;#X add .svn/tmp/props;#X add .svn/tmp/text-base;#X add audio;#X add audio/.svn;#X add audio/.svn/all-wcprops;#X add audio/.svn/entries;#X add audio/.svn/format;#X add audio/.svn/prop-base;#X add audio/.svn/prop-base/jmod.crossfade~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.degrade~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.filter~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.input~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.limiter~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.noisegate~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.output~.mxt.svn-base;#X add audio/.svn/prop-base/jmod.saturation~.mxt.svn-base;#X add audio/.svn/props;#X add audio/.svn/text-base;#X add audio/.svn/text-base/jmod.crossfade~.mxt.svn-base;#X add audio/.svn/text-base/jmod.degrade~.mxt.svn-base;#X add audio/.svn/text-base/jmod.delay~.mxt.svn-base;#X add audio/.svn/text-base/jmod.echo~.mxt.svn-base;#X add audio/.svn/text-base/jmod.filter~.mxt.svn-base;#X add audio/.svn/text-base/jmod.input~.mxt.svn-base;#X add audio/.svn/text-base/jmod.limiter~.mxt.svn-base;#X add audio/.svn/text-base/jmod.multi_filter~.mxt.svn-base;#X add audio/.svn/text-base/jmod.multidelay~.mxt.svn-base;#X add audio/.svn/text-base/jmod.noisegate~.mxt.svn-base;#X add audio/.svn/text-base/jmod.output~.mxt.svn-base;#X add audio/.svn/text-base/jmod.saturation~.mxt.svn-base;#X add audio/.svn/text-base/jmod.scope~.mxt.svn-base;#X add audio/.svn/text-base/jmod.sur.ambi.adjust~.mx#11C840;#X add audio/.svn/text-base/jmod.sur.ambi.decode~.mx#11C2CE;#X add audio/.svn/text-base/jmod.sur.ambi.encodeM~.m#11C288;#X add audio/.svn/text-base/jmod.sur.doppler~.mxt.svn-base;#X add audio/.svn/text-base/jmod.sur.multi.in~.mxt.svn-base;#X add audio/.svn/text-base/jmod.sur.multi.out~.mxt.#11C2A3;#X add audio/.svn/text-base/jmod.sur.output~.mxt.svn-base;#X add audio/.svn/text-base/jmod.sur.speaker.delay~.#11C834;#X add audio/.svn/text-base/jmod.sur.vbap~.mxt.svn-base;#X add audio/.svn/tmp;#X add audio/.svn/tmp/prop-base;#X add audio/.svn/tmp/props;#X add audio/.svn/tmp/text-base;#X add audio/jmod.crossfade~.mxt;#X add audio/jmod.degrade~.mxt;#X add audio/jmod.delay~.mxt;#X add audio/jmod.echo~.mxt;#X add audio/jmod.filter~.mxt;#X add audio/jmod.input~.mxt;#X add audio/jmod.limiter~.mxt;#X add audio/jmod.multi_filter~.mxt;#X add audio/jmod.multidelay~.mxt;#X add audio/jmod.noisegate~.mxt;#X add audio/jmod.output~.mxt;#X add audio/jmod.saturation~.mxt;#X add audio/jmod.scope~.mxt;#X add audio/jmod.sur.ambi.adjust~.mxt;#X add audio/jmod.sur.ambi.decode~.mxt;#X add audio/jmod.sur.ambi.encodeM~.mxt;#X add audio/jmod.sur.doppler~.mxt;#X add audio/jmod.sur.multi.in~.mxt;#X add audio/jmod.sur.multi.out~.mxt;#X add audio/jmod.sur.output~.mxt;#X add audio/jmod.sur.speaker.delay~.mxt;#X add audio/jmod.sur.vbap~.mxt;#X add control;#X add control/.svn;#X add control/.svn/all-wcprops;#X add control/.svn/entries;#X add control/.svn/format;#X add control/.svn/prop-base;#X add control/.svn/prop-base/jmod.control.mxt.svn-base;#X add control/.svn/prop-base/jmod.cuelist.mxt.svn-base;#X add control/.svn/prop-base/jmod.qmetro.mxt.svn-base;#X add control/.svn/props;#X add control/.svn/text-base;#X add control/.svn/text-base/jmod.cont_mapper.mxt.svn-base;#X add control/.svn/text-base/jmod.control.mxt.svn-base;#X add control/.svn/text-base/jmod.cpu_test.mxt.svn-base;#X add control/.svn/text-base/jmod.cuelist.mxt.svn-base;#X add control/.svn/text-base/jmod.hi.mxt.svn-base;#X add control/.svn/text-base/jmod.mapper.mxt.svn-base;#X add control/.svn/text-base/jmod.midiin.mxt.svn-base;#X add control/.svn/text-base/jmod.mouse.mxt.svn-base;#X add control/.svn/text-base/jmod.oscnet.mxt.svn-base;#X add control/.svn/text-base/jmod.phidgets.mxt.svn-base;#X add control/.svn/text-base/jmod.qmetro.mxt.svn-base;#X add control/.svn/text-base/jmod.sur.speaker.setup.m#11C277;#X add control/.svn/tmp;#X add control/.svn/tmp/prop-base;#X add control/.svn/tmp/props;#X add control/.svn/tmp/text-base;#X add control/jmod.cont_mapper.mxt;#X add control/jmod.control.mxt;#X add control/jmod.cpu_test.mxt;#X add control/jmod.cuelist.mxt;#X add control/jmod.hi.mxt;#X add control/jmod.mapper.mxt;#X add control/jmod.midiin.mxt;#X add control/jmod.mouse.mxt;#X add control/jmod.phidgets.mxt;#X add control/jmod.qmetro.mxt;#X add control/jmod.sur.speaker.setup.mxt;#X add video;#X add video/.svn;#X add video/.svn/all-wcprops;#X add video/.svn/entries;#X add video/.svn/format;#X add video/.svn/prop-base;#X add video/.svn/prop-base/jmod.brcosa%.mxt.svn-base;#X add video/.svn/prop-base/jmod.edge%.mxt.svn-base;#X add video/.svn/prop-base/jmod.mblur%.mxt.svn-base;#X add video/.svn/prop-base/jmod.motion%.mxt.svn-base;#X add video/.svn/prop-base/jmod.op%.mxt.svn-base;#X add video/.svn/prop-base/jmod.orsize%.mxt.svn-base;#X add video/.svn/prop-base/jmod.wake%.mxt.svn-base;#X add video/.svn/props;#X add video/.svn/text-base;#X add video/.svn/text-base/jmod.avg4%.mxt.svn-base;#X add video/.svn/text-base/jmod.brcosa%.mxt.svn-base;#X add video/.svn/text-base/jmod.edge%.mxt.svn-base;#X add video/.svn/text-base/jmod.emboss%.mxt.svn-base;#X add video/.svn/text-base/jmod.fluoride%.mxt.svn-base;#X add video/.svn/text-base/jmod.input%.mxt.svn-base;#X add video/.svn/text-base/jmod.mblur%.mxt.svn-base;#X add video/.svn/text-base/jmod.motion%.mxt.svn-base;#X add video/.svn/text-base/jmod.op%.mxt.svn-base;#X add video/.svn/text-base/jmod.orsize%.mxt.svn-base;#X add video/.svn/text-base/jmod.output%.mxt.svn-base;#X add video/.svn/text-base/jmod.plur%.mxt.svn-base;#X add video/.svn/text-base/jmod.wake%.mxt.svn-base;#X add video/.svn/text-base/jmod.xfade%.mxt.svn-base;#X add video/.svn/tmp;#X add video/.svn/tmp/prop-base;#X add video/.svn/tmp/props;#X add video/.svn/tmp/text-base;#X add video/jmod.avg4%.mxt;#X add video/jmod.brcosa%.mxt;#X add video/jmod.edge%.mxt;#X add video/jmod.emboss%.mxt;#X add video/jmod.fluoride%.mxt;#X add video/jmod.input%.mxt;#X add video/jmod.mblur%.mxt;#X add video/jmod.motion%.mxt;#X add video/jmod.op%.mxt;#X add video/jmod.orsize%.mxt;#X add video/jmod.output%.mxt;#X add video/jmod.plur%.mxt;#X add video/jmod.wake%.mxt;#X add video/jmod.xfade%.mxt;#X prefix_set 0 0 lime:/Users/tim/Developer/Jamoma/library/modules/ 3;#P comment 232 145 205 196617 1. Build a list of Modules in the searchpath;#P window linecount 8;#P comment 16 339 86 196617 all of this delaying and deferring is here mostly from superstition \, not because of any testing or rational reason...;#P window linecount 9;#P comment 16 555 81 196617 when the HTML generation is done \, the module sends us a message - then we can clean up and move on to the next module...;#P connect 24 1 51 0;#P connect 13 0 12 0;#P connect 12 0 3 0;#P fasten 19 0 3 0 413 306 521 306 521 136 98 136;#P connect 49 0 3 0;#P fasten 3 1 24 0 162 167 98 167;#P connect 51 1 21 0;#P connect 21 0 31 0;#P connect 31 0 32 0;#P connect 47 0 33 0;#P connect 33 0 34 0;#P connect 34 0 35 0;#P connect 35 0 42 0;#P connect 42 0 43 0;#P connect 43 0 44 0;#P connect 44 0 39 0;#P connect 40 0 41 0;#P connect 41 0 48 0;#P connect 48 0 36 0;#P connect 36 0 29 0;#P connect 29 0 22 0;#P connect 22 0 37 0;#P fasten 46 0 23 0 288 241 98 260 98 689 117 689;#P connect 37 0 23 0;#P connect 21 1 20 0;#P connect 13 0 49 0;#P connect 32 0 47 0;#P connect 29 1 30 0;#P connect 3 1 45 0;#P lcolor 14;#P connect 45 0 43 1;#P connect 24 3 38 0;#P connect 54 0 46 0;#P connect 38 0 52 0;#P connect 52 0 53 0;#P connect 53 0 54 0;#P fasten 21 1 27 0 134 324 342 324;#P connect 30 0 28 0;#P connect 27 0 28 0;#P connect 3 2 14 0;#P connect 14 0 15 0;#P connect 18 0 17 0;#P connect 15 0 17 0;#P fasten 23 0 17 0 117 727 503 727 503 228 349 228;#P lcolor 14;#P connect 17 2 18 0;#P connect 40 0 55 0;#P connect 44 0 56 0;#P connect 18 1 19 0;#P pop;