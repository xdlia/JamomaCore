/* 
 * jcom.return
 * External for Jamoma: return data from our module to the outside world
 * By Tim Place, Copyright � 2006
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "ext.h"				// Max Header
#include "ext_obex.h"			// Max Object Extensions (attributes) Header
#include "commonsyms.h"			// Common symbols used by the Max 4.5 API
#include "jcom.core.h"

enum outlets{
	k_outlet_thru = 0,
	k_outlet_dumpout,
	num_outlets
};


typedef struct _return{							// Data Structure for this object
	t_jcom_core_subscriber_extended	common;
	void 							*outlets[num_outlets];			// my outlet array
	t_atom							output[512];					// buffer that gets sent to the hub
	short							output_len;
} t_return;


// Prototypes
void*	return_new(t_symbol *s, long argc, t_atom *argv);
void	return_assist(t_return *x, void *b, long msg, long arg, char *dst);
void	return_bang(t_return *x);
void	return_int(t_return *x, long n);
void	return_float(t_return *x, double f);
void	return_symbol(t_return *x, t_symbol *msg, long argc, t_atom *argv);
void	return_list(t_return *x, t_symbol *msg, long argc, t_atom *argv);
void	return_send_feedback(t_return *x);
void 	return_dump(t_return *x);

// Globals
t_class		*return_class;				// Required: Global pointer for our class


/************************************************************************************/
// Class Definition

int main(void)				// main recieves a copy of the Max function macros table
{
	long 		attrflags = 0;
	t_class 	*c;
	t_object 	*attr = NULL;
	long		offset;
long obexoffset;	
	// Initialize Globals
	common_symbols_init();

	// Define our class
	c = class_new("jcom.return",(method)return_new, (method)jcom_core_subscriber_common_free, 
		(short)sizeof(t_return), (method)0L, A_GIMME, 0);
	offset = calcoffset(t_return, common);
	obexoffset = offset + calcoffset(t_jcom_core_subscriber_common, obex);
	class_obexoffset_set(c, offset + calcoffset(t_jcom_core_subscriber_common, obex));
	
	// Make methods accessible for our class:
	class_addmethod(c, (method)return_bang,					"bang",			A_CANT, 0L);
	class_addmethod(c, (method)return_int,					"int",			A_DEFLONG,	0L);
	class_addmethod(c, (method)return_float,				"float",		A_DEFFLOAT,	0L);
 	class_addmethod(c, (method)return_list,					"list",			A_GIMME, 0L);
 	class_addmethod(c, (method)return_symbol,				"anything",		A_GIMME, 0L);
	class_addmethod(c, (method)return_dump,					"dump",			0L);
	class_addmethod(c, (method)return_assist,				"assist",		A_CANT, 0L); 

	jcom_core_subscriber_classinit_extended(c, attr, offset);
	
	// ATTRIBUTE: type - options are msg_generic, msg_int, msg_float, msg_symbol, msg_toggle
	attr = attr_offset_new("type", _sym_symbol, attrflags,
		(method)0, (method)0, calcoffset(t_jcom_core_subscriber_extended, attr_type));
	class_addattr(c, attr);
	
	// Finalize our class
	class_register(CLASS_BOX, c);
	return_class = c;
	
	jcom_core_init();
	return 0;
}


/************************************************************************************/
// Object Life

void *return_new(t_symbol *s, long argc, t_atom *argv)
{
	long		attrstart = attr_args_offset(argc, argv);
	t_return	*x = (t_return *)object_alloc(return_class);
	t_symbol	*name = _sym_nothing;

	if(attrstart && argv)
		atom_arg_getsym(&name, 0, attrstart, argv);
	else
		name = symbol_unique();

	if(x){
		x->outlets[k_outlet_dumpout] = outlet_new(x, 0L);
		object_obex_store((void *)x, _sym_dumpout, (t_object *)x->outlets[k_outlet_dumpout]);
		x->outlets[k_outlet_thru] = outlet_new(x, 0L);

		jcom_core_subscriber_new_extended(&x->common, name, ps_subscribe_return);
		atom_setsym(&x->output[0], name);
		x->output_len = 1;
		
		attr_args_process(x, argc, argv);			// handle attribute args
		defer_low(x, (method)jcom_core_subscriber_subscribe, 0, 0, 0);
	}
	return (x);										// return the pointer to our new instantiation
}

/************************************************************************************/
// Methods bound to input/inlets

