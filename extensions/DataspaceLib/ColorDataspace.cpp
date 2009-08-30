/* 
 * Jamoma DataspaceLib: ColorDataspace
 * Copyright © 2007, Tim Place
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "ColorDataspace.h"

// Utility Functions

double hls_value(double n1, double n2, double hue)
{
	if(hue > 360.0) 
		hue -= 360.;
	if(hue < 0.0) 
		hue += 360.;
	if(hue < 60.) 
		return (n1+(n2-n1)*hue/60.);
	if(hue < 180.) 
		return n2;
	if(hue < 240.) 
		return (n1+(n2-n1)*(240-hue)/60.);
	return n1;
}



// Actual Colorspace Units

#define thisTTClass			CMYUnit
#define thisTTClassName		"unit.cmy"
#define thisTTClassTags		"dataspace, color"

TT_DATASPACEUNIT_CONSTRUCTOR{;}
CMYUnit::~CMYUnit(){;}		

void CMYUnit::convertToNeutral(const TTValue& input, TTValue& output)
{
	output.setSize(3);
	output.set(0, (255 - input.getFloat64(0)) * inv255);
	output.set(1, (255 - input.getFloat64(1)) * inv255);
	output.set(2, (255 - input.getFloat64(2)) * inv255);	
}


void CMYUnit::convertFromNeutral(const TTValue& input, TTValue& output)
{
	output.setSize(3);	
	output.set(0, 255 * (1 - input.getFloat64(0)));
	output.set(1, 255 * (1 - input.getFloat64(1)));
	output.set(2, 255 * (1 - input.getFloat64(2)));
}


#undef thisTTClass
#undef thisTTClassName
#undef thisTTClassTags

/***********************************************************************************************/

#define thisTTClass			HSLUnit
#define thisTTClassName		"unit.hsl"
#define thisTTClassTags		"dataspace, color"

TT_DATASPACEUNIT_CONSTRUCTOR{;}
HSLUnit::~HSLUnit(){;}		
		
void HSLUnit::convertToNeutral(const TTValue& input, TTValue& output)
{
	double	h = input.getFloat64(0);// input.getFloat64(0);
	double	s = input.getFloat64(1);// input.getFloat64(1);
	double	l = input.getFloat64(2);// input.getFloat64(2);
	double	red, green, blue;
	double	m1, m2, hue, lightness, saturation;

	// scale to floating point... number range should be 360, 1, 1
	hue = h;
	saturation = s/100.0;
	lightness = l/100.0;

	if(lightness <= 0.5) 
		m2 = lightness*(1.0+saturation); 
	else 
		m2 = lightness+saturation-lightness*saturation;
	
	m1 = 2.0 * lightness-m2;
	if(saturation == 0.0){
		red = lightness;
		green = lightness;
		blue = lightness;
	} 
	else{
		red = hls_value(m1, m2, hue+120.0);
		green = hls_value(m1, m2, hue);
		blue = hls_value(m1, m2, hue-120.0);
	}
	
	output.setSize(3);
	output.set(0, red);
	output.set(1, green);
	output.set(2, blue);	
}


void HSLUnit::convertFromNeutral(const TTValue& input, TTValue& output)
{
	double	r = (input.getFloat64(0));
	double	g = (input.getFloat64(1));
	double	b = (input.getFloat64(2));
	double	hue, lightness, saturation;
	double	max,min,delta;
	double	H,L,S;
	
	max = r;
	if(max<g)
		max=g;
	if(max<b)
		max=b;
	
	min = r;
	if(min>g)
		min=g;
	if(min>b)
		min=b;
	
	L = (max+min)/2.0;
	if(max == min){
		S = 0;
		H = 0;
	}
	else{
		delta = max-min;
		if(L < 0.5)
			S = delta/(max+min);
		else 
			S = delta/(2.0-max-min);
		if(r == max)
			H = (g-b)/delta;
		else if(g == max)
			H = 2.0+(b-r)/delta;
		else if(b == max) 
			H = 4.0+(r-g)/delta;
	}
	
	H *= 60.0; 
	if(H < 0) 
		H += 360.0;
	
	hue = H;
	saturation = S * 100.0;
	lightness = L * 100.0;

	output.setSize(3);	
	output.set(0, hue);
	output.set(1, saturation);
	output.set(2, lightness);
}


#undef thisTTClass
#undef thisTTClassName
#undef thisTTClassTags

