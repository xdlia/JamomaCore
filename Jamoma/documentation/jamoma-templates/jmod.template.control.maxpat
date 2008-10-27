{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 50.0, 94.0, 916.0, 557.0 ],
		"bglocked" : 0,
		"defrect" : [ 50.0, 94.0, 916.0, 557.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 10.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "for jcom.return only",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-2",
					"fontname" : "Verdana",
					"patching_rect" : [ 430.0, 515.0, 113.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@enable",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-25",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 535.0, 77.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "1/0 : enables the send of data (on by default)",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-28",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 535.0, 302.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "ParameterA[1]",
					"presentation" : 1,
					"triscale" : 0.9,
					"triangle" : 0,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"presentation_rect" : [ 230.0, 35.0, 35.0, 19.0 ],
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-17",
					"fontname" : "Verdana",
					"patching_rect" : [ 395.0, 65.0, 37.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Message",
					"presentation" : 1,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"presentation_rect" : [ 162.0, 37.0, 62.0, 19.0 ],
					"id" : "obj-18",
					"fontname" : "Verdana",
					"patching_rect" : [ 320.0, 65.0, 77.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "hue_angle[1]",
					"text" : "jcom.message this_message @repetitions/allow 0 @type msg_float @range/bounds 0. 1. @range/clipmode none @description \"Document what this message does...\"",
					"linecount" : 2,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"id" : "obj-19",
					"fontname" : "Verdana",
					"patching_rect" : [ 440.0, 60.0, 457.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"varname" : "ParameterA",
					"presentation" : 1,
					"triscale" : 0.9,
					"triangle" : 0,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"presentation_rect" : [ 90.0, 35.0, 35.0, 19.0 ],
					"outlettype" : [ "float", "bang" ],
					"id" : "obj-3",
					"fontname" : "Verdana",
					"patching_rect" : [ 395.0, 30.0, 37.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Parameter",
					"presentation" : 1,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"presentation_rect" : [ 25.0, 35.0, 62.0, 19.0 ],
					"id" : "obj-1",
					"fontname" : "Verdana",
					"patching_rect" : [ 320.0, 30.0, 77.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "hue_angle",
					"text" : "jcom.parameter this_parameter @repetitions/allow 0 @type msg_float @range/bounds 0. 1. @range/clipmode none @description \"Document what this parameter does...\"",
					"linecount" : 2,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"id" : "obj-29",
					"fontname" : "Verdana",
					"patching_rect" : [ 440.0, 25.0, 456.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@ramp/scheduler",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-20",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 405.0, 105.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "scheduler/queue...",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-21",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 405.0, 105.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@description",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-45",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 485.0, 75.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@repetitions/allow",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-46",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 425.0, 105.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@ramp/function",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-47",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 385.0, 92.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@range/clipmode",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-48",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 465.0, 101.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@range/bounds",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-49",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 445.0, 91.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "@type",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-50",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 365.0, 44.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "If you need to return messages from your algorithm to the rest of the world. you can specify type, range... etc as in jcom.parameter or jcom.message",
					"linecount" : 3,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-4",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 290.0, 370.0, 43.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "jcom.return:",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-5",
					"fontname" : "Verdana",
					"patching_rect" : [ 430.0, 270.0, 380.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "If you need to send messages to or within the patch, but it's not required that they be stored or retrieveable, use jcom.message.",
					"linecount" : 2,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-6",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 230.0, 342.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "jcom.message:",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-7",
					"fontname" : "Verdana",
					"patching_rect" : [ 430.0, 210.0, 366.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Use this for any parameters that you'd like to be able to store and retrieve.",
					"linecount" : 2,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-8",
					"fontname" : "Verdana",
					"patching_rect" : [ 455.0, 170.0, 363.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "jcom.parameter:",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-9",
					"fontname" : "Verdana",
					"patching_rect" : [ 430.0, 150.0, 293.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "for html autodoc of module",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-10",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 485.0, 149.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "1 (default)/0 --- 1 means that repetitions are allowed",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-11",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 425.0, 282.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "none/linear/cosine/power/tanh/lowpass...",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-12",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 385.0, 221.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "none, low, high, both (default)",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-13",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 465.0, 166.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "minimum and maximum values for this parameter/message",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-14",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 445.0, 314.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "generic (default), msg_int, msg_float, menu, toggle",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-15",
					"fontname" : "Verdana",
					"patching_rect" : [ 565.0, 365.0, 273.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Attributes for jcom.parameter and jcom.message:",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"frgb" : [ 0.933333, 0.937255, 0.968627, 1.0 ],
					"numoutlets" : 0,
					"id" : "obj-51",
					"fontname" : "Verdana",
					"patching_rect" : [ 430.0, 345.0, 295.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/preset/store 1 default, /preset/write",
					"fontsize" : 10.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-22",
					"fontname" : "Verdana",
					"patching_rect" : [ 50.0, 90.0, 251.0, 17.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.return return_c @range/bounds 0. 1. @description \"Document what this return does...\"",
					"linecount" : 2,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"id" : "obj-23",
					"fontname" : "Verdana",
					"patching_rect" : [ 115.0, 305.0, 284.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.in",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"id" : "obj-24",
					"fontname" : "Verdana",
					"patching_rect" : [ 115.0, 240.0, 56.0, 19.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/init",
					"fontsize" : 10.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-32",
					"fontname" : "Verdana",
					"patching_rect" : [ 240.0, 110.0, 40.0, 17.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p your_algorithm",
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-33",
					"fontname" : "Verdana",
					"patching_rect" : [ 115.0, 280.0, 112.0, 19.0 ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 585.0, 154.0, 549.0, 562.0 ],
						"bglocked" : 0,
						"defrect" : [ 585.0, 154.0, 549.0, 562.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 10.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 5.0, 5.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"metadata" : [  ],
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "newobj",
									"text" : "jcom.oscroute /param_a /message_b",
									"fontsize" : 9.0,
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "", "", "" ],
									"id" : "obj-1",
									"fontname" : "Arial",
									"patching_rect" : [ 70.0, 90.0, 180.0, 17.0 ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "outlet",
									"numinlets" : 1,
									"numoutlets" : 0,
									"id" : "obj-2",
									"patching_rect" : [ 70.0, 474.0, 15.0, 15.0 ],
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "inlet",
									"numinlets" : 0,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"id" : "obj-3",
									"patching_rect" : [ 70.0, 50.0, 15.0, 15.0 ],
									"comment" : ""
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Substitute this patch for your algorithm",
									"textcolor" : [ 0.392157, 0.403922, 0.901961, 1.0 ],
									"fontsize" : 18.0,
									"numinlets" : 1,
									"frgb" : [ 0.392157, 0.403922, 0.901961, 1.0 ],
									"numoutlets" : 0,
									"id" : "obj-4",
									"fontname" : "Arial",
									"patching_rect" : [ 70.0, 155.0, 398.0, 27.0 ]
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"source" : [ "obj-3", 0 ],
									"destination" : [ "obj-1", 0 ],
									"hidden" : 0,
									"midpoints" : [  ]
								}

							}
 ]
					}
,
					"saved_object_attributes" : 					{
						"globalpatchername" : "",
						"default_fontface" : 0,
						"fontface" : 0,
						"fontsize" : 10.0,
						"default_fontname" : "Arial",
						"default_fontsize" : 10.0,
						"fontname" : "Arial"
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "jcom.hub",
					"text" : "jcom.hub @module_type control @description \"This module doesn't do much yet\"",
					"linecount" : 2,
					"fontsize" : 10.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"id" : "obj-37",
					"fontname" : "Verdana",
					"patching_rect" : [ 15.0, 140.0, 302.0, 31.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-38",
					"patching_rect" : [ 15.0, 90.0, 22.0, 22.0 ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"numoutlets" : 0,
					"id" : "obj-39",
					"patching_rect" : [ 15.0, 180.0, 22.0, 22.0 ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/mute 0",
					"fontsize" : 10.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-41",
					"fontname" : "Verdana",
					"patching_rect" : [ 235.0, 280.0, 90.0, 17.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/documentation/generate",
					"fontsize" : 10.0,
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"id" : "obj-43",
					"fontname" : "Verdana",
					"patching_rect" : [ 75.0, 110.0, 159.0, 17.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.ui",
					"text" : "/editing_this_module",
					"presentation" : 1,
					"numinlets" : 1,
					"numoutlets" : 1,
					"presentation_rect" : [ 0.0, 0.0, 300.0, 70.0 ],
					"outlettype" : [ "" ],
					"id" : "obj-16"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-37", 0 ],
					"destination" : [ "obj-39", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-32", 0 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 0,
					"midpoints" : [ 249.5, 133.0, 24.5, 133.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-38", 0 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-43", 0 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 0,
					"midpoints" : [ 84.5, 133.0, 24.5, 133.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-37", 0 ],
					"hidden" : 0,
					"midpoints" : [ 59.5, 133.0, 24.5, 133.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-33", 0 ],
					"destination" : [ "obj-23", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-29", 0 ],
					"destination" : [ "obj-3", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-29", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-17", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-41", 1 ],
					"hidden" : 0,
					"midpoints" : [ 124.5, 267.0, 315.5, 267.0 ]
				}

			}
 ]
	}

}
