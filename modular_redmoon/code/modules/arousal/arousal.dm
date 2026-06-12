/mob/living
	//var/mb_cd_length = 1 SECONDS						//5 second cooldown for masturbating because fuck spam. // BLUEMOON EDIT commented
	var/last_climax = 0									// BLUEMOON EDIT

/mob/living/carbon/human
	var/arousal_rate = 1

/mob/living/carbon/human/proc/adjust_arousal(strength, cause = "manual toggle", aphro = FALSE,maso = FALSE, silent = FALSE) // returns all genitals that were adjust
	var/list/obj/item/organ/genital/genit_list = list()
	if(!client?.prefs.arousable || (aphro && (client?.prefs.cit_toggles & NO_APHRO)) || (maso && !HAS_TRAIT(src, TRAIT_MASO)))
		return // no adjusting made here
	var/enabling = strength > 0
	for(var/obj/item/organ/genital/G in internal_organs)
		if(istype(G, /obj/item/organ/genital/penis))
			//SPLURT edit
			if(CHECK_BITFIELD(G.genital_flags, GENITAL_CHASTENED) && enabling)
				to_chat(src, "<span class='userlove'>Твой [pick("член","пенис")] дергается в своей клетке!</span>") // BLUEMOON EDIT
				continue
			if(CHECK_BITFIELD(G.genital_flags, GENITAL_IMPOTENT) && enabling)
				to_chat(src, "<span class='userlove'>Твой [pick("член","пенис")] просто не может возбудиться!</span>") // BLUEMOON EDIT
				continue
		//
		if(G.genital_flags & GENITAL_CAN_AROUSE && !G.aroused_state && prob(abs(strength)*G.sensitivity * arousal_rate))
			G.set_aroused_state(enabling,cause)
			G.update_appearance()
			update_body(TRUE)
			if(G.aroused_state)
				genit_list += G
	if(enabling && !silent)
		for(var/obj/item/organ/genital/g in genit_list)
			to_chat(src, span_userlove("[g.arousal_verb]!"))
	return genit_list

/obj/item/organ/genital/proc/climaxable(mob/living/carbon/human/H, silent = FALSE) //returns the fluid source (ergo reagents holder) if found.
	if(genital_flags & GENITAL_FUID_PRODUCTION)
		ensure_reagents()
		. = reagents
	else
		ensure_fluid_links()
		if(linked_organ)
			. = linked_organ.climaxable(H, TRUE)
	if(!. && !silent)
		var/organ_name = ru_name || name
		to_chat(H, "<span class='warning'>Твой [organ_name] не в состоянии производить собственную жидкость, ведь у него отсутствуют органы для этого.</span>")

/mob/living/carbon/human/proc/do_climax(datum/reagents/R, atom/target, obj/item/organ/genital/sender, spill = TRUE, cover = FALSE, obj/item/organ/genital/receiver, anonymous = FALSE)
	if(!sender)
		return
	if(!target || !R)
		return
	var/turfing = isturf(target)
	sender.generate_fluid(R)
	last_climax = world.time // BLUEMOON ADD
	log_message("Кончает [sender] благодаря [target]", LOG_EMOTE)

	if(spill && R.total_volume > 0)
		var/turf/location = get_turf(target)
		var/obj/effect/decal/cleanable/semen/S = locate(/obj/effect/decal/cleanable/semen) in location
		var/obj/effect/decal/cleanable/semen/femcum/F = locate(/obj/effect/decal/cleanable/semen/femcum) in location
		if(istype(sender, /obj/item/organ/genital/penis))
			if(S && !istype(S, /obj/effect/decal/cleanable/semen/femcum))
				if(R.trans_to(S, R.total_volume))
					S.update_icon()
					return
			else
				var/obj/effect/decal/cleanable/semendrip/drip = (locate(/obj/effect/decal/cleanable/semendrip) in location) || new(location)
				if(R.trans_to(drip, R.total_volume))
					drip.update_icon()
					if(drip.reagents.total_volume >= 10)
						S = new(location)
						drip.reagents.trans_to(S, drip.reagents.total_volume)
						S.update_icon()
						qdel(drip)
					return
		if(istype(sender, /obj/item/organ/genital/vagina))
			if(F)
				if(R.trans_to(F, R.total_volume))
					F.update_icon()
					return
			else
				F = new(location)
				if(R.trans_to(F, R.total_volume))
					F.update_icon()
					return

		if(!turfing)
			// sandstorm edit - advanced cum drip
			var/amount_to_transfer = R.total_volume * (spill ? sender.fluid_transfer_factor : 1)
			var/mob/living/carbon/human/cummed_on = target
			if(!istype(cummed_on)) // not human
				R.trans_to(target, amount_to_transfer)
			else // if human
				var/datum/reagents/copy = new()
				R.copy_to(copy, R.total_volume)
				R.trans_to(target, amount_to_transfer)
				if(istype(receiver, /obj/item/organ/genital/vagina) || istype(receiver, /obj/item/organ/genital/anus))
					if(copy.total_volume > 0)
						cummed_on.apply_status_effect(STATUS_EFFECT_DRIPPING_CUM, copy, get_blood_dna_list(), receiver)

	sender.last_orgasmed = world.time
	R.clear_reagents()

