/* 
 * jcom.minuit
 * External for Jamoma : ...
 * By Stan Bundervoet, Théo de la Hogue, Copyright 2009
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */
#include "jcom.minuit.h"

// Globals
t_class		*node_class;

// implementation
#if 0
#pragma mark -
#pragma mark Class Definition
#endif 0

int JAMOMA_EXPORT_MAXOBJ main(void)
{
	t_class *c;
	
	jamoma_init();
	common_symbols_init();

	// Define our class
	c = class_new("jcom.minuit",(method)node_new, (method)node_free, (long)sizeof(t_node), 0L, A_GIMME, 0);

	// add methods
	class_addmethod(c, (method)node_notify,			"notify",		A_CANT, 0);
	class_addmethod(c, (method)node_assist,			"assist",		A_CANT, 0);

	// this method posts the children (leaves or nodes) and the properties of the node which address is given
	class_addmethod(c, (method)minuit_namespace,	"?namespace",	A_SYM, 0);
	class_addmethod(c, (method)minuit_get,			"?get",			A_SYM, 0);
	class_addmethod(c, (method)minuit_set,			"?set",			A_GIMME, 0);

	// Finalize our class
	class_register(CLASS_BOX, c);
	node_class = c;
	return 0;
}

#if 0
#pragma mark -
#pragma mark Life Cycle
#endif 0

void *node_new(t_symbol *name, long argc, t_atom *argv)
{
	t_node *x;

	x = (t_node*)object_alloc(node_class);
	x->p_out = outlet_new(x, 0);

	if(x){

		// default : get the root of the tree
		x->p_node = jamoma_node_init();

	}
	return x;
}

void node_free(t_node *x)
{
	;
}

#if 0
#pragma mark -
#pragma mark Methods
#endif 0

t_max_err node_notify(t_node *x, t_symbol *s, t_symbol *msg, void *sender, void *data)
{
	object_post((t_object *)x, "notification : %s", msg->s_name);
	return MAX_ERR_NONE;
}

void node_assist(t_node *x, void *b, long msg, long arg, char *dst)
{
	if (msg == ASSIST_INLET) { // inlet
		//if(arg == 0)
		//strcpy(dst, "I am inlet 0");
	} 
	else {	// outlet
		//if(arg == 0)
		//strcpy(dst, "I am outlet 0");
	}		
}

void minuit_namespace(t_node *x, t_symbol *address)
{
	defer(x, (method)minuit_donamespace, address, 0, 0);
}

