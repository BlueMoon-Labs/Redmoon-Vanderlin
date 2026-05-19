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

/proc/get_genital_shape_key(datum/sprite_accessory/bm/accessory)
	if(!accessory)
		return null
	if(istype(accessory, /datum/sprite_accessory/bm/penis) || istype(accessory, /datum/sprite_accessory/bm/anus))
		return accessory.icon_state
	return accessory.name

/// Size options for genital customizers (display name -> value applied to the organ).
/proc/get_genital_size_options(genital_category)
	switch(genital_category)
		if("breasts")
			return list(
				"Flat" = 0,
				"A" = 1,
				"B" = 2,
				"C" = 3,
				"D" = 4,
				"E" = 5,
				"F" = 6,
				"G" = 7,
				"H" = 8,
				"I" = 9,
				"J" = 10,
				"K" = 11,
				"L" = 12,
				"M" = 13,
				"N" = 14,
				"O" = 15,
				"Huge" = 16,
				"Massive" = 17,
				"Giga" = 25,
				"Impossible" = 30,
			)
		if("penis")
			// Sprite stages used in penis_onmob icon states (penis_human_1_0_FRONT, etc.)
			return list(
				"Small" = 1,
				"Medium" = 2,
				"Large" = 3,
				"Massive" = 4,
				"Comical" = 5,
			)
		if("testicles")
			return list(
				"Average" = BALLS_SIZE_MIN,
				"Heavy" = BALLS_SIZE_DEF,
				"Large" = BALLS_SIZE_2,
				"Massive" = BALLS_SIZE_3,
				"Gigantic" = BALLS_SIZE_MAX,
			)
		if("butt")
			return list(
				"Flat" = 0,
				"Medium" = 1,
				"Clenching" = 2,
				"Large" = 3,
				"Big" = 4,
				"Massive" = 5,
				"Giant" = 6,
				"Extreme" = 7,
				"Ultra" = 8,
			)
		if("belly")
			return list(
				"Flat" = 0,
				"Medium" = 1,
				"Clenching" = 2,
				"Large" = 3,
				"Big" = 4,
				"Massive" = 5,
				"Giant" = 6,
				"Huge" = 7,
				"Extreme" = 8,
				"Ultra" = 9,
				"Impossible" = 10,
			)
	return null

/proc/init_bm_genital_shapes_lists()
	if(LAZYLEN(GLOB.cock_shapes_list))
		return

	for(var/datum/sprite_accessory/bm/penis/path as anything in subtypesof(/datum/sprite_accessory/bm/penis))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/penis/penis_shape = new path()
		GLOB.cock_shapes_list[penis_shape.icon_state] = penis_shape
		GLOB.cock_shapes_list[lowertext(penis_shape.name)] = penis_shape

	for(var/datum/sprite_accessory/bm/testicles/path as anything in subtypesof(/datum/sprite_accessory/bm/testicles))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/testicles/balls_shape = new path()
		GLOB.balls_shapes_list[balls_shape.name] = balls_shape
		GLOB.balls_shapes_list[lowertext(balls_shape.icon_state)] = balls_shape

	for(var/datum/sprite_accessory/bm/breasts/path as anything in subtypesof(/datum/sprite_accessory/bm/breasts))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/breasts/breasts_shape = new path()
		GLOB.breasts_shapes_list[breasts_shape.name] = breasts_shape
		GLOB.breasts_shapes_list[lowertext(breasts_shape.icon_state)] = breasts_shape

	for(var/datum/sprite_accessory/bm/butt/path as anything in subtypesof(/datum/sprite_accessory/bm/butt))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/butt/butt_shape = new path()
		GLOB.butt_shapes_list[butt_shape.name] = butt_shape
		GLOB.butt_shapes_list[lowertext(butt_shape.icon_state)] = butt_shape

	for(var/datum/sprite_accessory/bm/belly/path as anything in subtypesof(/datum/sprite_accessory/bm/belly))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/belly/belly_shape = new path()
		GLOB.belly_shapes_list[belly_shape.name] = belly_shape
		GLOB.belly_shapes_list[lowertext(belly_shape.icon_state)] = belly_shape

	for(var/datum/sprite_accessory/bm/vagina/path as anything in subtypesof(/datum/sprite_accessory/bm/vagina))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/vagina/vagina_shape = new path()
		GLOB.vagina_shapes_list[vagina_shape.name] = vagina_shape
		GLOB.vagina_shapes_list[lowertext(vagina_shape.icon_state)] = vagina_shape

	for(var/datum/sprite_accessory/bm/anus/path as anything in subtypesof(/datum/sprite_accessory/bm/anus))
		if(IS_ABSTRACT(path))
			continue
		var/datum/sprite_accessory/bm/anus/anus_shape = new path()
		GLOB.anus_shapes_list[anus_shape.icon_state] = anus_shape
		GLOB.anus_shapes_list[anus_shape.name] = anus_shape

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
