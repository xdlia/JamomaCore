////////////////
// by Matt
// for Jamoma
// License: GNU LGPL
  
inlets = 2;
//autowatch = 1; //take this out???

var height = box.rect[3] - box.rect[1];  
var width = box.rect[2] - box.rect[0]; 
var aspect = width/height;
var pixeldim = sketch.worldtoscreen(aspect,-1) ; //dimensions in pixels
var pwidth = pixeldim[0]; //width in pixels
var pheight = pixeldim[1] ;//height in pixels
var systemrate = 44100; //the supposed sampling rate of the system
var ratedivision =0; // scale from -2 to +2.   X1/4, X1/2 1X 2X 4X
var displayrate = 44100; //to be computed by combining systemrate and ratedivision
var fiverates = new Array(11025,22050,44100,88200,176400); 

function loadbang ()
{
notifyclients();
draw();
}

function setvalueof(indiv,insamp)//pattr in
{
////next two lines for system sampling rate///
	systemrate = insamp;  
	fiverates = [insamp/4,insamp/2, insamp, insamp*2,insamp*4];  
	
////rest of function for the ratedtivision/////////
if( indiv >= -2 && indiv <= 2)
	{
	limit(indiv); 
	displayrate = fiverates[ratedivision+2]; 
	outlet(0,ratedivision);
	}
else 
	{
	for ( count = 0; count < 5 ; count++)//searches fiverates array for a match
		{
		if (fiverates[count] == indiv)//tests current count of fiverates for match
			{
			displayrate = indiv; 
			ratedivision = count-2; //adjusts from array to -2 - +2 scale
			outlet(0,ratedivision);
			}	
		}
	}
notifyclients();//??
draw();
}

function getvalueof()//pattr out
{
var a= new Array(ratedivision,systemrate);
return a;
}

function msg_int(into)
{
if (inlet==1)  //below block for inlet1
	{
	systemrate = into; 
	fiverates = [into/4,into/2, into, into*2,into*4];//compute array
	ratedivision = 0;
	displayrate = into;
	outlet(0,ratedivision);
	}
else if( into >= -2 && into <= 2) //below for inlet two if -2 - +2 scale
	{
	limit(into);
	displayrate = fiverates[ratedivision+2];
	outlet(0,ratedivision);
	}
else //below block for inlet2 if desired samplerate scale
	{
	for ( count = 0; count < 5 ; count++)//searches fiverates array for a match
		{
		if (fiverates[count] ==into)//tests current count of fiverates for match
			{
			displayrate = into;
			ratedivision = count-2;//adjusts from array to -2 - +2 scale
			outlet(0,ratedivision);
			}	
		}
	}
notifyclients(); //for pattr
draw();
}

/* theres a weird thing where if you "double click" on jsui it doesn't send button off messages?
I dont know what to do about it, but its not worth  shooting myself for*/
function onclick(x,y,button)  
{clicky(y,1);}

function ondrag (x,y,button)
{clicky(y,0);}

function clicky(y,button) 
{
var arrows; 
if (button == 1 && y > 8)//click bottom arrow
	{
	arrows=1;
	limit(ratedivision-1);
	}
else if  (button == 1 && y <= 8)//click top arrow
	{
	arrows=2;
	limit(ratedivision+1);
	}
else//button up 
	{arrows = 0;}   

notifyclients();
draw(arrows);
outlet(0,ratedivision);
}

function limit(x)  //limit any int to  -2 - +2
{
ratedivision = Math.min (2,Math.max(-2,x)); // here comes the science
displayrate = fiverates[ratedivision+2];
}

function drawnumber() //does what it says
{
sketch.font("Times New Roman");
sketch.fontsize(12);
sketch.glcolor(.8,.8,.8);
sketch.moveto(sketch.screentoworld(4,4)); 
sketch.textalign("left","top"); //aligns to top left corner of jsui
sketch.text(displayrate.toString() ); 
}


function onresize()  //when resized, compute dimensions again and draw 
{
 height = box.rect[3] - box.rect[1]; 
 width = box.rect[2] - box.rect[0]; 
 aspect = width/height;
 pixeldim = sketch.worldtoscreen(aspect,-1);
 pwidth = pixeldim[0];
 pheight = pixeldim[1];
draw(0);
}


function black() //actually grey to match jmod menu back.  (not quite?)
{
sketch.glclearcolor(.1,.1,.1,0);
sketch.glclear();
}


function arrows(down)//argument 0 for no highlight 1 for down, 2 for up// down for button down on which triangle?
{
sketch.glcolor(.5,.5,.5);//forground color
sketch.tri (sketch.screentoworld(pwidth-10,9),sketch.screentoworld(pwidth-2,9),sketch.screentoworld(pwidth-6,14)); //up
sketch.tri (sketch.screentoworld(pwidth-10,7),sketch.screentoworld(pwidth-2,7),sketch.screentoworld(pwidth-6,2)); //down
sketch.glcolor(1,1,1); //highlight color
if (down==1)
	{
	sketch.tri (sketch.screentoworld(pwidth-10,9),sketch.screentoworld(pwidth-2,9),sketch.screentoworld(pwidth-6,14));
	}
else if (down == 2)
	{
	sketch.tri (sketch.screentoworld(pwidth-10,7),sketch.screentoworld(pwidth-2,7),sketch.screentoworld(pwidth-6,2));
	}
}

function draw(arr) //arr for which arrow to draw
{
black(); //background
arrows(arr); //arrows
drawnumber();//number
refresh();//refreshing!
}

//all done. love you. byebye! :)