void minuit_donamespace(t_node *x, t_symbol *address)
{

	short i, count;
	char *temp = NULL;
	TTListPtr lk_prp, lk_chd;
	t_linklist *lk_leaves, *lk_nodes;
	TTSymbolPtr n_attr;
	t_symbol *n_type;
	t_symbol *n_instance;
	t_atom a_answer[1024];
	
	// prepare answer
	atom_setsym(a_answer, address);
	count = 1;
	
	node_goto(x, address);

	// Il nous faut avoir les noeuds inférieurs et les attributs du noeud à l'addresse données
	if(x->p_node && x->address){
		
		lk_prp = jamoma_node_properties(x->p_node);
		lk_chd = jamoma_node_children(x->p_node);
		
		// the two lists for the nodes and leaves
		lk_leaves = linklist_new();
		lk_nodes = linklist_new();
		
		// if there are properties
		if(lk_prp){
			
			atom_setsym(a_answer+count, gensym("attributes={"));
			count++;
			
			// write an outline for each attribut
			for(lk_prp->begin(); lk_prp->end(); lk_prp->next()){
				
				lk_prp->current().get(0,(TTSymbolPtr*)&n_attr);
				atom_setsym(a_answer+count, gensym((char*)n_attr->getCString()));
				count++;
			} 
			atom_setsym(a_answer+count, gensym("}"));
			count++;
		}
		
		// if there are children
		if(lk_chd){
			
			//a check if its leaves or nodes
			for(lk_chd->begin(); lk_chd->end(); lk_chd->next()){
				
				lk_chd->current().get(0,(TTPtr*)&x->p_node);
				n_type = jamoma_node_type(x->p_node);
				
				if((n_type == gensym("container")) || (n_type == gensym("hub")))
					linklist_append(lk_nodes, x->p_node);
				else
					if(n_type == gensym("subscribe_parameter"))
						linklist_append(lk_leaves, x->p_node);
			}
			
			if(linklist_getsize(lk_nodes)){
				
				atom_setsym(a_answer+count, gensym("nodes={"));
				count++;
				
				for(i=0; i<linklist_getsize(lk_nodes); i++){
					// get the name
					x->p_node = (TTNodePtr)linklist_getindex(lk_nodes,i);
					temp = (char*)malloc(sizeof(char)*256);
					strcpy(temp,jamoma_node_name(x->p_node)->s_name);
					
					// get instance
					n_instance = jamoma_node_instance(x->p_node);
					if(n_instance != gensym("")){
						strcat(temp,".");
						strcat(temp,n_instance->s_name);
					}
					
					atom_setsym(a_answer+count, gensym(temp));
					count++;
					free(temp);
				}
				atom_setsym(a_answer+count, gensym("}"));
				count++;
			}
			
			if(linklist_getsize(lk_leaves)) {
				
				atom_setsym(a_answer+count, gensym(" leaves={"));
				count++;
				
				for(i=0; i<linklist_getsize(lk_leaves); i++){
					
					// get the name
					x->p_node = (TTNodePtr)linklist_getindex(lk_leaves,i);
					temp = (char*)malloc(sizeof(char)*256);
					strcpy(temp,jamoma_node_name(x->p_node)->s_name);
					
					// get instance
					n_instance = jamoma_node_instance(x->p_node);
					if(n_instance != gensym("")){
						strcat(temp,".");
						strcat(temp,n_instance->s_name);
					}
					
					atom_setsym(a_answer+count, gensym(temp));
					count++;
					free(temp);
				}
				atom_setsym(a_answer+count, gensym("}"));
				count++;
			}
			// TODO : return !namespace address
		}
		outlet_anything(x->p_out, gensym(":namespace"), count, a_answer);
	}
}

void minuit_get(t_node *x, t_symbol *oscaddress)
{
	defer(x, (method)minuit_doget, oscaddress, 0, 0);
}

void minuit_doget(t_node *x, t_symbol *oscAddress)
{
	TTSymbolPtr oscAddress_parent, oscAddress_name, oscAddress_instance, oscAddress_propertie;
	char *temp = NULL;
	char address[256];
	char attribute[64];
	t_object *obj;
	long nb_value = 0, i;
	t_atom  *attr_value = NULL;
	t_atom *a_answer;
	t_max_err m_err;
	TTErr tt_err;

	//split OSC the address
	// TODO : make a split method to only get /address:attribut
	tt_err = splitOSCAddress(TT(oscAddress->s_name),&oscAddress_parent,&oscAddress_name, &oscAddress_instance, &oscAddress_propertie);
	
	// if no error in the parsing of the OSC address
	if(tt_err == kTTErrNone){

		// Making the address part /parent/name.instance
		// TODO : make a split method to only get /address:attribut
		if(oscAddress_instance == NO_INSTANCE)
			snprintf(address, 256, "%s/%s", oscAddress_parent->getCString(), oscAddress_name->getCString());
		else
			snprintf(address, 256, "%s/%s.%s", oscAddress_parent->getCString(), oscAddress_name->getCString(), oscAddress_instance->getCString());

		// goto the address
		node_goto(x,gensym(address));
		if(!x->address)
			return;

		// check attribute
		if(oscAddress_propertie == NO_PROPERTIE)
			snprintf(attribute, 64, "value");
		else
			//snprintf(attribute, 64, "%s", oscAddress_propertie->getCString()+1); // +1 to avoid the / before
			snprintf(attribute, 64, "%s", oscAddress_propertie->getCString()); // Currently Virage doesn't send a / before attribute (maybe we could change the spec of Minuit) ?

		// get the attribute value
		obj = jamoma_node_max_object(x->p_node);
		m_err = object_attr_getvalueof(obj, gensym(attribute), &nb_value, &attr_value);

		if(!m_err){
			
			//prepare answer
			temp = (char*)malloc(sizeof(char)*256);
			if(oscAddress_propertie == NO_PROPERTIE)
				snprintf(temp, 256, "%s ", address);	// Virage seems to not understand when we answer :get /address:value X (?) Virage prefers :get /address X
			else
				snprintf(temp, 256, "%s:%s ", address, attribute);	// Currently Virage doesn't understand a / before attribute (maybe we could change the spec of Minuit) ?
			
			// prepend address:attribute to attr_value
			a_answer = (t_atom *)malloc((long)sizeof(t_atom)*(nb_value+1));
			atom_setsym(a_answer,gensym(temp));
			for(i = 1; i < nb_value+1; i++)
				jcom_core_atom_copy(&a_answer[i],&attr_value[i-1]);
			
			outlet_anything(x->p_out, gensym(":get"), nb_value+1, a_answer);
		}
		else{
			// TODO : return !get address
			object_post((t_object*)x,"there are no values attached to the requested attribute");
		}
	}
	free(temp);
}

