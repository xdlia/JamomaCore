max v2;#N vpatcher 65 89 918 551;#P window setfont "Sans Serif" 9.;#P hidden message 165 357 81 196617 /load_mappings;#P hidden newex 419 413 405 196617 jmod.message.mxt $0_ /view @description "View current mappings in a text window.";#P hidden newex 419 391 84 196617 pvar OpenButten;#P user jsui 110 23 51 22 1 0 0 jsui_textbutton.js View;#P objectname OpenButten;#P user jsui 14 23 93 22 1 0 0 jsui_textbutton.js "Load Cue Script";#P objectname LoadMappingsButton;#P hidden newex 419 297 124 196617 pvar LoadMappingsButton;#P window linecount 4;#P hidden newex 419 319 347 196617 jmod.message.mxt $0_ /load_mappings @description "Load mappings from file. <br/>NOTE: jmod.mappings will be watching the file and automatically update if the content of the file is changed. This way you can use an external editor to work on the cue script while Jamoma is running.";#P window linecount 2;#P hidden newex 419 204 298 196617 jmod.message.mxt $0_ /modify @description "Remove an existing mapping.  the required argument is the mapping_name.";#P hidden newex 419 167 298 196617 jmod.message.mxt $0_ /remove @description "Remove an existing mapping.  the required argument is the mapping_name.";#P window linecount 1;#P hidden newex 101 215 68 196617 prepend open;#P hidden newex 101 239 45 196617 pcontrol;#P hidden newex 101 191 103 196617 jmod.oscroute /open;#P hidden message 43 83 50 196617 /autodoc;#P window linecount 3;#P hidden newex 419 118 311 196617 jmod.message.mxt $0_ /create @description "Create a new mapping. Arguments are: [mapping_name] [mapping_source (OSC)] [optional algorithm to apply][ ->][mapping_destination (OSC)].";#P window linecount 2;#P hidden message 21 400 65 196617 \; max refresh;#P hidden message 21 363 75 196617 \; jmod.init bang;#P window linecount 1;#N vpatcher 119 212 942 758;#P window setfont "Sans Serif" 9.;#P window linecount 1;#P message 602 271 33 196617 clear;#P message 549 270 44 196617 compile;#P newex 602 202 66 196617 t dump clear;#P button 602 183 15 0;#P newex 688 124 108 196617 jmod.filewatcher.mxt;#P message 650 124 30 196617 open;#N thispatcher;#Q end;#P newobj 440 284 61 196617 thispatcher;#P newex 440 263 100 196617 js jmod.mappings.js;#P newex 440 235 176 196617 jmod.pass /modify /remove /create;#P newex 453 128 82 196617 prepend remove;#P newex 540 106 107 196617 zl join;#P newex 596 83 51 196617 zl ecils 2;#P newex 540 83 51 196617 zl slice 3;#P newex 540 128 72 196617 prepend store;#N coll jmod.mappings 1;#P newobj 540 162 104 196617 coll jmod.mappings 1;#P newex 452 58 344 196617 jmod.oscroute /modify /remove /create /view /load_mappings;#P outlet 440 312 15 0;#P inlet 440 36 15 0;#P comment 475 43 254 196617 /modify is first so that it will be executed the fastest;#P connect 1 0 10 0;#P connect 18 0 11 0;#P connect 17 0 11 0;#P fasten 16 1 11 0 663 259 445 259;#P connect 10 0 11 0;#P connect 11 0 12 0;#P connect 1 0 3 0;#P fasten 3 1 9 0 523 101 458 101;#P fasten 3 2 6 0 589 79 545 79;#P connect 6 0 8 0;#P connect 8 0 5 0;#P fasten 16 0 4 0 607 224 684 224 684 155 545 155;#P fasten 14 0 4 0 693 152 545 152;#P fasten 13 0 4 0 655 149 545 149;#P connect 5 0 4 0;#P connect 9 0 4 0;#P connect 6 1 7 0;#P connect 4 2 15 0;#P connect 15 0 16 0;#P connect 7 1 8 1;#P connect 3 3 13 0;#P connect 3 4 14 0;#P pop 1;#P hidden newobj 101 272 95 196617 p jmod.mapping.alg;#P hidden newex 419 36 88 196617 pvar ParameterA;#P window linecount 4;#P hidden newex 21 108 170 196617 jmod.hub $0_ jmod.mappings $1 @size 1U-half @module_type control @description "Create and manage mappings of parameters";#P objectname jmod.hub;#P hidden inlet 21 84 13 0;#P hidden outlet 21 310 13 0;#P window linecount 1;#P hidden newex 419 56 312 196617 jmod.parameter.mxt $0_ /param_a @repetitions 0 @type msg_int;#P objectname jmod.parameter.mxt;#P bpatcher 0 0 256 62 0 0 jmod.gui.mxt 0 $0_;#P objectname jmod.gui.1Uh.a.stereo.mxt;#P window linecount 3;#P hidden newex 215 108 79 196617 pattrstorage @autorestore 0 @savemode 0;#X client_rect 14 59 654 299;#X storage_rect 0 0 640 240;#P objectname jmod.mappings;#P window linecount 1;#P hidden message 207 273 153 196617 /view bang;#P hidden newex 207 252 61 196617 prepend set;#P hidden connect 6 0 7 0;#P hidden fasten 13 0 7 0 48 102 26 102;#P hidden connect 7 0 5 0;#P hidden fasten 9 0 5 0 106 303 26 303;#P hidden connect 7 1 14 0;#P hidden connect 14 0 16 0;#P hidden connect 16 0 15 0;#P hidden connect 25 0 9 0;#P hidden fasten 14 1 9 0 199 263 106 263;#P hidden connect 15 0 9 0;#P hidden connect 2 0 7 1;#P hidden fasten 14 1 0 0 199 243 212 243;#P hidden connect 0 0 1 0;#P hidden connect 7 2 2 0;#P hidden fasten 4 0 8 0 424 79 412 79 412 31 424 31;#P hidden connect 8 0 4 0;#P hidden connect 20 0 19 0;#P hidden connect 23 0 24 0;#P pop;