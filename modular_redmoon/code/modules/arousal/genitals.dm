/obj/item/organ/genital
	color = "#fcccb3"
	w_class = WEIGHT_CLASS_SMALL
	organ_flags = ORGAN_NO_DISMEMBERMENT|ORGAN_EDIBLE|HAS_EQUIPMENT //Maay edit it for other genitals later
	visible_organ = TRUE //иначе на спрайте видно не будет
	var/shape
	var/ru_name
	var/ru_name_v
	var/ru_name_capital
	var/sensitivity = 1 // wow if this were ever used that'd be cool but it's not but i'm keeping it for my unshit code
	var/genital_flags //see citadel_defines.dm
	var/masturbation_verb = "стимулировать"
	var/orgasm_verb = "cumming" //present continous
	var/arousal_verb = "You feel aroused"
	var/unarousal_verb = "You no longer feel aroused"
	var/fluid_transfer_factor = 0 //How much would a partner get in them if they climax using this?
	var/size = 2 //can vary between num or text, just used in icon_state strings
	var/datum/reagent/fluid_id = null
	var/fluid_max_volume = 50
	var/fluid_efficiency = 1
	var/fluid_rate = CUM_RATE
	var/fluid_mult = 1
	var/last_orgasmed = 0
	var/aroused_state = FALSE //Boolean used in icon_state strings
	var/obj/item/organ/genital/linked_organ
	var/linked_organ_slot //used for linking an apparatus' organ to its other half on update_link().
	var/layer_index = GENITAL_LAYER_INDEX //Order should be very important. FIRST vagina, THEN testicles, THEN penis, as this affects the order they are rendered in.

/obj/item/organ/genital/Initialize(mapload, do_update = TRUE)
	. = ..()
	if(genital_flags & GENITAL_FUID_PRODUCTION)
		ensure_reagents()
	if(do_update)
		update()

/obj/item/organ/genital/proc/ensure_reagents()
	if(genital_flags & GENITAL_FUID_PRODUCTION && !reagents)
		create_reagents(fluid_max_volume)

/obj/item/organ/genital/proc/get_linked_organ_type()
	switch(linked_organ_slot)
		if(ORGAN_SLOT_TESTICLES)
			return /obj/item/organ/genital/testicles
		if(ORGAN_SLOT_WOMB)
			return /obj/item/organ/genital/womb
		if(ORGAN_SLOT_PENIS)
			return /obj/item/organ/genital/penis

/obj/item/organ/genital/proc/ensure_fluid_links()
	if(!owner || !linked_organ_slot)
		return
	if(genital_flags & GENITAL_FUID_PRODUCTION)
		ensure_reagents()
		return
	if(owner.getorganslot(linked_organ_slot))
		update_link()
		return
	var/organ_type = get_linked_organ_type()
	if(!organ_type)
		return
	var/obj/item/organ/genital/L = new organ_type(null, FALSE)
	if(ishuman(owner))
		L.get_features(owner)
	L.Insert(owner, TRUE, FALSE)
	update_link()

/obj/item/organ/genital/Destroy()
	if(linked_organ?.linked_organ == src)
		linked_organ.linked_organ = null
	linked_organ = null
	. = ..()

/obj/item/organ/genital/on_life()
	return

/obj/item/organ/genital/proc/set_aroused_state(new_state,cause = "manual toggle")
	if(!(genital_flags & GENITAL_CAN_AROUSE))
		return FALSE
	if(!((HAS_TRAIT(owner,TRAIT_PERMABONER) && !new_state) || HAS_TRAIT(owner,TRAIT_NEVERBONER) && new_state))
		aroused_state = new_state
	if(cause)
		owner.log_message("[src]'s arousal was [new_state ? "enabled" : "disabled"] due to [cause]", LOG_EMOTE)
	return aroused_state

