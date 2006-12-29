max v2;
#N vpatcher 35 124 915 612;
#P window setfont "Sans Serif" 9.;
#P newex 494 371 141 196617 jmod.pluggo.configassist.mxt;
#P number 490 319 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#N vpatcher 33 59 637 314;
#P window setfont "Sans Serif" 9.;
#P window linecount 1;
#P newex 195 142 117 196617 zl join 1;
#P newex 195 122 105 196617 sprintf /degrade~%s;
#P newex 195 101 117 196617 zl slice 1;
#P newex 50 50 226 196617 jmod.pass /audio/bypass /audio/mute @strip 0;
#P inlet 50 30 15 0;
#P outlet 50 175 15 0;
#P window linecount 0;
#P comment 303 58 217 196617 /bypass and /mute are dealt with as special cases as they are to affect both modules.;
#P connect 2 0 3 0;
#P connect 3 0 1 0;
#P connect 3 1 1 0;
#P connect 6 0 1 0;
#P connect 3 2 4 0;
#P connect 4 0 5 0;
#P connect 5 0 6 0;
#P connect 4 1 6 1;
#P pop;
#P newobj 49 415 59 196617 p translate;
#N vpatcher 33 59 605 329;
#P window setfont "Sans Serif" 9.;
#P window linecount 0;
#P comment 292 53 217 196617 /bypass and /mute are dealt with as special cases as they are to affect both modules.;
#P window linecount 1;
#P newex 212 150 110 196617 zl join 1;
#P newex 212 130 101 196617 sprintf /limiter~%s;
#P newex 212 109 110 196617 zl slice 1;
#P newex 50 59 226 196617 jmod.pass /audio/bypass /audio/mute @strip 0;
#P inlet 50 30 15 0;
#P outlet 50 196 15 0;
#P connect 1 0 2 0;
#P connect 2 0 0 0;
#P connect 2 1 0 0;
#P connect 5 0 0 0;
#P connect 2 2 3 0;
#P connect 3 0 4 0;
#P connect 4 0 5 0;
#P connect 3 1 5 1;
#P pop;
#P newobj 112 415 59 196617 p translate;
#P window setfont "Sans Serif" 18.;
#P comment 25 28 223 196626 Pluggo_complex;
#B frgb 255 255 255;
#P window setfont "Sans Serif" 9.;
#P comment 26 54 239 196617 Multiple moduels in a single plugin;
#B frgb 255 255 255;
#P user panel 21 22 363 52;
#X brgb 67 65 107;
#X frgb 0 0 0;
#X border 0;
#X rounded 0;
#X shadow 0;
#X done;
#P window linecount 2;
#P newex 160 165 123 196617 jmod.oscroute /limiter~ /degrade~;
#P message 750 371 62 196617 \; max refresh;
#P newex 30 165 124 196617 jmod.pass /audio/bypass /audio/mute @strip 0;
#P objectname u776000027[3];
#P window linecount 1;
#P newex 530 113 311 196617 jmod.pp /degrade~/audio/gain/midi 3 "degrade gain (midi)" 0 158;
#B color 7;
#P flonum 490 114 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 93 219 196617 jmod.pp /degrade~/bitdepth 2 "bitdepth" 1 24;
#P number 490 94 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 73 263 196617 jmod.pp /degrade~/sr_ratio 1 "sample rate ratio" 0. 1.;
#P flonum 490 74 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P window linecount 3;
#P comment 26 84 357 196617 This example demonstrates how to augment the system in the Pluggo_Simple example to work with multiple modules in a single plugin. It includes shared bypass and mute parameters that always effect both modules in tandem.;
#P window linecount 1;
#P newex 30 144 99 196617 r ---parameter_set;
#P objectname u776000027[2];
#P newex 323 199 131 196617 adc~;
#P newex 323 223 131 196617 plugin~;
#P bpatcher 200 249 255 60 0 0 jmod.degrade~.mxt 0;
#P objectname ---degrade;
#P newex 49 451 99 196617 s ---parameter_get;
#P newex 530 317 308 196617 jmod.pp /limiter~/mode 10 shape 0 1 @choices exponential linear;
#P newex 530 162 163 196617 jmod.pp /audio/mute 12 mute 0 1;
#P toggle 490 163 15 0;
#P newex 530 142 181 196617 jmod.pp /audio/bypass 11 bypass 0 1;
#P toggle 490 143 15 0;
#P newex 530 296 248 196617 jmod.pp /limiter~/audio/gain/midi 9 midigain 0 158;
#B color 7;
#P flonum 490 297 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 275 233 196617 jmod.pp /limiter~/release 8 release 1. 2000. ms;
#P flonum 490 276 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 254 264 196617 jmod.pp /limiter~/lookahead 7 lookahead 0 100 samples;
#P flonum 490 255 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 233 231 196617 jmod.pp /limiter~/threshold 6 threshold -48. 18;
#P flonum 490 234 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 212 221 196617 jmod.pp /limiter~/postamp 5 postamp -48. 18;
#P flonum 490 213 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#P newex 530 191 216 196617 jmod.pp /limiter~/preamp 4 preamp -48. 18.;
#P flonum 490 192 35 9 0 0 0 3 0 0 0 221 221 221 222 222 222 0 0 0;
#N plugconfig;
#C useviews 1 1 1 1;
#C numprograms 64;
#C preempt 1;
#C sigvschange 1;
#C sigvsdefault 32;
#C autosize;
#C defaultview Interface 0 0 0;
#C dragscroll 1;
#C infotext An example of how to combine several Jamoma modules in a Pluggo. Enjoy!;
#C package ????;
#C welcome www.jamoma.org;
#C uniqueid 114 6 197;
#C initialpgm 1;
#P newobj 494 409 54 196617 plugconfig;
#P newex 322 435 132 196617 dac~;
#P newex 322 409 132 196617 plugout~;
#P bpatcher 200 338 255 60 0 0 jmod.limiter~.mxt 0;
#P objectname ---limiter;
#P user panel 480 67 364 69;
#X brgb 199 199 214;
#X frgb 0 0 0;
#X border 0;
#X rounded 0;
#X shadow 0;
#X done;
#P user panel 480 137 364 49;
#X brgb 199 199 214;
#X frgb 0 0 0;
#X border 0;
#X rounded 0;
#X shadow 0;
#X done;
#P user panel 480 350 364 89;
#X brgb 199 199 214;
#X frgb 0 0 0;
#X border 0;
#X rounded 0;
#X shadow 0;
#X done;
#P user panel 480 187 364 155;
#X brgb 199 199 214;
#X frgb 0 0 0;
#X border 0;
#X rounded 0;
#X shadow 0;
#X done;
#P connect 29 0 37 0;
#P connect 26 0 44 0;
#P lcolor 13;
#P connect 44 0 25 0;
#P lcolor 13;
#P connect 43 0 25 0;
#P lcolor 1;
#P connect 4 0 43 0;
#P lcolor 1;
#P connect 37 2 39 0;
#P connect 37 1 26 0;
#P lcolor 13;
#P connect 37 0 26 0;
#P lcolor 13;
#P connect 39 1 26 0;
#P lcolor 13;
#P connect 37 1 4 0;
#P lcolor 1;
#P connect 37 0 4 0;
#P lcolor 1;
#P connect 39 0 4 0;
#P lcolor 1;
#P connect 27 0 26 1;
#P connect 26 1 4 1;
#P connect 4 1 5 0;
#P connect 5 0 6 0;
#P connect 28 0 27 0;
#P connect 28 1 27 1;
#P connect 27 1 26 2;
#P connect 26 2 4 2;
#P connect 4 2 5 1;
#P connect 5 1 6 1;
#P hidden connect 32 0 31 0;
#P hidden connect 34 0 33 0;
#P hidden connect 36 0 35 0;
#P hidden connect 21 0 20 0;
#P hidden connect 23 0 22 0;
#P hidden connect 9 0 8 0;
#P hidden connect 11 0 10 0;
#P hidden connect 13 0 12 0;
#P hidden connect 15 0 14 0;
#P hidden connect 17 0 16 0;
#P hidden connect 19 0 18 0;
#P hidden connect 24 0 45 0;
#P connect 46 0 7 0;
#P hidden connect 31 0 32 0;
#P hidden connect 33 0 34 0;
#P hidden connect 35 0 36 0;
#P hidden connect 20 0 21 0;
#P hidden connect 22 0 23 0;
#P hidden connect 8 0 9 0;
#P hidden connect 10 0 11 0;
#P hidden connect 12 0 13 0;
#P hidden connect 14 0 15 0;
#P hidden connect 16 0 17 0;
#P hidden connect 18 0 19 0;
#P hidden connect 45 0 24 0;
#P pop;