/***********************************************************************************************

Code for RGB <-> HSV convertion is in part based on source code provided by Marcelo Gattass:
http://www.tecgraf.puc-rio.br/~mgattass/color/ColorIndex.html
Last retrieved 2009-07-30

License:

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

#define thisTTClass			HSVUnit
#define thisTTClassName		"unit.hsv"
#define thisTTClassTags		"dataspace, color"

TT_DATASPACEUNIT_CONSTRUCTOR{;}
HSVUnit::~HSVUnit(){;}		

void HSVUnit::convertToNeutral(const TTValue& input, TTValue& output)
{
	double	h = input.getFloat64(0)/360.;
	double	s = input.getFloat64(1)/100.;
	double	v = input.getFloat64(2)/100.;
	double	r, g, b;
	//double	h1, a[7], q, f;                             

	if ( s == 0 )
	{
		r = v;
		g = v;
		b = v;
	}
	else
	{
		double var_h = h * 6;
		double var_i = floor( var_h );
		double var_1 = v * ( 1 - s );
		double var_2 = v * ( 1 - s * ( var_h - var_i ) );
		double var_3 = v * ( 1 - s * ( 1 - ( var_h - var_i ) ) );

		if      ( var_i == 0 ) { r = v     ; g = var_3 ; b = var_1; }
		else if ( var_i == 1 ) { r = var_2 ; g = v     ; b = var_1; }
		else if ( var_i == 2 ) { r = var_1 ; g = v     ; b = var_3; }
		else if ( var_i == 3 ) { r = var_1 ; g = var_2 ; b = v;     }
		else if ( var_i == 4 ) { r = var_3 ; g = var_1 ; b = v;     }
		else                   { r = v     ; g = var_1 ; b = var_2; }
	}
				
	output.setSize(3);
	output.set(0, r);
	output.set(1, g);
	output.set(2, b);	
}


void HSVUnit::convertFromNeutral(const TTValue& input, TTValue& output)
{
	double r = input.getFloat64(0);
	double g = input.getFloat64(1);
	double b = input.getFloat64(2);

	double h,s,v;

	double min;
	double max;
	double delta;

	//Min. value of RGB
	min = r;
	if (g<min) min = g;
	if (b<min) min = b;
		
	//Max. value of RGB
	max = r;
	if (g>max) max = g;
	if (b>max) max = b;
	
	//Delta RGB value
	delta = max - min;

	v = max;

	if ( max == 0 )
	{
	   h = 0;
	   s = 0;
	}
	else
	{
		s = delta / max;

		if(r == max)
			h = (g-b)/delta;
		else if(g == max)
			h = 2.0+(b-r)/delta;
		else if(b == max) 
			h = 4.0+(r-g)/delta;
		
		h *= 60.0; 
		if(h < 0) 
			h += 360.0;
	}

	output.setSize(3);	
	output.set(0, h);
	output.set(1, s*100);
	output.set(2, v*100);
}


#undef thisTTClass
#undef thisTTClassName
#undef thisTTClassTags

/***********************************************************************************************/

#define thisTTClass			RGBUnit
#define thisTTClassName		"unit.rgb"
#define thisTTClassTags		"dataspace, color"

TT_DATASPACEUNIT_CONSTRUCTOR{;}
RGBUnit::~RGBUnit(){;}		

void RGBUnit::convertToNeutral(const TTValue& input, TTValue& output)
{
	output = input;
}


void RGBUnit::convertFromNeutral(const TTValue& input, TTValue& output)
{
	output = input;
}


#undef thisTTClass
#undef thisTTClassName
#undef thisTTClassTags

/***********************************************************************************************/

#define thisTTClass			RGB8Unit
#define thisTTClassName		"unit.rgb8"
#define thisTTClassTags		"dataspace, color"

TT_DATASPACEUNIT_CONSTRUCTOR{;}
RGB8Unit::~RGB8Unit(){;}		

void RGB8Unit::convertToNeutral(const TTValue& input, TTValue& output)
{
	output.setSize(3);
	output.set(0, input.getFloat64(0)*inv255);
	output.set(1, input.getFloat64(1)*inv255);
	output.set(2, input.getFloat64(2)*inv255);	
}


void RGB8Unit::convertFromNeutral(const TTValue& input, TTValue& output)
{
	output.setSize(3);
	output.set(0, input.getFloat64(0)*255);
	output.set(1, input.getFloat64(1)*255);
	output.set(2, input.getFloat64(2)*255);
}


#undef thisTTClass
#undef thisTTClassName
#undef thisTTClassTags

/***********************************************************************************************/

#define thisTTClass			ColorDataspace
#define thisTTClassName		"dataspace.color"
#define thisTTClassTags		"dataspace, color"

TT_DATASPACELIB_CONSTRUCTOR
//ColorDataspace::ColorDataspace()
//	: DataspaceLib("color", "rgb")
{
	// Create one of each kind of unit, and cache them in a hash
//	registerUnit(new CMYUnit,		SymbolGen("cmy"));
//	registerUnit(new HSLUnit,		SymbolGen("hsl"));
//	registerUnit(new HSVUnit,		SymbolGen("hsv"));
//	registerUnit(new RGBUnit,		SymbolGen("rgb"));
//	registerUnit(new RGB8Unit,		SymbolGen("rgb8"));
	
	// Now that the cache is created, we can create a set of default units
	setInputUnit(neutralUnit);
	setOutputUnit(neutralUnit);
}


ColorDataspace::~ColorDataspace()
{
	;
}

#undef thisTTClass
#undef thisTTClassName
#undef thisTTClassTags