/mob/living/carbon/human/proc/mob_climax_outside(obj/item/organ/genital/G, mb_time = 30) //This is used for forced orgasms and other hands-free climaxes
	var/datum/reagents/fluid_source = G.climaxable(src, TRUE)
	if(!fluid_source)
		to_chat(src,"<span class='userdanger'>Твой [G.name] предательски сжимается, не имея возможности кончить...</span>")
		return
	if(mb_time) //as long as it's not instant, give a warning
		to_chat(src,"<span class='userlove'>Вы чувствуете, что вот-вот достигнете оргазма!</span>")
		if(!do_after(src, mb_time, target = src) || !G.climaxable(src, TRUE))
			return
	to_chat(src,"<span class='userlove'>Вы оргазмируете[isturf(loc) ? ", обливая пространство под собой" : ""]!</span>")
	do_climax(fluid_source, loc, G)

/mob/living/carbon/human/proc/mob_climax_partner(obj/item/organ/genital/G, mob/living/L, spillage = TRUE, mb_time = 30, obj/item/organ/genital/Lgen = null, forced = FALSE, anonymous = FALSE)
	var/datum/reagents/fluid_source = G.climaxable(src, TRUE)
	if(!fluid_source)
		return
	if(mb_time) //Skip warning if this is an instant climax.
		if(!do_after(src, mb_time, target = src) || !in_range(src, L) || !G.climaxable(src, TRUE))
			return
	do_climax(fluid_source, spillage ? loc : L, G, spillage, FALSE, Lgen, anonymous)

/mob/living/carbon/human/proc/mob_fill_container(obj/item/organ/genital/G, obj/item/reagent_containers/container, mb_time = 30) //For beaker-filling, beware the bartender
	var/datum/reagents/fluid_source = G.climaxable(src)
	if(!fluid_source)
		return
	if(mb_time)
		to_chat(src,"<span class='userlove'>Вы начали [G.masturbation_verb] прямо над <b>[container]</b>. [G.ru_name_capital] в готовности к этому...</span>")
		if(!do_after(src, mb_time, target = src, timed_action_flags = (IGNORE_HELD_ITEM|IGNORE_INCAPACITATED)) || !in_range(src, container) || !G.climaxable(src, TRUE))
			return
	to_chat(src,"<span class='userlove'>[G.ru_name_capital] стимулируется вашими же усилиями, вы пытаетесь наполнить <b>[container]</b>.</span>")
	message_admins("[ADMIN_LOOKUPFLW(src)] использует [G.name], чтобы наполнить <b>[container]</b> [G.get_fluid_name()].")
	log_consent("[key_name(src)] использует [G.name], чтобы наполнить <b>[container]</b> [G.get_fluid_name()].")
	do_climax(fluid_source, container, G, FALSE, cover = TRUE)

