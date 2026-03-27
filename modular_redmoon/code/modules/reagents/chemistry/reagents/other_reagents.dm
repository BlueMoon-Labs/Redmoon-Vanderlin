/obj/effect/decal/cleanable/semendrip
	name = "semen"
	desc = null
	gender = PLURAL
	density = 0
	layer = ABOVE_NORMAL_TURF_LAYER
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/effects.dmi'
	icon_state = "drip1"
	random_icon_states = list("drip1", "drip2", "drip3", "drip4", "drip5")

/obj/effect/decal/cleanable/semendrip/replace_decal(obj/effect/decal/cleanable/semendrip/C)
	. = ..()
	if(!. || QDELETED(src))
		return FALSE
	var/obj/effect/decal/cleanable/semen/S = (locate(/obj/effect/decal/cleanable/semen) in C.loc)
	if(S) // Merge ourselves into this puddle.
		if (reagents) // BLUEMOON EDIT: Invalid Space Turfs
			reagents.trans_to(S, reagents.total_volume) // BLUEMOON EDIT: Invalid Space Turfs
		update_icon()
		return TRUE
	if (reagents)
		reagents.trans_to(C, reagents.total_volume)
	if(C.reagents && C.reagents.total_volume >= 10) // Turn the drip into a puddle. // BLUEMOON EDIT: Invalid Space Turfs
		S = new(C.loc)
		if (C.reagents)
			C.reagents.trans_to(S, C.reagents.total_volume)  // BLUEMOON EDIT: Invalid Space Turfs
		S.update_icon()
		qdel(C)
	update_icon()

/obj/effect/decal/cleanable/semendrip/update_icon()
	. = ..()
	add_atom_colour(mix_color_from_reagents(reagents.reagent_list), FIXED_COLOUR_PRIORITY)



//body bluids
/datum/reagent/consumable/semen
	name = "Semen"
	description = "Sperm from some animal. Useless for anything but insemination, really."
	taste_description = "something salty"
	taste_mult = 2 //Not very overpowering flavor
	data = list("donor"=null,"viruses"=null,"donor_DNA"=null,"blood_type"=null,"resistances"=null,"trace_chem"=null,"mind"=null,"ckey"=null,"gender"=null,"real_name"=null)
	reagent_state = LIQUID
	color = "#FFFFFF" // rgb: 255, 255, 255
	can_synth = FALSE
	// you know i wouldn't
	// boiling_point = T0C + 100
	nutriment_factor = 0.5 * REAGENTS_METABOLISM
	var/decal_path = /obj/effect/decal/cleanable/semen

/datum/reagent/consumable/semen/reaction_turf(turf/location, reac_volume)
	..()
	if(!istype(location))
		return

	if(istype(src, /datum/reagent/consumable/semen/femcum)) //let it be here
		var/obj/effect/decal/cleanable/semen/femcum/F = (locate(/obj/effect/decal/cleanable/semen/femcum) in location) || new(location)
		if(F.reagents?.add_reagent(type, volume, data))
			F.update_icon()
			return

	var/obj/effect/decal/cleanable/semen/S = locate(/obj/effect/decal/cleanable/semen) in location
	if(S && !istype(S, /obj/effect/decal/cleanable/semen/femcum))
		if(S.reagents?.add_reagent(type, volume, data))
			S.update_icon()
			return

	var/obj/effect/decal/cleanable/semendrip/drip = (locate(/obj/effect/decal/cleanable/semendrip) in location) || new(location)
	if(drip.reagents?.add_reagent(type, volume, data))
		drip.update_icon()
		if(drip.reagents.total_volume >= 10)
			S = new(location)
			drip.reagents.trans_to(S, drip.reagents.total_volume)
			S.update_icon()
			qdel(drip)
		return

/obj/effect/decal/cleanable/semen
	name = "semen"
	desc = null
	gender = PLURAL
	density = 0
	layer = ABOVE_NORMAL_TURF_LAYER
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/effects.dmi'
	icon_state = "semen1"
	random_icon_states = list("semen1", "semen2", "semen3", "semen4", "semen5", "semen6", "semen7", "semen8", "semen9", "semen10", "semen11", "semen12", "semen13", "semen14")
	var/datum/reagent/my_liquid_type = /datum/reagent/consumable/semen

/obj/effect/decal/cleanable/semen/Initialize(mapload)
	. = ..()
	dir = GLOB.cardinals
	if(mapload)
		reagents.add_reagent(/datum/reagent/consumable/semen, 10)
		add_blood_DNA(list("Non-human DNA" = "A+"))
	update_icon()

/obj/effect/decal/cleanable/semen/replace_decal(obj/effect/decal/cleanable/semen/S)
	// BLUEMOON EDIT START: Invalid Space Turfs
	if(reagents && reagents.total_volume > 0)
		reagents.trans_to(S.reagents, reagents.total_volume)
	S.update_icon()
	// BLUEMOON EDIT END: Invalid Space Turfs
	return ..()

/obj/effect/decal/cleanable/semen/update_icon()
	. = ..()
	if(QDELETED(src) || !reagents)
		return
	add_atom_colour(mix_color_from_reagents(reagents.reagent_list), FIXED_COLOUR_PRIORITY)

/datum/reagent/consumable/semen/femcum
	name = "Female Ejaculate"
	description = "Vaginal lubricant found in most mammals and other animals of similar nature. Where you found this is your own business."
	taste_description = "something with a tang" // wew coders who haven't eaten out a girl.
	color = "#FFFFFF"
	decal_path = /obj/effect/decal/cleanable/semen/femcum

/obj/effect/decal/cleanable/semen/femcum
	name = "female ejaculate"
	icon_state = "fem1"
	random_icon_states = list("fem1", "fem2", "fem3", "fem4", "fem5", "fem6", "fem7", "fem8", "fem9", "fem10")
	blood_state = null
	bloodiness = null
	my_liquid_type = /datum/reagent/consumable/semen/femcum