/obj/item/organ/genital/proc/update()
	if(QDELETED(src))
		return
	update_size()
	update_appearance()
	if(genital_flags & UPDATE_OWNER_APPEARANCE && owner && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.update_genitals()
	if(linked_organ_slot || (linked_organ && !owner))
		update_link()

//exposure and through-clothing code
/mob/living/carbon
	var/list/exposed_genitals = list() //Keeping track of them so we don't have to iterate through every genitalia and see if exposed

/obj/item/organ/genital/proc/is_exposed()
	if(!owner || genital_flags & (GENITAL_INTERNAL|GENITAL_HIDDEN))
		return FALSE
	/* skyrat edit
	if(genital_flags & GENITAL_UNDIES_HIDDEN && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(!(NO_UNDERWEAR in H.dna.species.species_traits))
			var/datum/sprite_accessory/bm/underwear/top/T = H.hidden_undershirt ? null : GLOB.undershirt_list[H.undershirt]
			var/datum/sprite_accessory/bm/underwear/bottom/B = H.hidden_underwear ? null : GLOB.underwear_list[H.underwear]
			if(zone == BODY_ZONE_CHEST ? (T?.covers_chest || B?.covers_chest) : (T?.covers_groin || B?.covers_groin))
				return FALSE
	*/
	if(genital_flags & GENITAL_THROUGH_CLOTHES)
		return TRUE

	switch(zone) //update as more genitals are added
		if(BODY_ZONE_CHEST)
			return owner.is_chest_exposed()
		if(BODY_ZONE_PRECISE_GROIN)
			return owner.is_groin_exposed()

/obj/item/organ/genital/proc/toggle_visibility(visibility, update = TRUE)
	if(visibility != GEN_ALLOW_EGG_STUFFING)
		genital_flags &= ~(GENITAL_THROUGH_CLOTHES|GENITAL_HIDDEN|GENITAL_UNDIES_HIDDEN)
	if(owner)
		owner.exposed_genitals -= src
	switch(visibility)
		if(GEN_VISIBLE_ALWAYS)
			genital_flags |= GENITAL_THROUGH_CLOTHES
			if(owner)
				owner.log_message("Exposed their [src]",LOG_EMOTE)
				owner.exposed_genitals += src
		if(GEN_VISIBLE_NO_CLOTHES)
			if(owner)
				owner.log_message("Hid their [src] under clothes only",LOG_EMOTE)
		if(GEN_VISIBLE_NO_UNDIES)
			genital_flags |= GENITAL_UNDIES_HIDDEN
			if(owner)
				owner.log_message("Hid their [src] under underwear",LOG_EMOTE)
		if(GEN_VISIBLE_NEVER)
			genital_flags |= GENITAL_HIDDEN
			if(owner)
				owner.log_message("Hid their [src] completely",LOG_EMOTE)
		if(GEN_ALLOW_EGG_STUFFING)
			TOGGLE_BITFIELD(genital_flags, GENITAL_CAN_STUFF)
			if(owner)
				owner.log_message("Allowed toys and egg stuffing in their [src]",LOG_EMOTE)

	if(update && owner && ishuman(owner)) //recast to use update genitals proc
		var/mob/living/carbon/human/H = owner
		H.update_genitals()

/obj/item/organ/genital/proc/pick_cum_overlay()
	var/result = pick(CUM_STATES_NEUTRAL)

	if(istype(src, /obj/item/organ/genital/penis) || istype(src, /obj/item/organ/genital/testicles))
		var/obj/item/organ/genital/testicles/balls
		if(istype(src, /obj/item/organ/genital/testicles))
			balls = src
		else if(istype(linked_organ, /obj/item/organ/genital/testicles))
			balls = linked_organ

		if(!balls)
			return result

		var/list/states = CUM_STATES
		for(var/i in 1 to states.len) // Делаем список с весом
			var/key = states[i]
			states -= key
			states[key] = 1

		var/const/state_large = "cum_large" // Подменяем вес у state_large в зависимости от размера (Такая оригинальная логика была)
		if(state_large in states)
			if(balls.size < BALLS_SIZE_3)
				states -= state_large
			else if(balls.size == BALLS_SIZE_3)
				states[state_large] = 4
			else
				states[state_large] = 10

		result = pickweight(states) // Выбираем state

	return result

/mob/living/carbon/verb/toggle_genitals()
	set category = "IC"
	set name = "Expose/Hide genitals"
	set desc = "Allows you to toggle which genitals should show through clothes or not."

	if(stat != CONSCIOUS)
		to_chat(usr, "<span class='warning'>You can toggle genitals visibility right now...</span>")
		return

	var/list/genital_list = list()
	for(var/obj/item/organ/genital/G in internal_organs)
		if(!(G.genital_flags & GENITAL_INTERNAL))
			genital_list += G
	if(!genital_list.len) //There is nothing to expose
		return
	//Full list of exposable genitals created
	var/obj/item/organ/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to expose/hide", "Expose/Hide genitals") as null|anything in (getorganslot(ORGAN_SLOT_ANUS) ? genital_list : genital_list + list("anus"))
	if(picked_organ && (picked_organ in internal_organs))
		var/picked_visibility = input(src, "Choose visibility setting", "Expose/Hide genitals") as null|anything in GLOB.genitals_visibility_toggles
		if(picked_visibility && picked_organ && (picked_organ in internal_organs))
			picked_organ.toggle_visibility(picked_visibility)

	if(picked_organ == "anus" && !getorganslot(ORGAN_SLOT_ANUS))
		var/picked_visibility = tgui_input_list(src, "Chose visibility setting", "Expose/Hide genitals", GLOB.genitals_visibility_toggles - list(GEN_VISIBLE_NO_CLOTHES))
		anus_toggle_visibility(picked_visibility)
	return

/mob/living/carbon/proc/anus_toggle_visibility(visibility)
	switch(visibility)
		if(GEN_VISIBLE_ALWAYS)
			anus_exposed = TRUE
			log_message("Exposed their anus", LOG_EMOTE)
		if(GEN_VISIBLE_NO_UNDIES)
			anus_exposed = FALSE
			log_message("Hid their anus under underwear", LOG_EMOTE)
		else
			anus_exposed = -1
			log_message("Hid their anus completely", LOG_EMOTE)

/mob/living/carbon/verb/toggle_arousal_state()
	set category = "IC"
	set name = "Toggle genital arousal"
	set desc = "Allows you to toggle which genitals are showing signs of arousal."
	var/list/genital_list = list()
	for(var/obj/item/organ/genital/G in internal_organs)
		if(G.genital_flags & GENITAL_CAN_AROUSE)
			genital_list += G
	if(!genital_list.len) //There's nothing that can show arousal
		return
	var/obj/item/organ/genital/picked_organ
	picked_organ = input(src, "Choose which genitalia to toggle arousal on", "Set genital arousal", null) in genital_list
	if(picked_organ)
		if(istype(picked_organ, /obj/item/organ/genital/penis))
			//SPLURT edit
			if(CHECK_BITFIELD(picked_organ.genital_flags, GENITAL_CHASTENED))
				to_chat(src, "<span class='userlove'>Your [pick(GLOB.dick_nouns)] twitches against its cage!</span>")
				return
			if(CHECK_BITFIELD(picked_organ.genital_flags, GENITAL_IMPOTENT))
				to_chat(src, "<span class='userlove'>Your [pick(GLOB.dick_nouns)] simply won't go up!</span>")
				return
			//
		var/original_state = picked_organ.aroused_state
		picked_organ.set_aroused_state(!picked_organ.aroused_state)
		if(original_state != picked_organ.aroused_state)
			to_chat(src,"<span class='userlove'>[picked_organ.aroused_state ? picked_organ.arousal_verb : picked_organ.unarousal_verb].</span>")
		else
			to_chat(src,"<span class='userlove'>You can't make that genital [picked_organ.aroused_state ? "unaroused" : "aroused"]!</span>")
		picked_organ.update_appearance()
		if(ishuman(src))
			var/mob/living/carbon/human/human = src
			human.update_genitals()
	return


/obj/item/organ/genital/proc/modify_size(modifier, min = -INFINITY, max = INFINITY)
	fluid_max_volume += modifier*2.5
	fluid_rate += modifier/10
	return

/obj/item/organ/genital/proc/update_size()
	return

/obj/item/organ/genital/proc/get_overlay_size()
	return size_to_state()

/obj/item/organ/genital/set_accessory_type(new_accessory_type, colors)
	. = ..()
	var/datum/sprite_accessory/bm/accessory = accessory_type ? SPRITE_ACCESSORY(accessory_type) : null
	if(accessory)
		shape = get_genital_shape_key(accessory)

/obj/item/organ/genital/proc/update_appearance_genitals()
	if(!owner || owner.stat == DEAD)
		aroused_state = FALSE

/obj/item/organ/genital/proc/generate_fluid(datum/reagents/R)
	var/amount = get_fluid()
	R.clear_reagents()
	R.maximum_volume = fluid_max_volume
	if(fluid_id)
		R.add_reagent(fluid_id,amount)
	else if(linked_organ?.fluid_id)
		R.add_reagent(linked_organ.fluid_id,amount)
	return TRUE

/obj/item/organ/genital/proc/update_link()
	if(owner)
		if(linked_organ)
			return FALSE
		linked_organ = owner.getorganslot(linked_organ_slot)
		if(linked_organ)
			linked_organ.linked_organ = src
			linked_organ.upon_link()
			upon_link()
			return TRUE
	if(linked_organ)
		linked_organ.linked_organ = null
		linked_organ = null
	return FALSE

//post organ duo making arrangements.
/obj/item/organ/genital/proc/upon_link()
	return

/obj/item/organ/genital/get_availability(datum/species/owner_species)
	// Genitals only exist when enabled via the character customizer (accessory imprinted from organ DNA).
	return !isnull(accessory_type)

/obj/item/organ/genital/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(.)
		ensure_fluid_links()
		update()
		RegisterSignal(owner, COMSIG_MOB_DEATH, PROC_REF(update_appearance_genitals))
		if(genital_flags & GENITAL_THROUGH_CLOTHES)
			owner.exposed_genitals += src

/obj/item/organ/genital/Remove(special = FALSE)
	. = ..()
	var/mob/living/carbon/C = .
	update()
	if(!QDELETED(C))
		if(genital_flags & UPDATE_OWNER_APPEARANCE && ishuman(C))
			var/mob/living/carbon/human/H = .
			H.update_genitals()
		C.exposed_genitals -= src
		UnregisterSignal(C, COMSIG_MOB_DEATH)

//proc to give a player their genitals and stuff when they log in
/mob/living/carbon/human/proc/give_genitals(clean = FALSE)//clean will remove all pre-existing genitals. proc will then give them any genitals that are enabled in their DNA
	if(clean)
		for(var/obj/item/organ/genital/G in internal_organs)
			qdel(G)
	if (NOGENITALS in dna.species.species_traits)
		return
	if(dna.features["has_vag"])
		give_genital(/obj/item/organ/genital/vagina)
	if(dna.features["has_womb"])
		give_genital(/obj/item/organ/genital/womb)
	if(dna.features["has_balls"])
		give_genital(/obj/item/organ/genital/testicles)
	if(dna.features["has_breasts"])
		give_genital(/obj/item/organ/genital/breasts)
	if(dna.features["has_cock"])
		give_genital(/obj/item/organ/genital/penis)
	if(dna.features["has_butt"])
		give_genital(/obj/item/organ/genital/butt)
	if(dna.features["has_belly"])
		give_genital(/obj/item/organ/genital/belly)
	if(dna.features["has_anus"])
		give_genital(/obj/item/organ/genital/anus)

/mob/living/carbon/human/proc/give_genital(obj/item/organ/genital/G)
	if(!dna || (NOGENITALS in dna.species.species_traits) || getorganslot(initial(G.slot)))
		return FALSE
	G = new G(null, FALSE)
	G.get_features(src)
	G.Insert(src)
	return G

/obj/item/organ/genital/proc/get_features(mob/living/carbon/human/H)
	return

/mob/living/carbon/human/proc/update_genitals()
	if(QDELETED(src))
		return
	init_bm_genital_shapes_lists()
	var/static/list/relevant_layers = list("[GENITALS_BEHIND_LAYER]" = "BEHIND", "[GENITALS_FRONT_LAYER]" = "FRONT")
	var/static/list/layers_num
	if(!layers_num)
		for(var/L in relevant_layers)
			LAZYSET(layers_num, L, text2num(L))
	for(var/L in relevant_layers) //Less hardcode
		remove_overlay(layers_num[L])
	remove_overlay(GENITALS_EXPOSED_LAYER)
	if(!LAZYLEN(internal_organs) || ((NOGENITALS in dna.species.species_traits)) || HAS_TRAIT(src, TRAIT_HUSK))
		return

	//start scanning for genitals

	var/list/gen_index[GENITAL_LAYER_INDEX_LENGTH]
	var/list/genitals_to_add
	var/list/fully_exposed
	for(var/obj/item/organ/genital/G in internal_organs)
		//SPLURT edit
		if(CHECK_BITFIELD(G.genital_flags, GENITAL_CHASTENED)) //Checks if the genital's chastened
			continue
		//
		if(G.is_exposed()) //Checks appropriate clothing slot and if it's through_clothes
			LAZYADD(gen_index[G.layer_index], G)
	for(var/L in gen_index)
		if(L) //skip nulls
			LAZYADD(genitals_to_add, L)
	if(!genitals_to_add)
		return
	//Now we added all genitals that aren't internal and should be rendered
	//start applying overlays
	for(var/layer in relevant_layers)
		var/list/standing = list()
		var/layertext = relevant_layers[layer]
		for(var/A in genitals_to_add)
			var/obj/item/organ/genital/G = A
			var/datum/sprite_accessory/bm/S
			switch(G.type)
				if(/obj/item/organ/genital/penis)
					S = GLOB.cock_shapes_list[G.shape]
				if(/obj/item/organ/genital/testicles)
					S = GLOB.balls_shapes_list[G.shape]
				if(/obj/item/organ/genital/vagina)
					S = GLOB.vagina_shapes_list[G.shape]
				if(/obj/item/organ/genital/breasts)
					S = GLOB.breasts_shapes_list[G.shape]
				if(/obj/item/organ/genital/butt)
					S = GLOB.butt_shapes_list[G.shape]
				if(/obj/item/organ/genital/belly)
					S = GLOB.belly_shapes_list[G.shape]
				if(/obj/item/organ/genital/anus)
					S = GLOB.anus_shapes_list[G.shape]

			if(!S && G.accessory_type)
				S = SPRITE_ACCESSORY(G.accessory_type)

			if(!S || S.icon_state == "none")
				continue

			var/size = G.get_overlay_size()

			var/aroused_state = G.aroused_state && S.alt_aroused
			var/accessory_icon = S.icon
			var/do_center = FALSE
			var/dim_x = 32
			var/dim_y = 32

			var/mutable_appearance/genital_overlay = mutable_appearance(accessory_icon, layer = -layer)
			if(do_center)
				genital_overlay = center_image(genital_overlay, dim_x, dim_y)

			if(dna.species.use_skintones && dna.features["genitals_use_skintone"])
				genital_overlay.color = SKINTONE2HEX(skin_tone)
			else
				switch(S.color_src)
					if("cock_color")
						genital_overlay.color = "#[dna.features["cock_color"]]"
					if("balls_color")
						genital_overlay.color = "#[dna.features["balls_color"]]"
					if("breasts_color")
						genital_overlay.color = "#[dna.features["breasts_color"]]"
					if("vag_color")
						genital_overlay.color = "#[dna.features["vag_color"]]"
					if("butt_color")
						genital_overlay.color = "#[dna.features["butt_color"]]"
					if("belly_color")
						genital_overlay.color = "#[dna.features["belly_color"]]"
					if("anus_color")
						genital_overlay.color = "#[dna.features["anus_color"]]"

			genital_overlay.icon_state = "[G.slot]_[S.icon_state]_[size][(dna.species.use_skintones && !dna.skin_tone_override) ? "_s" : ""]_[aroused_state]_[layertext]"

			if(layers_num[layer] == GENITALS_FRONT_LAYER && G.genital_flags & GENITAL_THROUGH_CLOTHES)
				genital_overlay.layer = -GENITALS_EXPOSED_LAYER
				LAZYADD(fully_exposed, genital_overlay)
			else
				genital_overlay.layer = -layers_num[layer]
				standing += genital_overlay

		if(LAZYLEN(standing))
			overlays_standing[layers_num[layer]] = standing

	if(LAZYLEN(fully_exposed))
		overlays_standing[GENITALS_EXPOSED_LAYER] = fully_exposed
		apply_overlay(GENITALS_EXPOSED_LAYER)

	for(var/L in relevant_layers)
		apply_overlay(layers_num[L])


//Checks to see if organs are new on the mob, and changes their colours so that they don't get crazy colours.
/mob/living/carbon/human/proc/emergent_genital_call()
	if(!client.prefs.arousable)
		return FALSE

	var/organCheck = locate(/obj/item/organ/genital) in internal_organs
	var/breastCheck = getorganslot(ORGAN_SLOT_BREASTS)
	var/willyCheck = getorganslot(ORGAN_SLOT_PENIS)
	var/buttCheck = getorganslot(ORGAN_SLOT_BUTT)
	var/ballCheck = getorganslot(ORGAN_SLOT_TESTICLES)
	var/bellyCheck = getorganslot(ORGAN_SLOT_BELLY)
	var/anusCheck = getorganslot(ORGAN_SLOT_ANUS)

	if(organCheck == FALSE)
		if(ishuman(src) && dna.species.use_skintones)
			dna.features["genitals_use_skintone"] = TRUE
		if(dna.species.fixed_mut_color)
			dna.features["cock_color"] = "[dna.species.fixed_mut_color]"
			dna.features["breasts_color"] = "[dna.species.fixed_mut_color]"
			dna.features["butt_color"] = "[dna.species.fixed_mut_color]"
			dna.features["testicles_color"] = "[dna.species.fixed_mut_color]"
			dna.features["belly_color"] = "[dna.species.fixed_mut_color]"
			dna.features["anus_color"] = "[dna.species.fixed_mut_color]"
			return
		//So people who haven't set stuff up don't get rainbow surprises.
		dna.features["cock_color"] = "[dna.features["mcolor"]]"
		dna.features["breasts_color"] = "[dna.features["mcolor"]]"
		dna.features["butt_color"] = "[dna.features["mcolor"]]"
		dna.features["testicles_color"] = "[dna.features["mcolor"]]"
		dna.features["belly_color"] = "[dna.features["mcolor"]]"
		dna.features["anus_color"] = "[dna.features["mcolor"]]"
	else //If there's a new organ, make it the same colour.
		if(breastCheck == FALSE)
			dna.features["breasts_color"] = dna.features["cock_color"]
		else if (willyCheck == FALSE)
			dna.features["cock_color"] = dna.features["breasts_color"]
		else if (buttCheck == FALSE)
			dna.features["butt_color"] = dna.features["butt_color"]
		else if (ballCheck == FALSE)
			dna.features["testicles_color"] = dna.features["testicles_color"]
		else if (bellyCheck == FALSE)
			dna.features["belly_color"] = dna.features["belly_color"]
		else if (anusCheck)
			dna.features["anus_color"] = dna.features["butt_color"]
	return TRUE

/obj/item/organ/genital
	/// Controls whenever a genital is always accessible
	var/always_accessible = FALSE

/// Toggles whether such genital can always be accessed
/obj/item/organ/genital/proc/toggle_accessibility(accessibility)
	always_accessible = isnull(accessibility) ? !always_accessible : accessibility

/obj/item/organ/genital
	var/max_size = 6
	var/min_size = 1
	var/datum/reagents/climax_fluids
	var/datum/reagent/original_fluid_id
	var/datum/reagent/default_fluid_id
	var/list/writtentext = ""
	var/list/obj/item/equipment = list()

/obj/item/organ/genital/modify_size(modifier, min, max)
	. = ..()
	if(owner) //Add extra space depending on the owner's size
		fluid_max_volume += (modifier*2.5)*(get_size(owner)-1)
		fluid_rate += (modifier/10)*(get_size(owner)-1)

/obj/item/organ/genital/proc/size_to_state()
	return size

/obj/item/organ/genital/proc/get_fluid()
	return clamp(fluid_rate * ((world.time - last_orgasmed) / (10 SECONDS)) * fluid_mult, 0, fluid_max_volume)

/obj/item/organ/genital/proc/get_fluid_fraction()
	return get_fluid() / fluid_max_volume

/obj/item/organ/genital/proc/climax_modify_size(mob/living/partner, obj/item/organ/genital/source_gen)
    return

/obj/item/organ/genital/proc/get_fluid_id()
	if(fluid_id)
		return fluid_id
	else if(linked_organ?.fluid_id)
		return linked_organ.fluid_id
	return

/obj/item/organ/genital/proc/splash_cum(mob/living/carbon/human/orgasming, target_orifice, atom/partner, cumin, genital)
	SIGNAL_HANDLER

	return !(!owner || cumin || genital != src)

/obj/item/organ/genital/proc/get_fluid_name()
	var/milkies = get_fluid_id()
	var/message
	if(!milkies) //No milkies??
		return
	var/datum/reagent/R = find_reagent_object_from_type(milkies)
	message = R.name
	return message

/proc/find_reagent_object_from_type(input)
	if(!GLOB.chemical_reagents_list)
		build_chemical_reagent_list() //Still no idea how to make modular changes to global procs
	if(GLOB.chemical_reagents_list[input]) //prefer IDs!
		return GLOB.chemical_reagents_list[input]
	else
		return null

/obj/item/organ/genital/proc/get_default_fluid()
	if(default_fluid_id)
		return default_fluid_id
	else if(linked_organ?.default_fluid_id)
		return linked_organ.default_fluid_id
	return

/obj/item/organ/genital/proc/set_fluid_id(new_fluidtype)
	if(genital_flags & GENITAL_FUID_PRODUCTION)
		fluid_id = new_fluidtype
	else if(linked_organ?.genital_flags & GENITAL_FUID_PRODUCTION)
		linked_organ?.fluid_id = new_fluidtype

/mob/living/carbon/human/update_genitals()
	. = ..()

	// Send signal
	SEND_SIGNAL(src, COMSIG_MOB_UPDATE_GENITALS)