/mob/living/carbon/human/proc/pick_climax_genitals(silent = FALSE)
	var/list/genitals_list
	// BLUEMOON EDIT START

	for(var/obj/item/organ/genital/G in internal_organs)
		if((G.genital_flags & CAN_CLIMAX_WITH) && (G.is_exposed() || G.always_accessible)) //filter out what you can't masturbate with
			LAZYADD(genitals_list, G)
	if(LAZYLEN(genitals_list))
		for(var/obj/item/organ/genital/listed in genitals_list)
			genitals_list[listed] = new /mutable_appearance(listed)
		var/obj/item/organ/genital/ret_organ = genitals_list.len == 1 ? genitals_list[1] : show_radial_menu(src, src, genitals_list)
		// BLUEMOON EDIT END
		//SPLURT edit
		if(CHECK_BITFIELD(ret_organ.genital_flags, GENITAL_CHASTENED))
			visible_message("<span class='userlove'><b>\The [src]</b> fumbles with their cage with a whine!</span>",
							"<span class='userlove'>You can't climax with a cage on it!</span>",
							ignored_mobs = get_unconsenting())
			return
		//
		return ret_organ
	else if(!silent)
		to_chat(src, "<span class='warning'>Вы не можете достичь кульминации без наличия гениталий.</span>")

// BLUEMOON EDIT START
/mob/living/carbon/human/proc/pick_partner(silent = FALSE, covering = FALSE)
	var/list/partners = list()
	for(var/mob/living/L in view(1))
		if(L != src && L.ckey && L.mind && Adjacent(L))
			if(!iscarbon(L))
				LAZYADD(partners, L)
			else
				var/mob/living/carbon/C = L
				if(covering || C.exposed_genitals.len || C.is_groin_exposed() || C.is_chest_exposed() || !C.is_mouth_covered()) //Anything through_clothing or covering
					LAZYADD(partners, L)

	for(var/mob/living/L in partners)
		partners[L] = new /mutable_appearance(L)
	//NOW the list should only contain correct partners
	if(!partners.len)
		if(!silent)
			to_chat(src, "<span class='warning'>Вы не можете сделать это в одиночку.</span>")
		return //No one left.

	var/mob/living/target = partners.len == 1 ? partners[1] : show_radial_menu(src, src, partners, radius = 40, require_near = TRUE) // BLUEMOON EDIT

	if(target && in_range(src, target))
		if(covering && target.client?.prefs.cit_toggles & CUM_ONTO)
			return target
		else
		// BLUEMOON EDIT END
			to_chat(src,"<span class='notice'>Ожидание согласия...</span>")
			var/consenting = alert(target, "Вы хотите, чтобы [src] кончил [covering ? "на вас" : "совместно с вами"]?","Механика Кульминации","Да","Нет")
			if(consenting == "Да")
				return target
			else
				message_admins("[ADMIN_LOOKUPFLW(src)] tried to climax with [target], but [target] did not consent.")
				log_consent("[key_name(src)] tried to climax with [target], but [target] did not consent.")

/mob/living/carbon/human/proc/pick_climax_container(silent = FALSE)
	var/list/containers_list = list()

	for(var/obj/item/reagent_containers/C in held_items)
		if(C.is_open_container() || istype(C, /obj/item/reagent_containers/food/snacks))
			containers_list += C
	for(var/obj/item/reagent_containers/C in range(1, src))
		if((C.is_open_container() || istype(C, /obj/item/reagent_containers/food/snacks)) && CanReach(C))
			containers_list += C

	if(containers_list.len)
		//BLUEMOON EDIT START
		for(var/obj/item/reagent_containers/C in containers_list)
			containers_list[C] = new /mutable_appearance(C)
		var/obj/item/reagent_containers/SC = containers_list.len == 1 ? containers_list[1] : show_radial_menu(src, src, containers_list, require_near = TRUE)
		//BLUEMOON EDIT END
		if(SC && CanReach(SC))
			return SC
	else if(!silent)
		to_chat(src, "<span class='warning'>Вы не сможете сделать это без соответствующего контейнера.</span>")

/mob/proc/restrained(ignore_grab)
	return

/mob/proc/get_num_arms(check_disabled = TRUE)
	return 2

/mob/living/carbon/get_num_arms(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == ARM_RIGHT)
			if(!check_disabled || !affecting.bodypart_disabled)
				.++
		if(affecting.body_part == ARM_LEFT)
			if(!check_disabled || !affecting.bodypart_disabled)
				.++

