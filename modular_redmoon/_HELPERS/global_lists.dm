/proc/make_datum_bm_references_lists()
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/hair, GLOB.hair_styles_list, GLOB.hair_styles_male_list, GLOB.hair_styles_female_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/facial_hair, GLOB.facial_hair_styles_list, GLOB.facial_hair_styles_male_list, GLOB.facial_hair_styles_female_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/tails/lizard, GLOB.tails_list_lizard)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/tails_animated/lizard, GLOB.animated_tails_list_lizard)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/tails/human, GLOB.tails_list_human)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/tails_animated/human, GLOB.animated_tails_list_human)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/snouts, GLOB.snouts_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/horns,GLOB.horns_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/ears, GLOB.ears_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/wings, GLOB.wings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/wings_open, GLOB.wings_open_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/frills, GLOB.frills_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/spines, GLOB.spines_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/spines_animated, GLOB.animated_spines_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/legs, GLOB.legs_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/wings, GLOB.r_wings_list,roundstart = TRUE)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/caps, GLOB.caps_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/insect_wings, GLOB.insect_wings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/insect_fluff, GLOB.insect_fluffs_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/arachnid_legs, GLOB.arachnid_legs_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/arachnid_spinneret, GLOB.arachnid_spinneret_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/arachnid_mandibles, GLOB.arachnid_mandibles_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/deco_wings, GLOB.deco_wings_list)

	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/mam_body_markings, GLOB.mam_body_markings_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/tails/mam_tails, GLOB.mam_tails_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/ears/mam_ears, GLOB.mam_ears_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/snouts/mam_snouts, GLOB.mam_snouts_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/tails_animated/mam_tails_animated, GLOB.mam_tails_animated_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/penis, GLOB.cock_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/vagina, GLOB.vagina_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/breasts, GLOB.breasts_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/butt, GLOB.butt_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/belly, GLOB.belly_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/testicles, GLOB.balls_shapes_list)
	init_sprite_accessory_subtypes(/datum/sprite_accessory/bm/anus, GLOB.anus_shapes_list)

	GLOB.hair_styles_list = sort_list(GLOB.hair_styles_list)
	GLOB.facial_hair_styles_list = sort_list(GLOB.facial_hair_styles_list)

	GLOB.tails_list_lizard = sort_list(GLOB.tails_list_lizard)
	GLOB.tails_list_human = sort_list(GLOB.tails_list_human)
	GLOB.snouts_list = sort_list(GLOB.snouts_list)
	GLOB.horns_list = sort_list(GLOB.horns_list)
	GLOB.ears_list = sort_list(GLOB.ears_list)

	GLOB.wings_list = sort_list(GLOB.wings_list)
	GLOB.frills_list = sort_list(GLOB.frills_list)
	GLOB.spines_list = sort_list(GLOB.spines_list)

	GLOB.caps_list = sort_list(GLOB.caps_list)

	GLOB.insect_wings_list = sort_list(GLOB.insect_wings_list)
	GLOB.insect_fluffs_list = sort_list(GLOB.insect_fluffs_list)
	GLOB.deco_wings_list = sort_list(GLOB.deco_wings_list)

	GLOB.mam_body_markings_list = sort_list(GLOB.mam_body_markings_list)
	GLOB.mam_tails_list = sort_list(GLOB.mam_tails_list)
	GLOB.mam_ears_list = sort_list(GLOB.mam_ears_list)
	GLOB.mam_snouts_list = sort_list(GLOB.mam_snouts_list)

	GLOB.taur_list = sort_list(GLOB.taur_list)
	// BLUEMOON ADD END

	for(var/gpath in subtypesof(/obj/item/organ/genital))
		var/obj/item/organ/genital/G = gpath
		if(!(initial(G.genital_flags) & GENITAL_BLACKLISTED))
			GLOB.genitals_list[initial(G.name)] = gpath

	// Hair Gradients - Initialise all /datum/sprite_accessory/bm/hair_gradient into an list indexed by gradient-style name
	for(var/path in subtypesof(/datum/sprite_accessory/bm/hair_gradient))
		var/datum/sprite_accessory/bm/hair_gradient/H = new path()
		GLOB.hair_gradients_list[H.name] = H

	// Keybindings
	init_keybindings()
	GLOB.emote_list = init_emote_list()

//any value in a list
/proc/sort_list(list/L, cmp=GLOBAL_PROC_REF(cmp_text_asc))
	return sortTim(L.Copy(), cmp)
