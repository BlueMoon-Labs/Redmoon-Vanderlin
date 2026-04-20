#define QDEL_NULL_LIST(x) if(x) { for(var/y in x) { qdel(y) } ; x = null }

//THIS FILE CONTAINS CONSTANTS, PROCS, AND OTHER THINGS//
/////////////////////////////////////////////////////////

/proc/get_matrix_largest()
	var/matrix/mtrx=new()
	return mtrx.Scale(2)
/proc/get_matrix_large()
	var/matrix/mtrx=new()
	return mtrx.Scale(1.5)
/proc/get_matrix_norm()
	var/matrix/mtrx=new()
	return mtrx
/proc/get_matrix_small()
	var/matrix/mtrx=new()
	return mtrx.Scale(0.8)
/proc/get_matrix_smallest()
	var/matrix/mtrx=new()
	return mtrx.Scale(0.65)

// /proc/get_racelist(mob/user)//This proc returns a list of species that 'user' has available to them. It searches the list of ckeys attached to the 'whitelist' var for a species and also checks if they're an admin.
// 	for(var/spath in subtypesof(/datum/species))
// 		var/datum/species/S = new spath()
// 		var/list/wlist = S.whitelist
// 		if(S.whitelisted && (wlist.Find(user.ckey) || wlist.Find(user.key) || user.client.holder))  //If your ckey is on the species whitelist or you're an admin:
// 			GLOB.whitelisted_species_list[S.id] = S.type 											//Add the species to their available species list.
// 		else if(!S.whitelisted)														//Normal roundstart species will be handled here.
// 			GLOB.whitelisted_species_list[S.id] = S.type

// 	return GLOB.whitelisted_species_list


	//Genitals and Arousal Lists
GLOBAL_LIST_EMPTY(genitals_list)
GLOBAL_LIST_EMPTY(cock_shapes_list)
GLOBAL_LIST_EMPTY(balls_shapes_list)
GLOBAL_LIST_EMPTY(butt_shapes_list)
GLOBAL_LIST_EMPTY(breasts_shapes_list)
GLOBAL_LIST_EMPTY(vagina_shapes_list)
GLOBAL_LIST_EMPTY(belly_shapes_list)
GLOBAL_LIST_EMPTY(anus_shapes_list)

//longcat memes.
GLOBAL_LIST_INIT(dick_nouns, list("фаллос", "член", "хрен", "пенис", "агрегат", "половой орган", "хер", "детородный орган", "болт", "джойстик", "елдык", "конец", "стояк", "любовный свисток", "стейк из трубки", "кукан", "мужской член", "причиндал"))

GLOBAL_LIST_INIT(genitals_visibility_toggles, list(GEN_VISIBLE_ALWAYS, GEN_VISIBLE_NO_CLOTHES, GEN_VISIBLE_NO_UNDIES, GEN_VISIBLE_NEVER))

GLOBAL_LIST_INIT(dildo_shapes, list(
		"Human"		= "human",
		"Knotted"	= "knotted",
		"Plain"		= "plain",
		"Flared"	= "flared"
		))
GLOBAL_LIST_INIT(dildo_shape_to_cock_shape, list(
		"human"		= "Human",
		"knotted"	= "Knotted",
		"plain"		= "Tentacled",
		"flared"	= "Flared"
		))

GLOBAL_LIST_INIT(dildo_sizes, list(
		"Small"		= 1,
		"Medium"	= 2,
		"Big"		= 3
		))
GLOBAL_LIST_INIT(dildo_size_names, list("small", "medium", "big", "huge", "gigantic"))
GLOBAL_LIST_INIT(dildo_colors, list(//mostly neon colors
		"Cyan"		= "#00f9ff",//cyan
		"Green"		= "#49ff00",//green
		"Pink"		= "#ff4adc",//pink
		"Yellow"	= "#fdff00",//yellow
		"Blue"		= "#00d2ff",//blue
		"Lime"		= "#89ff00",//lime
		"Black"		= "#101010",//black
		"Red"		= "#ff0000",//red
		"Orange"	= "#ff9a00",//orange
		"Purple"	= "#e300ff"//purple
		))

// GLOBAL_LIST_INIT(meat_types, list(
// 	"Mammalian" = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/mammal,
// 	"Aquatic" = /obj/item/reagent_containers/food/snacks/carpmeat/aquatic,
// 	"Avian" = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/avian,
// 	"Insect" = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/insect))

//Crew objective and miscreants stuff
GLOBAL_VAR_INIT(miscreants_allowed, FALSE)

/mob/living/carbon/proc/is_groin_exposed(list/L)
	if(!L)
		L = get_equipped_items()
	for(var/A in L)
		var/obj/item/I = A
		if(istype(I) && (I.body_parts_covered & GROIN))
			return FALSE
	return TRUE

/mob/living/carbon/proc/is_chest_exposed(list/L)
	if(!L)
		L = get_equipped_items()
	for(var/A in L)
		var/obj/item/I = A
		if(I.body_parts_covered & CHEST)
			return FALSE
	return TRUE

/proc/percentage_between(x,a,b,centesimal = TRUE)
	if (a > b)
		return percentage_between(x, b, a, centesimal)
	return clamp((x-a)/(b-a),0,1) * (centesimal ? 100 : 1)

/mob/proc/has_tail()
	return FALSE

/mob/living/carbon/human/has_tail()
	if(!dna || !dna.species)
		return ..()
	var/list/F = dna.features
	for(var/tail in list("mam_tail", "tail_human", "tail_lizard", "taur", "xenotail"))
		if(F[tail] && (F[tail] != "None"))
			return TRUE
	return	FALSE
