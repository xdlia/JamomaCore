<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<meta http-equiv="content-type" content="text/html;charset=ISO-8859-1">
		<title> jmod.noisgateM~ </title>
		<link href="../styles/jamoma.css" rel="stylesheet" type="text/css">
	</head>

<body>
<div id="jmod_header">
	<img src="../images/jmod.icon.mod.png" width="128" height="128">
	<h1>jmod.noisgateM~</h1>
	<h2>Mono noise gate.</h2>

	<h6><a href="../index.html">Table of Contents</a> | <a href="../modules/">Index of Modules</a> | <a href="http://jamoma.org/">Jamoma.org</a></h6>

	</div>	<h3>Configuration</h3>
	<p> Module Type: <code> audio </code> <br>
	Interface Size: <code> 1U-half </code> </p>

	<p> Number of signal inlets: <code> 1 </code> <br>
	Number of signal outlets: <code> 1 </code> </p>

	<h3>Parameters</h3>

	<table>
		<tr class="tableHeading2">
			<td> Name </td>
			<td> Type </td>
			<td> Range </td>
			<td> Clipmode </td>
			<td> Ramp Enabled </td>
			<td> Repetitions </td>
			<td> Description </td>
		</tr>
		<tr>
			<td class="instructionName"> /bypass </td>
			<td class="instructionType"> toggle </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> When active, this attribute bypasses the module's processing algorithm, letting audio pass through unaffected. </td>
		</tr>
		<tr>
			<td class="instructionName"> /defeat_meters </td>
			<td class="instructionType"> toggle </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> When active, this attribute turns off the signal level meters in the module to conserve CPU. </td>
		</tr>
		<tr>
			<td class="instructionName"> /disable_ui_updates </td>
			<td class="instructionType"> toggle </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Turn off the updating of user interface elements when parameters change.  This may be done to conserve CPU resources. </td>
		</tr>
		<tr>
			<td class="instructionName"> /gain/midi </td>
			<td class="instructionType"> msg_float </td>
			<td class="instructionRange"> 0 158 </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> yes </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Set gain as MIDI value. </td>
		</tr>
		<tr>
			<td class="instructionName"> /lookahead </td>
			<td class="instructionType"> msg_int </td>
			<td class="instructionRange"> 0 100 </td>
			<td class="instructionClipmode"> low </td>
			<td class="instructionRamp"> yes </td>
			<td class="instructionRepetitions"> no </td>
			<td class="instructionDescription"> Lookahead (samples). </td>
		</tr>
		<tr>
			<td class="instructionName"> /mix </td>
			<td class="instructionType"> msg_float </td>
			<td class="instructionRange"> 0 100 </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> yes </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Controls the wet/dry mix of the module's processing routine in percent. </td>
		</tr>
		<tr>
			<td class="instructionName"> /mute </td>
			<td class="instructionType"> toggle </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> When active, this attribute turns off the module's processing algorithm to save CPU </td>
		</tr>
		<tr>
			<td class="instructionName"> /set_clock </td>
			<td class="instructionType"> msg_symbol </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Sync module to external clock. s/set_clock max set module to use the Max scheduler (default behaviour). </td>
		</tr>
		<tr>
			<td class="instructionName"> /sr </td>
			<td class="instructionType"> msg_int </td>
			<td class="instructionRange"> -2 0 </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> no </td>
			<td class="instructionDescription"> Sets the relative sample-rate for this module. </td>
		</tr>
	</table>

	<p>&nbsp;</p>

	<h3>Messages</h3>

	<table>
		<tr class="tableHeading2">
			<td> Name </td>
			<td> Type </td>
			<td> Range </td>
			<td> Clipmode </td>
			<td> Ramp Enabled </td>
			<td> Repetitions </td>
			<td> Description </td>
		</tr>
		<tr>
			<td class="instructionName"> /clear_meters </td>
			<td class="instructionType"> generic </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> no info provided </td>
		</tr>
		<tr>
			<td class="instructionName"> /gain </td>
			<td class="instructionType"> msg_float </td>
			<td class="instructionRange"> -144 0 </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> yes </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Set gain as dB value. </td>
		</tr>
		<tr>
			<td class="instructionName"> /gain/dec </td>
			<td class="instructionType"> generic </td>
			<td class="instructionRange"> N/A </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Increase gain MIDI value by one. </td>
		</tr>
		<tr>
			<td class="instructionName"> /gain/inc </td>
			<td class="instructionType"> generic </td>
			<td class="instructionRange"> N/A </td>
			<td class="instructionClipmode"> none </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Decrease gain MIDI value by one. </td>
		</tr>
		<tr>
			<td class="instructionName"> /get_parameter_names </td>
			<td class="instructionType"> n/a </td>
			<td class="instructionRange"> n/a </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> returns a dump of symbols out the feedback outlet with the names of parameters accessible in this module </td>
		</tr>
		<tr>
			<td class="instructionName"> /help </td>
			<td class="instructionType"> generic </td>
			<td class="instructionRange"> n/a </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> open the online html reference for this module </td>
		</tr>
		<tr>
			<td class="instructionName"> /load_settings </td>
			<td class="instructionType"> msg_symbol </td>
			<td class="instructionRange"> n/a </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> open an xml-preset file and recall the first preset in that file.  An optional argument defines the file to open </td>
		</tr>
		<tr>
			<td class="instructionName"> /preset_recall </td>
			<td class="instructionType"> msg_int </td>
			<td class="instructionRange"> default </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Recall a preset by number - you can also choose presets from the module menu </td>
		</tr>
		<tr>
			<td class="instructionName"> /restore_defaults </td>
			<td class="instructionType"> n/a </td>
			<td class="instructionRange"> n/a </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Open the default preset file and recall the first preset in that file. </td>
		</tr>
		<tr>
			<td class="instructionName"> /save_settings </td>
			<td class="instructionType"> msg_symbol </td>
			<td class="instructionRange"> n/a </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> write an xml-preset file to disk.  An optional argument defines the file to open </td>
		</tr>
		<tr>
			<td class="instructionName"> /view_internals </td>
			<td class="instructionType"> n/a </td>
			<td class="instructionRange"> n/a </td>
			<td class="instructionClipmode"> both </td>
			<td class="instructionRamp"> no </td>
			<td class="instructionRepetitions"> yes </td>
			<td class="instructionDescription"> Attempts to open the internal algorithm for viewing.  This works for most modules.  Some modules may choose to cloak the algorithms - preventing this message from functioning </td>
		</tr>
	</table>

	<p>&nbsp;</p>

	<h3>About Jamoma</h3>
	<p>Jamoma is a system for creating and exchanging structured Max patches.
	It consists of both a set of guidelines and an implementation of those guidelines.
	For more information please visit <a href="http://jamoma.org/">jamoma.org</a>. </p>

</body>
</html>
