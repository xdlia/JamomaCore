max v2;
#N vpatcher 116 94 938 617;
#P origin 116 0;
#P window setfont "Sans Serif" 9.;
#N vpatcher 10 59 610 459;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 187 168 74 196617 r $1_setclock;
#P newex 187 195 56 196617 print ***;
#P newex 231 120 40 196617 t clock;
#P newex 231 100 59 196617 select max;
#P newex 280 120 71 196617 prepend clock;
#P newex 231 146 120 196617 send $1_setclock;
#P window linecount 3;
#P newex 50 50 322 196617 jmod.parameter.mxt $1 /set_clock @type msg_symbol @description "Sync module to external clock. <br><code>/set_clock max</code> set module to use the Max scheduler (default behaviour).";
#P objectname jmod.parameter[1];
#P connect 6 0 5 0;
#P fasten 0 1 3 0 367 96 236 96;
#P connect 3 0 4 0;
#P connect 4 0 1 0;
#P fasten 2 0 1 0 285 141 236 141;
#P connect 3 1 2 0;
#P pop;
#P newobj 648 102 69 196617 p clock_stuff;
#P objectname "sub patch[1]";
#N vpatcher 10 59 610 459;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P comment 50 158 140 196617 Max help patch:;
#P newex 297 273 45 196617 pcontrol;
#P newex 297 251 100 196617 sprintf help %s.mod;
#P newex 297 225 220 196617 t $2;
#P window linecount 2;
#P newex 50 184 257 196617 jmod.message.mxt $1 /documentation/help @range n/a @description "Open the help patch for the module.";
#P message 293 86 130 196617 \; max htmlref $2;
#P newex 50 50 253 196617 jmod.message.mxt $1 /help @range n/a @description "Open the online html reference for this module.";
#P window linecount 0;
#P comment 50 24 140 196617 HTML documentation:;
#P connect 1 1 2 0;
#P connect 3 1 4 0;
#P connect 4 0 5 0;
#P connect 5 0 6 0;
#P pop;
#P newobj 648 44 110 196617 p view_documentation;
#N vpatcher 10 59 610 459;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 166 88 20 196617 t b;
#P window linecount 2;
#P newex 50 50 294 196617 jmod.parameter $1 /ui/refresh @type msg_bang @description "Update displayed values for module to reflect current state.";
#P objectname jmod.parameter[2];
#P window linecount 1;
#P newex 166 109 119 196617 send $1_display_update;
#P newex 176 208 126 196617 send $1_freeze_display;
#P toggle 176 190 15 0;
#P window linecount 3;
#P newex 50 139 314 196617 jmod.parameter $1 /disable_ui_updates @type toggle @description "Turn off the updating of user interface elements when parameters change.  This may be done to conserve CPU resources.";
#P objectname jmod.parameter;
#P fasten 4 1 5 0 339 85 171 85;
#P connect 5 0 3 0;
#P fasten 0 1 1 0 359 185 181 185;
#P fasten 1 0 2 0 181 204 181 204;
#P pop;
#P newobj 648 73 128 196617 p /ui/freeze_and_refresh;
#P objectname "sub patch";
#N vpatcher 10 59 556 397;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 316 87 51 196617 zl slice 1;
#P window linecount 0;
#P newex 254 87 51 196617 zl slice 1;
#P window linecount 1;
#P newex 129 205 98 196617 if $i1==1 then bang;
#P newex 129 178 34 196617 zl len;
#P inlet 254 47 15 0;
#P newex 295 272 47 196617 forward;
#P newex 342 174 104 196617 route MODULE_TITLE;
#P newex 316 200 36 196617 zl reg;
#P newex 342 153 94 196617 r $1_FROM_MHUB;
#P newex 316 112 169 196617 t b s;
#P newex 316 226 169 196617 sprintf send /jmod/toModule%s%s;
#P window linecount 0;
#P comment 21 173 100 196617 This is required for osc messages with no arguments to be passed.;
#P connect 7 0 8 0;
#P connect 8 0 9 0;
#P connect 7 0 10 0;
#P connect 1 0 6 0;
#P connect 9 0 6 0;
#P connect 10 1 6 0;
#P connect 7 0 11 0;
#P connect 11 0 2 0;
#P connect 2 0 4 0;
#P connect 4 0 1 0;
#P connect 3 0 5 0;
#P connect 5 0 4 1;
#P connect 2 1 1 1;
#P pop;
#P newobj 248 156 93 196617 p send_instruction;
#N vpatcher 10 59 613 580;
#P window setfont "Sans Serif" 9.;
#P window linecount 0;
#P newex 34 197 98 196617 if $i1==1 then bang;
#P newex 34 165 34 196617 zl len;
#P window linecount 1;
#P newex 224 103 51 196617 zl slice 1;
#P window linecount 0;
#P newex 169 103 51 196617 zl slice 1;
#P inlet 169 66 15 0;
#P newex 210 347 47 196617 forward;
#P window linecount 1;
#P newex 250 234 104 196617 route MODULE_TITLE;
#P newex 224 260 36 196617 zl reg;
#P newex 250 213 94 196617 r $1_FROM_MHUB;
#P newex 224 146 182 196617 t b s;
#P newex 224 286 182 196617 sprintf send /jmod/fromModule%s%s;
#P connect 6 0 9 0;
#P connect 9 0 10 0;
#P connect 6 0 7 0;
#P connect 0 0 5 0;
#P connect 7 1 5 0;
#P connect 10 0 5 0;
#P connect 6 0 8 0;
#P connect 8 0 1 0;
#P connect 1 0 3 0;
#P connect 3 0 0 0;
#P connect 2 0 4 0;
#P connect 4 0 3 1;
#P connect 1 1 0 1;
#P pop;
#P newobj 113 458 72 196617 p unique_send;
#P newex 44 303 93 196617 s $1_FROM_MHUB;
#P newex 44 282 42 196617 t BUILD;
#P newex 44 261 57 196617 sel done;
#P newex 91 282 104 196617 prepend ATTRIBUTES;
#P newex 23 345 76 196617 r $1_feedback;
#N vpatcher 34 59 634 459;
#P outlet 98 62 15 0;
#P inlet 98 33 15 0;
#P connect 0 0 1 0;
#P pop;
#P newobj 11 409 37 196617 p thru;
#N vpatcher 441 262 1254 601;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 530 147 104 196617 route MODULE_TITLE;
#P window linecount 0;
#P newex 426 205 36 196617 zl reg;
#P window linecount 1;
#P newex 530 126 94 196617 r $1_FROM_MHUB;
#P comment 426 301 121 196617 Instant remote reporting;
#P newex 426 252 94 196617 zl join;
#P window linecount 0;
#P newex 426 148 30 196617 t b s;
#P newex 426 126 94 196617 zl slice 1;
#P newex 426 231 72 196617 sprintf %s%s;
#P window linecount 1;
#P newex 426 275 131 196617 s jmod.remote.fromModule;
#P newex 29 71 285 196617 jmod.oscroute /parameter_name;
#N comlet connect to left outlet of module;
#P inlet 29 36 15 0;
#P newex 304 191 71 196617 prepend store;
#P newex 304 167 66 196617 zl join;
#P newex 304 141 50 196617 zl slice 1;
#N coll $0_state 1;
#P newobj 304 214 79 196617 coll $0_state 1;
#P window linecount 2;
#P comment 304 240 94 196617 Collect messages as current state;
#P connect 5 0 6 0;
#P connect 6 1 2 0;
#P connect 2 0 3 0;
#P connect 3 0 4 0;
#P connect 4 0 1 0;
#P fasten 6 1 3 1 309 131 365 131;
#P fasten 6 1 9 0 309 102 431 102;
#P connect 9 0 10 0;
#P connect 10 0 14 0;
#P connect 14 0 8 0;
#P connect 8 0 11 0;
#P connect 11 0 7 0;
#P connect 15 0 14 1;
#P connect 10 1 8 1;
#P connect 9 1 11 1;
#P connect 13 0 15 0;
#P pop;
#P newobj 28 458 81 196617 p current_state;
#N vpatcher 206 44 793 253;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 204 119 104 196617 route MODULE_TITLE;
#P newex 204 99 94 196617 r $1_FROM_MHUB;
#P window linecount 0;
#P newex 404 58 118 196617 r jmod.remote.state.get;
#P window linecount 1;
#P newex 404 114 133 196617 s jmod.remote.state.return;
#P window linecount 0;
#P newex 34 57 223 196617 jmod.route @searchstring "0" @partialmatch 1;
#P window linecount 1;
#P newex 140 139 74 196617 jmod.oscroute;
#N vpatcher 34 89 822 586;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 170 232 36 196617 zl reg;
#P window linecount 0;
#P newex 425 294 35 196617 t cr b;
#P newex 476 193 89 196617 prepend # Module;
#P newex 450 319 36 196617 zl reg;
#P window linecount 1;
#P newex 476 151 104 196617 route MODULE_TITLE;
#P newex 476 130 94 196617 r $1_FROM_MHUB;
#P window linecount 2;
#P comment 286 90 109 196617 Dump all current parameter values;
#P window linecount 1;
#P newex 170 115 68 196617 route symbol;
#N coll $1_registered_parameters 1;
#P newobj 120 89 161 196617 coll $1_registered_parameters 1;
#P outlet 170 381 15 0;
#P window linecount 0;
#P newex 170 209 20 196617 t b;
#P newex 170 278 113 196617 zl join;
#P newex 232 209 51 196617 zl slice 1;
#P newex 170 255 72 196617 sprintf %s%s;
#P newex 358 211 30 196617 t tab;
#P inlet 120 32 15 0;
#P newex 140 209 25 196617 t cr;
#P newex 120 60 315 196617 t dump b;
#N coll $0_state 1;
#P newobj 170 144 79 196617 coll $0_state 1;
#P comment 463 54 141 196617 Only retrieve parameters \, not messages from the module;
#P connect 4 0 2 0;
#P connect 2 0 11 0;
#P connect 1 0 3 0;
#P connect 11 1 12 0;
#P connect 12 0 1 0;
#P connect 1 0 9 0;
#P connect 9 0 19 0;
#P connect 19 0 6 0;
#P connect 6 0 8 0;
#P connect 3 0 10 0;
#P fasten 5 0 10 0 363 358 175 358;
#P connect 8 0 10 0;
#P fasten 16 0 10 0 455 358 175 358;
#P fasten 18 0 10 0 430 358 175 358;
#P fasten 15 0 19 1 481 183 201 183;
#P lcolor 1;
#P connect 1 0 7 0;
#P connect 7 0 6 1;
#P connect 7 1 8 1;
#P connect 1 0 5 0;
#P connect 2 1 18 0;
#P connect 18 1 16 0;
#P connect 14 0 15 0;
#P connect 15 0 17 0;
#P connect 17 0 16 1;
#P pop;
#P newobj 404 86 64 196617 p dumpState;
#N comlet connect to left inlet of module;
#P outlet 140 167 15 0;
#P window linecount 0;
#P newex 34 29 118 196617 r jmod.remote.toModule;
#P comment 219 140 150 196617 If no argument providing a OSC name has been provided to the module \, it will not be listening.;
#P connect 1 0 5 0;
#P connect 5 1 4 0;
#P connect 4 0 2 0;
#P connect 8 0 9 0;
#P connect 9 0 4 1;
#P connect 7 0 3 0;
#P connect 3 0 6 0;
#P pop;
#P newobj 133 33 122 196617 p remote_communication;
#P newex 279 346 134 196617 r $1_message;
#N vpatcher 236 60 1206 495;
#P window setfont "Sans Serif" 9.;
#P window linecount 0;
#P newex 359 319 21 196617 b 1;
#P outlet 359 383 15 0;
#P message 359 363 110 196617 /autodoc_complete bang;
#P window linecount 1;
#P newex 359 275 63 196617 t l l;
#P newex 359 341 27 196617 qlim;
#P newex 359 297 51 196617 route write;
#P window linecount 0;
#P newex 120 128 70 196617 prepend setfile;
#P newex 103 105 27 196617 t b l;
#P newex 648 275 301 196617 jmod.return.mxt $1 /modulesize @description "Size of module.";
#P newex 855 208 49 196617 t getsize;
#P newex 545 185 320 196617 jmod.message $1 /getmodulesize @description "Get size of module.";
#P newex 460 185 58 196617 r jmod.init;
#P newex 283 193 134 196617 prepend module_description;
#P newex 283 170 160 196617 route description;
#P window linecount 1;
#P message 460 208 164 196617 title $2;
#P window linecount 0;
#P newex 283 147 94 196617 route ATTRIBUTES;
#P newex 283 121 93 196617 r $1_FROM_MHUB;
#P inlet 70 46 15 0;
#P newex 70 83 43 196617 sel bang;
#P window linecount 1;
#P newex 412 297 40 196617 text;
#P newex 70 253 589 196617 js jmod.js_docmaker.js;
#P newex 145 193 129 196617 r $1_register_doc;
#P newex 143 332 118 196617 s $1_query_doc;
#P newex 143 311 68 196617 route symbol;
#N coll $1_registered_parameters 1;
#P newobj 70 275 229 196617 coll $1_registered_parameters 1;
#P connect 7 0 6 0;
#P connect 17 0 4 0;
#P connect 18 0 4 0;
#P connect 6 0 4 0;
#P fasten 11 1 4 0 438 234 75 234;
#P fasten 3 0 4 0 150 231 75 231;
#P fasten 12 0 4 0 288 234 75 234;
#P fasten 15 0 4 0 860 237 75 237;
#P fasten 10 0 4 0 465 234 75 234;
#P connect 4 0 0 0;
#P connect 6 1 17 0;
#P connect 17 1 18 0;
#P connect 0 1 1 0;
#P connect 1 0 2 0;
#P connect 8 0 9 0;
#P connect 9 0 11 0;
#P connect 11 0 12 0;
#P connect 4 1 21 0;
#P connect 21 0 19 0;
#P connect 19 0 24 0;
#P connect 24 0 20 0;
#P connect 20 0 22 0;
#P connect 22 0 23 0;
#P connect 21 1 5 0;
#P connect 13 0 10 0;
#P connect 4 2 16 0;
#P connect 14 1 15 0;
#P pop;
#P newobj 176 110 51 196617 p autodoc;
#P window linecount 2;
#P newex 44 223 278 196617 patcherargs @size 1U @algorithm_type poly @module_type audio @skin default @description "No info provided.";
#P window linecount 1;
#N vpatcher 24 74 846 293;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 56 124 35 196617 t open;
#P window linecount 4;
#P newex 56 61 312 196617 jmod.message.mxt $1 /view_internals @type n/a @range n/a @description "Attempts to open the internal algorithm for viewing.  This works for most modules.  Some modules may choose to cloak the algorithms - preventing this message from functioning.";
#P outlet 56 152 15 0;
#P fasten 1 1 2 0 363 118 61 118;
#P connect 2 0 0 0;
#P pop;
#P newobj 255 426 85 196617 p view_internals;
#N vpatcher 175 173 632 687;
#P window setfont "Sans Serif" 9.;
#P newex 20 286 54 196617 jmod.thru;
#P newex 104 320 60 196617 s $1_name;
#P window linecount 1;
#P newex 57 242 64 196617 sprintf /%s;
#P newex 57 222 51 196617 tosymbol;
#P comment 69 196 241 196617 add a slash if it is missing...;
#P newex 57 70 27 196617 t l l;
#P window linecount 0;
#P newex 74 150 27 196617 1;
#P window linecount 1;
#P newex 20 194 47 196617 gate 2 1;
#P window linecount 0;
#P newex 102 150 21 196617 t 2;
#P newex 74 130 38 196617 sel 47;
#P window linecount 1;
#P newex 74 90 40 196617 atoi;
#P window linecount 0;
#P newex 74 110 51 196617 zl slice 1;
#P window linecount 1;
#P newex 54 357 48 196617 loadbang;
#P window linecount 0;
#P message 54 379 108 196617 send bang to jmod.init;
#P inlet 57 50 15 0;
#P window linecount 1;
#P newex 20 405 114 196617 prepend MODULE_TITLE;
#P newex 20 441 93 196617 s $1_FROM_MHUB;
#P window linecount 0;
#P comment 4 26 210 196617 set title of module in top bar of gui;
#P comment 113 133 86 196617 ascii code for '/';
#P comment 164 361 147 196617 warn users that the module is not initialized for use yet!;
#P comment 116 92 241 196617 Check to make sure the string starts with a slash...;
#P connect 12 0 13 0;
#P connect 14 0 13 0;
#P connect 18 0 20 0;
#P connect 13 0 20 0;
#P connect 20 0 5 0;
#P connect 7 0 5 0;
#P connect 5 0 4 0;
#P connect 8 0 7 0;
#P connect 6 0 15 0;
#P connect 15 0 13 1;
#P connect 13 1 17 0;
#P connect 17 0 18 0;
#P connect 15 1 10 0;
#P connect 10 0 9 0;
#P connect 9 0 11 0;
#P connect 11 0 14 0;
#P connect 11 1 12 0;
#P connect 20 0 19 0;
#P pop;
#P newobj 121 110 35 196617 p title;
#P newex 35 33 90 196617 r $1_FROM_MGUI;
#P comment 443 459 100 196617 to pattrstorage;
#N comlet to pattrstorage;
#P outlet 424 459 15 0;
#N comlet connect to pattrstorage;
#P inlet 424 39 15 0;
#N comlet connect to a poly~ object;
#P outlet 214 459 15 0;
#P window linecount 3;
#P newex 11 59 232 196617 route _MGUI_FEEDBACK _GET_MODULE_INSTALL_SIZE MODULE_TITLE /autodoc;
#P window linecount 1;
#P newex 231 133 27 196617 t l l;
#P newex 287 137 100 196617 send $1_instruction;
#N comlet module feedback - connect to 1st outlet;
#P outlet 11 459 15 0;
#N comlet connect to mgui (1st outlet);
#P inlet 11 34 15 0;
#N vpatcher 109 180 916 700;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 525 176 27 196617 t l l;
#P newex 525 262 38 196617 gate;
#P newex 525 235 27 196617 > 1;
#P newex 525 209 29 196617 zl len;
#P newex 659 202 83 196617 regexp (\\\\S+::);
#P window linecount 0;
#P newex 565 108 115 196617 loadmess substitute %0;
#P window linecount 2;
#P newex 317 247 78 196617 t MENU_REBUILD;
#P window linecount 1;
#P newex 344 158 112 196617 prepend NEW_PRESETS;
#P newex 90 450 71 196617 prepend store;
#P window linecount 3;
#P newex 90 401 335 196617 jmod.message.mxt 0 /preset_store @type msg_int @description "Store a preset by number in memory.  All presets present in memory will be written to disk when you send a save_settings message to the module.";
#P window linecount 1;
#P newex 71 377 73 196617 prepend recall;
#P window linecount 2;
#P newex 71 338 346 196617 jmod.message.mxt $1 /preset_recall @type msg_int @description "Recall a preset by number - you can also choose presets from the module menu.";
#P window linecount 1;
#P newex 344 311 93 196617 s $1_FROM_MHUB;
#P newex 290 128 65 196617 route 0 done;
#P window linecount 2;
#P newex 55 247 110 196617 t getslotnamelist NEW_PRESETS_START;
#P window linecount 1;
#P newex 55 97 480 196617 route read slotname;
#P newex 565 313 50 196617 tosymbol;
#P newex 565 335 63 196617 fromsymbol;
#P newex 525 357 50 196617 zl join;
#P newex 525 291 50 196617 zl slice 1;
#P newex 525 381 35 196617 zl reg;
#P newex 525 153 101 196617 regexp (.+::)* \\\\d;
#P window setfont "Sans Serif" 12.;
#P comment 55 37 103 196620 Preset Handling;
#P window setfont "Sans Serif" 9.;
#P comment 78 66 100 196617 from pattrstorage;
#P window linecount 3;
#P comment 620 226 172 196617 filter out the part of the feedback symbol preceeding the double-colon. Then send to the feedback outlet;
#N comlet from pattrstorage;
#P inlet 55 65 15 0;
#P outlet 55 474 15 0;
#P outlet 525 474 15 0;
#P connect 2 0 12 0;
#P connect 12 0 13 0;
#P connect 13 0 1 0;
#P connect 17 0 1 0;
#P connect 19 0 1 0;
#P fasten 16 1 17 0 412 371 76 371;
#P fasten 18 1 19 0 420 445 95 445;
#P connect 12 1 14 0;
#P connect 14 1 21 0;
#P connect 14 2 20 0;
#P connect 21 0 15 0;
#P connect 13 1 15 0;
#P connect 20 0 15 0;
#P connect 12 2 6 0;
#P connect 22 0 6 0;
#P connect 6 0 27 0;
#P connect 27 1 24 0;
#P connect 24 0 25 0;
#P connect 25 0 26 0;
#P connect 26 0 8 0;
#P connect 8 0 9 0;
#P connect 9 0 7 0;
#P connect 7 0 0 0;
#P connect 27 0 26 1;
#P connect 8 1 11 0;
#P connect 11 0 10 0;
#P connect 10 0 9 1;
#P pop;
#P newobj 424 162 179 196617 p preset_handling_from_pattrstorage;
#N vpatcher 213 54 933 421;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P message 476 113 14 196617 5;
#P message 380 113 14 196617 4;
#P message 284 113 14 196617 1;
#P window linecount 0;
#P newex 267 140 27 196617 int;
#P newex 284 87 252 196617 sel audio audio.no_panel audio.ambisonic control video;
#P window linecount 1;
#P newex 58 62 463 196617 route algorithm_type module_type;
#P window linecount 0;
#N vpatcher 644 52 1157 457;
#P window setfont "Sans Serif" 9.;
#P comment 106 33 100 196617 'mute' just passes through;
#P outlet 226 356 15 0;
#P inlet 55 45 15 0;
#P newex 55 230 27 196617 qlim;
#P message 70 258 14 196617 1;
#B color 4;
#P message 55 202 14 196617 2;
#B color 4;
#P message 112 258 14 196617 1;
#B color 4;
#P message 97 202 14 196617 3;
#B color 4;
#P message 154 258 14 196617 1;
#B color 4;
#P message 139 202 14 196617 0;
#B color 4;
#P number 71 284 35 9 0 0 0 3 0 0 0 59 62 255 222 222 222 0 0 0;
#P newex 139 180 40 196617 sel 1 0;
#B color 4;
#P newex 97 180 40 196617 sel 1 0;
#B color 4;
#P newex 55 180 40 196617 sel 1 0;
#B color 4;
#P message 71 302 112 196617 /direct outputmode \$1;
#B color 4;
#P newex 55 70 183 196617 jmod.oscroute /bypass /freeze /mute;
#P connect 13 0 0 0;
#P connect 0 0 2 0;
#P connect 2 0 10 0;
#P lcolor 5;
#P fasten 6 0 12 0 144 223 60 223;
#P fasten 8 0 12 0 102 223 60 223;
#P connect 10 0 12 0;
#P connect 2 1 11 0;
#P lcolor 5;
#P fasten 12 0 5 0 60 279 76 279;
#P connect 11 0 5 0;
#P lcolor 5;
#P fasten 9 0 5 0 117 276 76 276;
#P lcolor 5;
#P fasten 7 0 5 0 159 276 76 276;
#P lcolor 5;
#P connect 5 0 1 0;
#P lcolor 5;
#P connect 0 1 3 0;
#P connect 3 0 8 0;
#P lcolor 5;
#P connect 3 1 9 0;
#P lcolor 5;
#P connect 0 2 4 0;
#P connect 4 0 6 0;
#P lcolor 5;
#P connect 4 1 7 0;
#P lcolor 5;
#P connect 1 0 14 0;
#P connect 0 3 14 0;
#P pop;
#P newobj 554 215 73 196617 p parse_jitter;
#N vpatcher 90 257 281 401;
#P window setfont "Sans Serif" 9.;
#P comment 57 36 100 196617 'mute' just passes through;
#P outlet 34 95 15 0;
#P inlet 34 36 15 0;
#P connect 0 0 1 0;
#P pop;
#P newobj 430 215 80 196617 p parse_control;
#P message 174 113 14 196617 5;
#P message 145 113 14 196617 4;
#N vpatcher 231 194 756 697;
#P window setfont "Sans Serif" 9.;
#P newex 233 135 78 196617 prepend mute 0;
#P newex 59 112 59 196617 jmod.round;
#P newex 77 194 27 196617 - 2;
#P newex 28 168 59 196617 sel setitem;
#P newex 28 137 88 196617 jmod.core.sr.mxt;
#P newex 28 88 72 196617 route int float;
#P newex 182 257 215 196617 jmod.post.mxt "parse_poly: bad sample rate";
#P message 161 291 27 196617 up 4;
#P message 140 316 27 196617 up 2;
#P message 77 377 41 196617 down 4;
#P message 98 357 41 196617 down 2;
#P message 119 334 41 196617 down 1;
#P newex 77 230 119 196617 sel -2 -1 0 1 2;
#P newex 28 46 421 196617 jmod.oscroute /sr /mute;
#P outlet 233 417 15 0;
#P inlet 28 26 15 0;
#P connect 0 0 2 0;
#P connect 2 0 10 0;
#P connect 14 0 11 0;
#P connect 10 0 11 0;
#P connect 11 0 12 0;
#P connect 10 1 14 0;
#P connect 12 1 13 0;
#P connect 13 0 3 0;
#P connect 3 0 6 0;
#P connect 3 1 5 0;
#P connect 3 2 4 0;
#P connect 3 3 7 0;
#P connect 3 4 8 0;
#P connect 3 5 9 0;
#P connect 2 1 15 0;
#P connect 7 0 1 0;
#P connect 8 0 1 0;
#P connect 6 0 1 0;
#P connect 5 0 1 0;
#P connect 4 0 1 0;
#P connect 15 0 1 0;
#P fasten 2 2 1 0 443 400 238 400;
#P pop;
#P newobj 58 215 65 196617 p parse_poly;
#N vpatcher 237 245 596 667;
#P window setfont "Sans Serif" 9.;
#P newex 170 139 140 196617 jmod.pass @stripnonmatches 1;
#P newex 51 109 59 196617 jmod.round;
#P newex 20 185 27 196617 - 2;
#P newex 20 158 59 196617 sel setitem;
#P newex 20 88 72 196617 route int float;
#P newex 20 137 88 196617 jmod.core.sr.mxt;
#P newex 68 239 214 196617 jmod.post.mxt "parse_blue: bad sample rate";
#P message 20 310 72 196617 downsample 2;
#P message 36 292 72 196617 downsample 1;
#P message 52 274 72 196617 downsample 0;
#P newex 20 215 59 196617 sel -2 -1 0;
#P newex 20 52 220 196617 jmod.oscroute /sr /gain/midi /defeat_meters;
#P outlet 170 360 15 0;
#P inlet 20 27 15 0;
#P connect 0 0 2 0;
#P connect 2 0 9 0;
#P connect 12 0 8 0;
#P connect 9 0 8 0;
#P connect 8 0 10 0;
#P connect 10 1 11 0;
#P connect 11 0 3 0;
#P connect 3 0 6 0;
#P connect 3 1 5 0;
#P connect 9 1 12 0;
#P connect 3 2 4 0;
#P connect 3 3 7 0;
#P connect 2 3 13 0;
#P connect 4 0 1 0;
#P connect 5 0 1 0;
#P connect 6 0 1 0;
#P connect 13 0 1 0;
#P pop;
#P newobj 182 215 65 196617 p parse_blue;
#P message 116 113 14 196617 3;
#P newex 58 193 506 196617 gate 5 1;
#P newex 58 268 35 196617 zl reg;
#P message 87 113 14 196617 2;
#P newex 58 87 213 196617 sel poly blue none control jitter video default;
#P message 58 113 14 196617 1;
#P inlet 554 40 15 0;
#P inlet 58 40 15 0;
#P outlet 58 299 15 0;
#P connect 1 0 15 0;
#P connect 15 0 4 0;
#P connect 4 0 3 0;
#P fasten 12 0 7 0 179 134 63 134;
#P fasten 11 0 7 0 150 134 63 134;
#P fasten 8 0 7 0 121 134 63 134;
#P connect 3 0 7 0;
#P fasten 5 0 7 0 92 134 63 134;
#P fasten 17 0 7 0 272 163 63 163;
#P connect 7 0 10 0;
#P connect 9 0 6 0;
#P connect 10 0 6 0;
#P connect 14 0 6 0;
#P connect 13 0 6 0;
#P fasten 7 2 0 0 311 292 63 292;
#P connect 6 0 0 0;
#P connect 4 1 5 0;
#P connect 4 2 8 0;
#P connect 4 3 11 0;
#P connect 4 4 12 0;
#P connect 4 5 12 0;
#P connect 7 1 9 0;
#P connect 4 6 17 0;
#P connect 15 1 16 0;
#P connect 16 0 18 0;
#P connect 18 0 17 1;
#P connect 19 0 17 1;
#P connect 20 0 17 1;
#P connect 16 3 19 0;
#P connect 16 2 19 0;
#P connect 16 1 19 0;
#P connect 7 3 13 0;
#P connect 16 4 20 0;
#P connect 2 0 7 1;
#P connect 7 4 14 0;
#P pop;
#P newobj 214 388 100 196617 p algorithm_handler;
#N vpatcher 14 59 407 339;
#P window setfont "Sans Serif" 9.;
#P newex 101 130 68 196617 route symbol;
#P newex 101 177 130 196617 prepend /parameter_name;
#P newex 51 76 39 196617 t dump;
#N coll $1_registered_parameters 1;
#P newobj 51 100 161 196617 coll $1_registered_parameters 1;
#P newex 51 26 306 196617 jmod.message.mxt $1 /get_parameter_names @type n/a @range n/a @description "Returns a dump of symbols out the feedback outlet with the names of parameters accessible in this module.";
#P outlet 101 216 15 0;
#P fasten 1 1 3 0 352 72 56 72;
#P connect 3 0 2 0;
#P connect 2 1 5 0;
#P connect 5 0 4 0;
#P connect 5 1 4 0;
#P connect 4 0 0 0;
#P pop;
#P newobj 37 371 98 196617 p parameter_names;
#N vpatcher 232 201 1164 650;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P message 168 276 107 196617 name $2 \, outputmode 1;
#P window linecount 2;
#P comment 129 373 486 196617 The first outlet is intended for display update only \, and has the message qlim-ed and prepended by "set". 2nd outlet returns proper message instantly.;
#B color 12;
#P window linecount 1;
#P comment 129 359 322 196617 Here we have to use the 2nd outlet of jmod.message \, not the first.;
#B color 12;
#P newex 121 190 100 196617 sprintf read %s.xml;
#P newex 508 211 45 196617 sel bang;
#P newex 332 199 45 196617 sel bang;
#N vpatcher 287 116 693 532;
#P origin 0 -110;
#P window setfont "Sans Serif" 9.;
#P newex 107 229 50 196617 tosymbol;
#P newex 232 230 50 196617 tosymbol;
#P inlet 147 34 15 0;
#P inlet 130 34 15 0;
#P newex 177 95 192 196617 jmod.route @searchstring save_settings;
#P newex 232 273 27 196617 t l b;
#P message 249 308 42 196617 store 1;
#P newex 177 225 49 196617 t write b;
#P newex 192 205 50 196617 zl slice 1;
#P newex 232 253 72 196617 prepend write;
#P newex 177 125 50 196617 t l l;
#P newex 192 185 35 196617 zl reg;
#P newex 177 165 40 196617 sel 1 2;
#P newex 177 145 33 196617 zl len;
#P newex 107 273 27 196617 t b l;
#P message 52 307 35 196617 recall 1;
#P newex 52 225 44 196617 t b read;
#P newex 67 205 50 196617 zl slice 1;
#P newex 107 253 65 196617 prepend read;
#P newex 52 125 50 196617 t l l;
#P newex 67 185 35 196617 zl reg;
#P newex 52 165 40 196617 sel 1 2;
#P newex 52 145 33 196617 zl len;
#P newex 52 72 189 196617 jmod.route @searchstring load_settings;
#P outlet 86 367 15 0;
#P inlet 52 45 15 0;
#P connect 0 0 2 0;
#P connect 2 0 6 0;
#P connect 6 0 3 0;
#P connect 3 0 4 0;
#P connect 22 0 9 0;
#P connect 4 0 9 0;
#P connect 9 0 10 0;
#P connect 11 0 10 0;
#P connect 4 1 5 0;
#P connect 5 0 8 0;
#P fasten 18 0 1 0 182 358 91 358;
#P fasten 20 0 1 0 237 358 91 358;
#P fasten 19 0 1 0 254 358 91 358;
#P connect 9 1 1 0;
#P connect 10 0 1 0;
#P fasten 11 1 1 0 129 358 91 358;
#P connect 6 1 5 1;
#P connect 8 1 25 0;
#P connect 25 0 7 0;
#P connect 7 0 11 0;
#P connect 2 1 21 0;
#P connect 21 0 15 0;
#P connect 15 0 12 0;
#P connect 12 0 13 0;
#P connect 23 0 18 0;
#P connect 13 0 18 0;
#P connect 13 1 14 0;
#P connect 14 0 17 0;
#P connect 15 1 14 1;
#P connect 17 1 24 0;
#P connect 24 0 16 0;
#P connect 16 0 20 0;
#P connect 20 1 19 0;
#P fasten 18 1 19 0 221 303 254 303;
#P lcolor 2;
#P pop;
#P newobj 311 293 53 196617 p settings;
#P newex 367 222 105 196617 prepend load_settings;
#P window linecount 3;
#P newex 332 103 306 196617 jmod.message.mxt $1 /load_settings @type msg_symbol @range n/a @description "Open an xml-preset file and recall the first preset in that file.  An optional argument defines the file to open.";
#P window linecount 1;
#P newex 543 234 110 196617 prepend save_settings;
#P window linecount 2;
#P newex 509 163 388 196617 jmod.message.mxt $1 /save_settings @type msg_symbol @range n/a @description "Write an xml-preset file to disk.  An optional argument defines the file to open.";
#P newex 142 41 361 196617 jmod.message.mxt $1 /restore_defaults @type n/a @range n/a @description "Open the default preset file and recall the first preset in that file.";
#P comment 10 160 62 196617 load the first preset;
#P window linecount 1;
#P message 76 160 44 196617 recall 1;
#P message 121 160 110 196617 $2;
#P window linecount 2;
#P comment 139 213 100 196617 read the default preset(s);
#P window linecount 1;
#P newex 76 97 191 196617 t b b b;
#P newex 76 48 55 196617 r jmod.init;
#P outlet 76 339 15 0;
#P window setfont "Sans Serif" 12.;
#P window linecount 0;
#P comment 129 339 143 196620 // Important:;
#B color 12;
#P connect 2 0 3 0;
#P fasten 8 1 3 0 498 84 81 84;
#P connect 3 0 6 0;
#P fasten 19 0 1 0 173 314 81 314;
#P fasten 13 0 1 0 316 317 81 317;
#P connect 6 0 1 0;
#P fasten 16 0 1 0 126 311 81 311;
#P fasten 3 1 5 0 171 133 126 133;
#P connect 5 0 16 0;
#P fasten 3 2 19 0 261 266 173 266;
#P fasten 12 0 13 0 372 258 316 258;
#P fasten 10 0 13 0 548 261 316 261;
#P fasten 11 1 14 0 633 155 337 155;
#P connect 14 0 13 1;
#P fasten 15 0 13 2 513 287 358 287;
#P connect 14 1 12 0;
#P fasten 9 1 15 0 892 206 513 206;
#P connect 15 1 10 0;
#P pop;
#P newobj 443 373 165 196617 p preset_handling_to_pattrstorage;
#N vpatcher 14 59 347 414;
#P origin 68 0;
#P window setfont "Sans Serif" 9.;
#P newex 39 78 51 196617 route list;
#P message 129 171 52 196617 target \$1;
#P newex 112 150 27 196617 t b i;
#P newex 112 221 117 196617 zl reg;
#P newex 112 130 117 196617 zl slice 1;
#P window setfont "Sans Serif" 12.;
#P comment 47 28 131 196620 Poly Handling;
#P inlet 39 58 15 0;
#P outlet 80 284 15 0;
#P connect 1 0 7 0;
#P connect 7 1 0 0;
#P connect 4 0 0 0;
#P fasten 6 0 0 0 134 208 85 208;
#P connect 7 0 3 0;
#P connect 3 0 5 0;
#P connect 5 0 4 0;
#P connect 5 1 6 0;
#P connect 3 1 4 1;
#P pop;
#P newobj 231 110 78 196617 p poly_handling;
#N vpatcher 273 125 703 513;
#P inlet 47 42 15 0;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 47 72 294 196617 t l l;
#P newex 47 252 294 196617 zl reg;
#P window linecount 2;
#P newex 47 286 125 196617 jmod.post.mxt $2-SyntaxError;
#P window linecount 1;
#P newex 47 226 31 196617 sel 0;
#P newex 47 206 27 196617 i;
#P newex 47 118 44 196617 t b l 0;
#P newex 47 96 50 196617 zl slice 1;
#N coll $1_registered_parameters 1;
#P newobj 64 160 203 196617 coll $1_registered_parameters 1;
#P window linecount 0;
#N vpatcher 14 59 539 498;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 117 252 109 196617 prepend PARAMETERS;
#P newex 117 273 122 196617 s $1_FROM_MHUB;
#P newex 69 368 71 196617 prepend store;
#P newex 69 347 35 196617 zl rev;
#P newex 69 326 48 196617 zl join;
#P newex 69 221 48 196617 t b l;
#N counter;
#X flags 0 0;
#P newobj 69 303 352 196617 counter;
#P newex 69 103 55 196617 t b clear 1;
#P newex 69 201 159 196617 receive $1_register;
#P newex 69 168 132 196617 send $1_query;
#P newex 69 72 55 196617 r jmod.init;
#P outlet 47 394 15 0;
#P window linecount 0;
#P comment 37 33 300 196617 query for valid syntax \, and register in coll;
#P connect 10 0 1 0;
#P fasten 5 1 1 0 96 138 52 138;
#P connect 2 0 5 0;
#P connect 5 0 3 0;
#P connect 4 0 7 0;
#P connect 7 0 6 0;
#P connect 6 0 8 0;
#P connect 8 0 9 0;
#P connect 9 0 10 0;
#P connect 7 1 8 1;
#P fasten 7 1 12 0 112 242 122 242;
#P lcolor 13;
#P connect 12 0 11 0;
#P fasten 5 2 6 2 118 127 244 127;
#P pop;
#P newobj 111 119 91 196617 p syntax_register;
#B color 12;
#P comment 205 116 124 196617 query for valid syntax \, and register in coll;
#B color 12;
#P comment 69 50 114 196617 check if syntax is valid;
#P connect 11 0 10 0;
#P connect 10 0 4 0;
#P connect 4 0 5 0;
#P connect 5 0 6 0;
#P connect 6 0 7 0;
#P connect 7 0 9 0;
#P connect 9 0 8 0;
#P connect 5 1 3 0;
#P connect 2 0 3 0;
#P lcolor 13;
#P connect 3 0 6 1;
#P fasten 5 2 6 1 86 191 69 191;
#P connect 10 1 9 1;
#P pop;
#P newobj 231 177 85 196617 p syntax_handler;
#P comment 443 39 100 196617 from pattrstorage;
#P fasten 22 0 11 0 138 54 16 54;
#P connect 7 0 11 0;
#P fasten 16 0 11 0 40 54 16 54;
#P connect 6 1 24 0;
#P connect 25 0 24 0;
#P connect 4 0 24 0;
#P connect 11 0 24 0;
#P fasten 20 0 24 0 181 150 16 150;
#P connect 24 0 8 0;
#P connect 24 0 23 0;
#P fasten 19 1 27 0 317 256 49 256;
#P connect 27 0 28 0;
#P connect 26 0 29 0;
#P connect 28 0 29 0;
#P connect 27 1 26 0;
#P connect 24 0 30 0;
#P connect 11 2 17 0;
#P connect 11 3 20 0;
#P fasten 19 1 5 0 317 258 219 258;
#P connect 18 0 12 0;
#P connect 5 0 12 0;
#P connect 11 4 2 0;
#P connect 2 0 10 0;
#P connect 10 0 1 0;
#P connect 10 1 31 0;
#P connect 21 0 5 1;
#P connect 6 1 5 1;
#P connect 13 0 6 0;
#P connect 6 0 14 0;
#P connect 3 0 14 0;
#P pop;