// Method for Assistance Messages
void return_assist(t_return *x, void *b, long msg, long arg, char *dst)
{
	if(msg==1) 						// Inlet
		strcpy(dst, "data to return via jcom.hub");
	else{							// Outlets
		switch(arg){
			case k_outlet_dumpout:
					strcpy(dst, "dumpout");
					break;
		}
 	}		
}

// DUMP: use for debugging - dump state to the Max window
void return_dump(t_return *x)
{
	char	s[256];
	t_atom	a[4];
	
	if(x->common.hub != NULL){
		sprintf(s, "%s:clipmode", x->common.attr_name->s_name);
		atom_setsym(&a[0], gensym(s));
		atom_setsym(&a[1], x->common.attr_clipmode);
		object_method_typed(x->common.hub, ps_feedback, 2, a, NULL);

		sprintf(s, "%s:description", x->common.attr_name->s_name);
		atom_setsym(&a[0], gensym(s));
		atom_setsym(&a[1], x->common.attr_description);
		object_method_typed(x->common.hub, ps_feedback, 2, a, NULL);
/* TODO: Should we add ramping ability to this object?
		sprintf(s, "%s:ramp", x->common.attr_name->s_name);
		atom_setsym(&a[0], gensym(s));
		atom_setsym(&a[1], x->attr_ramp);
		object_method_typed(x->common.hub, ps_feedback, 2, a, NULL);
*/
		sprintf(s, "%s:range", x->common.attr_name->s_name);
		atom_setsym(&a[0], gensym(s));
		atom_setfloat(&a[1], x->common.attr_range[0]);
		atom_setfloat(&a[2], x->common.attr_range[1]);
		object_method_typed(x->common.hub, ps_feedback, 3, a, NULL);

		sprintf(s, "%s:repetitions", x->common.attr_name->s_name);
		atom_setsym(&a[0], gensym(s));
		atom_setlong(&a[1], x->common.attr_repetitions);
		object_method_typed(x->common.hub, ps_feedback, 2, a, NULL);

		sprintf(s, "%s:type", x->common.attr_name->s_name);
		atom_setsym(&a[0], gensym(s));
		atom_setsym(&a[1], x->common.attr_type);
		object_method_typed(x->common.hub, ps_feedback, 2, a, NULL);
	}
}



// Return values to the hub (so it can return them to the outside world)
void return_send_feedback(t_return *x)
{
	if(x->common.hub != NULL){
		if(x->common.has_wildcard)
			object_method_typed(x->common.hub, ps_return_extended, x->output_len, x->output, NULL);
		else
			object_method_typed(x->common.hub, ps_return, x->output_len, x->output, NULL);
	}
	x->output_len = 1;	// truncate to just the name of this jcom.return object
}


// BANG INPUT - this sends the OSC name with no additional arguments
void return_bang(t_return *x)
{
	x->output_len = 1;
	if(x->common.hub != NULL)
		object_method_typed(x->common.hub, ps_return, x->output_len, x->output, NULL);
	
	outlet_anything(x->outlets[k_outlet_thru], x->common.attr_name, 0, NULL);
}


// INT INPUT
void return_int(t_return *x, long value)
{
	atom_setlong(&x->output[1], value);
	x->output_len = 2;
	return_send_feedback(x);

	outlet_int(x->outlets[k_outlet_thru], value);
}


// FLOAT INPUT
void return_float(t_return *x, double value)
{
	atom_setfloat(&x->output[1], value);
	x->output_len = 2;
	return_send_feedback(x);
	
	outlet_float(x->outlets[k_outlet_thru], value);	
}


// SYMBOL INPUT
void return_symbol(t_return *x, t_symbol *msg, long argc, t_atom *argv)
{
	short i;

	atom_setsym(&x->output[1], msg);
	x->output_len++;
	
	for(i=1; i<=argc; i++){
		jcom_core_atom_copy(&x->output[i+1], argv++);
		x->output_len++;
	}	
	
	outlet_anything(x->outlets[k_outlet_thru], msg, x->output_len-2, &x->output[2]);
	return_send_feedback(x);
}

// LIST INPUT 
void return_list(t_return *x, t_symbol *msg, long argc, t_atom *argv)
{
	short i;
	
	for(i=1; i<=argc; i++){
		jcom_core_atom_copy(&x->output[i], argv++);
		x->output_len++;
	}
	outlet_anything(x->outlets[k_outlet_thru], msg, x->output_len-1, &x->output[1]);
	return_send_feedback(x);
}