/mob/living/proc/pick_receiving_organ(mob/living/carbon/L, flag = CAN_CUM_INTO, title = "Climax", desc = "in what hole?")
	if (!istype(L))
		return
	var/list/receivers_list
	//BLUEMOON EDIT START
	for(var/obj/item/organ/genital/G in L.internal_organs)
		if((!flag || (G.genital_flags & flag)) && (G.is_exposed() || G.always_accessible)) //filter out what you can't cum into
			LAZYADD(receivers_list, G)
	if(LAZYLEN(receivers_list))
		for(var/obj/item/organ/genital/G in receivers_list)
			receivers_list[G] = new /mutable_appearance(G)
		var/obj/item/organ/genital/ret_organ = show_radial_menu(src, L, receivers_list, require_near = TRUE, tooltips = TRUE)
	//BLUEMOON EDIT END
		return ret_organ


/mob/living/carbon/human/proc/available_rosie_palms(silent = FALSE)
	if(restrained(TRUE)) //TRUE ignores grabs
		if(!silent)
			to_chat(src, "<span class='warning'>Вы не можете сделать это, будучи связанным!</span>")
		return FALSE
	if(!get_num_arms() || !get_empty_held_indexes())
		if(!silent)
			to_chat(src, "<span class='warning'>Вам нужна как минимум одна свободная рука.</span>")
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/mob_climax_over(obj/item/organ/genital/G, mob/living/L, spillage = TRUE, mb_time = 30)
	var/datum/reagents/fluid_source = G.climaxable(src)
	if(!fluid_source)
		return
	if(mb_time) //Skip warning if this is an instant climax.
		to_chat(src,"<span class='userlove'>You're about to climax over [L]!</span>")
		to_chat(L,"<span class='userlove'>[src] is about to climax over you!</span>")
		if(!do_after(src, mb_time, target = src) || !in_range(src, L) || !G.climaxable(src, TRUE))
			return
	to_chat(src,"<span class='userlove'>You climax all over [L] using your [G.name]!</span>")
	to_chat(L, "<span class='userlove'>[src] climaxes all over you using [G.name]!</span>")
	do_climax(fluid_source, L, G, spillage, cover = TRUE)


