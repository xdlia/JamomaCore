{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 41.0, 53.0, 782.0, 472.0 ],
		"bglocked" : 0,
		"defrect" : [ 41.0, 53.0, 782.0, 472.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 1,
		"default_fontsize" : 10.970939,
		"default_fontface" : 0,
		"default_fontname" : "Verdana",
		"gridonopen" : 0,
		"gridsize" : [ 5.0, 5.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"metadata" : [  ],
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "jit.pwindow",
					"numinlets" : 1,
					"patching_rect" : [ 235.0, 20.0, 60.0, 45.0 ],
					"presentation" : 1,
					"numoutlets" : 2,
					"id" : "obj-33",
					"outlettype" : [ "", "" ],
					"presentation_rect" : [ 235.0, 20.0, 60.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"patching_rect" : [ 103.0, 365.0, 13.0, 13.0 ],
					"numoutlets" : 0,
					"id" : "obj-1",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.out 2",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"patching_rect" : [ 79.0, 335.0, 62.0, 18.0 ],
					"numoutlets" : 3,
					"id" : "obj-2",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numinlets" : 0,
					"patching_rect" : [ 182.0, 208.0, 13.0, 13.0 ],
					"numoutlets" : 1,
					"id" : "obj-3",
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "VIDEO INPUT",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 197.0, 208.0, 75.0, 18.0 ],
					"numoutlets" : 0,
					"id" : "obj-4",
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.in 1",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 182.0, 227.0, 78.0, 18.0 ],
					"numoutlets" : 3,
					"id" : "obj-5",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "pcontrol",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 79.0, 273.0, 49.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-6",
					"outlettype" : [ "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jcom.pass open",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 79.0, 252.0, 86.0, 18.0 ],
					"numoutlets" : 2,
					"id" : "obj-7",
					"outlettype" : [ "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"patching_rect" : [ 79.0, 364.0, 13.0, 13.0 ],
					"numoutlets" : 0,
					"id" : "obj-8",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "VIDEO OUTPUTS",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 122.0, 366.0, 92.0, 18.0 ],
					"numoutlets" : 0,
					"id" : "obj-9",
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "jalg.motiongram%",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"patching_rect" : [ 79.0, 298.0, 113.0, 18.0 ],
					"numoutlets" : 2,
					"id" : "obj-10",
					"outlettype" : [ "jit_matrix", "jit_matrix" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 360.0, 22.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-12",
					"outlettype" : [ "bang" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"varname" : "export",
					"text" : "export",
					"numinlets" : 2,
					"fontsize" : 10.0,
					"patching_rect" : [ 350.0, 341.0, 41.0, 17.0 ],
					"presentation" : 1,
					"numoutlets" : 1,
					"id" : "obj-13",
					"outlettype" : [ "" ],
					"fontname" : "Verdana",
					"presentation_rect" : [ 150.0, 46.0, 41.0, 17.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 278.0, 22.0, 18.0 ],
					"numoutlets" : 1,
					"id" : "obj-15",
					"outlettype" : [ "bang" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"varname" : "clear",
					"text" : "clear",
					"numinlets" : 2,
					"fontsize" : 10.0,
					"patching_rect" : [ 349.0, 258.0, 35.0, 17.0 ],
					"presentation" : 1,
					"numoutlets" : 1,
					"id" : "obj-16",
					"outlettype" : [ "" ],
					"fontname" : "Verdana",
					"presentation_rect" : [ 150.0, 26.0, 35.0, 17.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "jmod.parameter.mxb[2]",
					"text" : "jcom.message exportimage @type msg_none @description \"Clears the image.\"",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 382.0, 404.0, 18.0 ],
					"numoutlets" : 3,
					"id" : "obj-17",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "jmod.parameter.mxb[1]",
					"text" : "jcom.message clear @type msg_none @description \"Clears the image.\"",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 300.0, 365.0, 18.0 ],
					"numoutlets" : 3,
					"id" : "obj-18",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"numinlets" : 1,
					"fontsize" : 10.0,
					"patching_rect" : [ 351.0, 195.0, 36.0, 19.0 ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"presentation" : 1,
					"numoutlets" : 2,
					"id" : "obj-19",
					"outlettype" : [ "int", "bang" ],
					"triangle" : 0,
					"fontname" : "Verdana",
					"triscale" : 0.9,
					"presentation_rect" : [ 89.546417, 45.0, 36.0, 19.0 ],
					"minimum" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "dimensions/height",
					"text" : "jcom.parameter dimensions/height @type msg_int @range/bounds 0 2000 @range/clipmode low @ramp/drive none @description \"Specify the x-axis offset in pixels.\"",
					"linecount" : 2,
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 217.0, 460.0, 30.0 ],
					"numoutlets" : 3,
					"id" : "obj-21",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"numinlets" : 1,
					"fontsize" : 10.0,
					"patching_rect" : [ 350.0, 113.0, 36.0, 19.0 ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"presentation" : 1,
					"numoutlets" : 2,
					"id" : "obj-22",
					"outlettype" : [ "int", "bang" ],
					"triangle" : 0,
					"fontname" : "Verdana",
					"triscale" : 0.9,
					"presentation_rect" : [ 52.0, 45.0, 36.0, 19.0 ],
					"minimum" : 1
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "size",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 6.0, 42.0, 27.0, 18.0 ],
					"presentation" : 1,
					"numoutlets" : 0,
					"id" : "obj-23",
					"frgb" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"textcolor" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"fontname" : "Verdana",
					"presentation_rect" : [ 6.0, 45.0, 27.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"numinlets" : 1,
					"fontsize" : 10.0,
					"patching_rect" : [ 350.0, 34.0, 67.0, 19.0 ],
					"presentation" : 1,
					"types" : [  ],
					"numoutlets" : 3,
					"id" : "obj-24",
					"outlettype" : [ "int", "", "" ],
					"fontname" : "Verdana",
					"presentation_rect" : [ 42.0, 25.0, 84.48542, 19.0 ],
					"pattrmode" : 1,
					"items" : [ "horizontal", ",", "vertical" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "mode",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 6.0, 22.0, 36.0, 18.0 ],
					"presentation" : 1,
					"numoutlets" : 0,
					"id" : "obj-25",
					"frgb" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"textcolor" : [ 0.584314, 0.584314, 0.584314, 1.0 ],
					"fontname" : "Verdana",
					"presentation_rect" : [ 6.0, 25.0, 36.0, 18.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "dimensions/width",
					"text" : "jcom.parameter dimensions/width @type msg_int @range/bounds 0 2000 @range/clipmode low @ramp/drive none @description \"Specify the x-axis offset in pixels.\"",
					"linecount" : 2,
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 136.0, 460.0, 30.0 ],
					"numoutlets" : 3,
					"id" : "obj-26",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "mode",
					"text" : "jcom.parameter mode @type menu @description \"Mode - horizontal or vertical direction of motiongram.\"",
					"linecount" : 2,
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 349.0, 55.0, 285.0, 30.0 ],
					"numoutlets" : 3,
					"id" : "obj-27",
					"outlettype" : [ "", "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"varname" : "jmod.hub",
					"text" : "jcom.hub jmod.motiongram% @module_type video @algorithm_type jitter @description \"Creates a motiongram from running video stream\"",
					"linecount" : 3,
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 0.0, 109.0, 272.0, 42.0 ],
					"numoutlets" : 2,
					"id" : "obj-28",
					"outlettype" : [ "", "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "/documentation/generate",
					"numinlets" : 2,
					"fontsize" : 9.873845,
					"patching_rect" : [ 103.0, 87.0, 135.0, 16.0 ],
					"bgcolor" : [ 0.8, 0.54902, 0.54902, 1.0 ],
					"numoutlets" : 1,
					"id" : "obj-29",
					"outlettype" : [ "" ],
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "command input",
					"numinlets" : 1,
					"fontsize" : 9.873845,
					"patching_rect" : [ 14.0, 84.0, 86.0, 18.0 ],
					"numoutlets" : 0,
					"id" : "obj-30",
					"fontname" : "Verdana"
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "outlet",
					"numinlets" : 1,
					"patching_rect" : [ 0.0, 171.0, 13.0, 13.0 ],
					"numoutlets" : 0,
					"id" : "obj-31",
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "inlet",
					"numinlets" : 0,
					"patching_rect" : [ 0.0, 84.0, 13.0, 13.0 ],
					"numoutlets" : 1,
					"id" : "obj-32",
					"outlettype" : [ "" ],
					"comment" : ""
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "jcom.ui",
					"text" : "/editing_this_module",
					"prefix" : "video",
					"numinlets" : 1,
					"presentation" : 1,
					"has_mute" : 1,
					"numoutlets" : 1,
					"id" : "obj-34",
					"has_preview" : 1,
					"outlettype" : [ "" ],
					"has_bypass" : 1,
					"presentation_rect" : [ 0.0, 0.0, 300.0, 70.0 ],
					"has_freeze" : 1,
					"color" : [ 1.0, 1.0, 1.0, 1.0 ]
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-15", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-28", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-32", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-29", 0 ],
					"destination" : [ "obj-28", 0 ],
					"hidden" : 0,
					"midpoints" : [ 112.5, 105.0, 9.5, 105.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-26", 0 ],
					"destination" : [ "obj-22", 0 ],
					"hidden" : 0,
					"midpoints" : [ 358.5, 168.0, 336.0, 168.0, 336.0, 108.0, 359.5, 108.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-27", 0 ],
					"destination" : [ "obj-24", 0 ],
					"hidden" : 0,
					"midpoints" : [ 358.5, 87.0, 336.0, 87.0, 336.0, 30.0, 359.5, 30.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-21", 0 ],
					"destination" : [ "obj-19", 0 ],
					"hidden" : 0,
					"midpoints" : [ 358.5, 249.0, 336.0, 249.0, 336.0, 192.0, 360.5, 192.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 1 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [ 221.0, 248.0, 88.5, 248.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 0 ],
					"destination" : [ "obj-6", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-6", 0 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-7", 1 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [ 155.5, 294.0, 88.5, 294.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-2", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-8", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 1 ],
					"destination" : [ "obj-1", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 1 ],
					"destination" : [ "obj-2", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-3", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-10", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-24", 0 ],
					"destination" : [ "obj-27", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-22", 0 ],
					"destination" : [ "obj-26", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-21", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-18", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-17", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-34", 0 ],
					"destination" : [ "obj-33", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
 ]
	}

}