void minuit_set(t_node *x, t_symbol *msg, long argc, t_atom *argv)
{
	defer(x, (method)minuit_doset, msg, argc, argv);
}

void minuit_doset(t_node *x, t_symbol *msg, long argc, t_atom *argv)
{
	t_symbol *oscAddress;
	TTSymbolPtr oscAddress_parent, oscAddress_name, oscAddress_instance, oscAddress_propertie;
	char address[256];
	char attribute[64];
	t_object *obj;
	TTErr tt_err;

	//split OSC the address
	// TODO : make a split method to only get /address:attribut
	if(argc && argv){
		if(atom_gettype(&argv[0]) == A_SYM){
			oscAddress = atom_getsym(&argv[0]);
			tt_err = splitOSCAddress(TT(oscAddress->s_name),&oscAddress_parent,&oscAddress_name, &oscAddress_instance, &oscAddress_propertie);
	
			// if no error in the parsing of the OSC address
			if(tt_err == kTTErrNone){

				// Making the address part /parent/name.instance
				// TODO : make a split method to only get /address:attribut
				if(oscAddress_instance == NO_INSTANCE)
					snprintf(address, 256, "%s/%s", oscAddress_parent->getCString(), oscAddress_name->getCString());
				else
					snprintf(address, 256, "%s/%s.%s", oscAddress_parent->getCString(), oscAddress_name->getCString(), oscAddress_instance->getCString());

				// goto the address
				node_goto(x,gensym(address));
				if(x->p_node && x->address){
					
					// check attribute
					if(oscAddress_propertie == NO_PROPERTIE)
						snprintf(attribute, 64, "value");
					else
						//snprintf(attribute, 64, "%s", oscAddress_propertie->getCString()+1); // +1 to avoid the / before
						snprintf(attribute, 64, "%s", oscAddress_propertie->getCString());	// Currently Virage doesn't send a / before attribute (maybe we could change the spec of Minuit) ?
					
					// set the attribut value
					obj = jamoma_node_max_object(x->p_node);
					if(oscAddress_propertie == TT("value"))
						object_method_typed((t_object*)obj, jps_dispatched, argc-1, argv+1, NULL);
					else
						object_attr_setvalueof(obj, gensym(attribute), argc-1, argv+1);
				}
			}
			// TODO : return !set address
		}
		else
			object_error((t_object*)x,"the first argument have to be an OSC address");
	}
} 

void node_goto(t_node *x, t_symbol *address)
{
	JamomaError err = JAMOMA_ERR_NONE;

	// Are we dealing with an OSC message ?
	if(address->s_name[0] == S_SEPARATOR[0]){

		err = jamoma_node_get(address, &(x->lk_nodes), &(x->p_node));
		
		// if the address exists
		if(err == JAMOMA_ERR_NONE)
			x->address = address;
		else{
			x->address = NULL;
			x->p_node = NULL;
			object_post((t_object*)x,"%s doesn't exist", address->s_name);
		}
	}
}