//Here's the main proc itself
//skyrat edit - forced partner and spillage
/mob/living/carbon/human/proc/mob_climax(forced_climax = FALSE, cause = "", var/mob/living/forced_partner = null, var/forced_spillage = TRUE, var/obj/item/organ/genital/forced_receiving_genital = null, anonymous = FALSE)
	set waitfor = FALSE

	if(!(client?.prefs.arousable || !ckey) || !has_dna())
		return

	if(HAS_TRAIT(src, TRAIT_NEVERBONER))
		to_chat(src, span_warning("You don't feel like it at all."))
		return

	if(stat == DEAD)
		if(!forced_climax)
			to_chat(src, "<span class='warning'>Ты не можешь сделать это, будучи мертвым!</span>")
		return
	if(forced_climax) //Something forced us to cum, this is not a masturbation thing and does not progress to the other checks
		log_message("was forced to climax by [cause]",LOG_EMOTE)
		for(var/obj/item/organ/genital/G in internal_organs)
			if(!(G.genital_flags & CAN_CLIMAX_WITH)) //Skip things like wombs and testicles
				continue
			if(!G.climaxable(src, TRUE))
				continue
			var/mob/living/partner
			var/check_target

			if(forced_receiving_genital || G.is_exposed() || G.always_accessible) // BLUEMOON EDIT
				if(pulling) //Are we pulling someone? Priority target, we can't be making option menus for this, has to be quick
					if(isliving(pulling)) //Don't fuck objects
						check_target = pulling
				if(pulledby && !check_target) //prioritise pulled over pulledby
					if(isliving(pulledby))
						check_target = pulledby
				//Now we should have a partner, or else we have to come alone
				if(check_target)
					if(iscarbon(check_target)) //carbons can have clothes
						var/mob/living/carbon/C = check_target
						if(C.exposed_genitals.len || C.is_groin_exposed() || C.is_chest_exposed()) //Are they naked enough?
							partner = C
						// BLUEMMON ADD START
						else
							for(var/obj/item/organ/genital/partner_G in C.internal_organs)
								if(partner_G.always_accessible)
									partner = C
									break
						// BLUEMMON ADD END
					else //A cat is fine too
						partner = check_target
				//skyrat edit
				if(forced_partner)
					if(forced_partner == "none" || forced_partner == src || !istype(forced_partner))
						partner = null
					else
						partner = forced_partner
				//
				if(partner) //Did they pass the clothing checks?
					//skyrat edit
					mob_climax_partner(G, partner, forced_spillage, 0, forced_receiving_genital, forced_climax, anonymous) //Instant climax due to forced
					//
					continue //You've climaxed once with this organ, continue on
			//not exposed OR if no partner was found while exposed, climax alone
			mob_climax_outside(G, mb_time = 0) //removed climax timer for sudden, forced orgasms
		//Now all genitals that could climax, have.
		//Since this was a forced climax, we do not need to continue with the other stuff
		return
	//If we get here, then this is not a forced climax and we gotta check a few things.

	if(stat == UNCONSCIOUS) //No sleep-masturbation, you're unconscious.
		to_chat(src, "<span class='warning'>Вы должны быть в сознании, чтобы сделать это!</span>")
		return

	//Ok, now we check what they want to do.
	// BLUEMOON EDIT START
	var/static/list/options = list(
		"Оргазмировать в одиночестве" = list("icon" = 'modular_redmoon/icons/from_bluemoon/mob/genitals/hud.dmi', "state" = "arousal"),
		"Оргазмировать совместно с кем-то" = list("icon" = 'modular_redmoon/icons/from_bluemoon/mob/genitals/dogborg.dmi', "state" = "pleasuremaw"),
		"Оргазмировать на кого-то" = list("icon" = 'modular_redmoon/icons/from_bluemoon/effects/cumoverlay.dmi', "state" = "cum_large"),
		"Наполнить контейнер половыми жидкостями" = list("icon" = 'modular_redmoon/icons/from_bluemoon/mob/genitals/drinks.dmi', "state" = "cumchalice")
	)

	var/list/choices = list()
	for(var/text in options)
		var/info = options[text]
		var/mutable_appearance/app = new /mutable_appearance()
		app.icon = info["icon"]
		app.icon_state = info["state"]
		app.name = text
		choices[text] = app

	var/choice = show_radial_menu(src, src, choices, require_near = FALSE)

	if(!choice)
		return

	switch(choice)
		if("Оргазмировать в одиночестве")
			if(!available_rosie_palms())
				return
			var/obj/item/organ/genital/picked_organ = pick_climax_genitals()
			if(picked_organ && available_rosie_palms(TRUE))
				mob_climax_outside(picked_organ)
		if("Оргазмировать совместно с кем-то")
			//We need no hands, we can be restrained and so on, so let's pick an organ
			var/obj/item/organ/genital/picked_organ = pick_climax_genitals()
			if(picked_organ)
				var/mob/living/partner = pick_partner() //Get someone
				if(partner && in_range(src, partner))
					var/spillage = alert(src, "Кончить внутрь?", "При возможности", "Да", "Нет")
					if(in_range(src, partner))
						mob_climax_partner(picked_organ, partner, spillage == "Нет" ? TRUE : FALSE, Lgen = pick_receiving_organ(partner))
		if("Наполнить контейнер половыми жидкостями")
			//We'll need hands and no restraints.
			if(!available_rosie_palms(FALSE, /obj/item/reagent_containers))
				return
			//We got hands, let's pick an organ
			var/obj/item/organ/genital/picked_organ
			picked_organ = pick_climax_genitals() //Gotta be climaxable, not just masturbation, to fill with fluids.
			if(picked_organ)
				//Good, got an organ, time to pick a container
				var/obj/item/reagent_containers/fluid_container = pick_climax_container()
				if(fluid_container && available_rosie_palms(TRUE, /obj/item/reagent_containers))
					mob_fill_container(picked_organ, fluid_container)
		if("Оргазмировать на кого-то")
			//We need no hands, we can be restrained and so on, so let's pick an organ
			var/obj/item/organ/genital/picked_organ = pick_climax_genitals()
			if(picked_organ)
				var/mob/living/partner = pick_partner(covering = TRUE) //Get someone
				if(partner && in_range(src, partner))
					mob_climax_over(picked_organ, partner, TRUE)

	// BLUEMOON EDIT END

/mob/living/carbon/human/verb/climax_verb()
	set category = "IC"
	set name = "Climax"
	set desc = "Lets you choose a couple ways to ejaculate."
	mob_climax()
