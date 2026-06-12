// Lesser Miracle / Miracle healing is applied as a HoT via /datum/status_effect/buff/healing/miracle.
// Keep patron logic in sync with code/modules/spells/spell_types/pointed/healing.dm when upstream changes.

/datum/action/cooldown/spell/healing/cast(mob/living/cast_on)
	. = ..()
	if(HAS_TRAIT(cast_on, TRAIT_PSYDONITE))
		cast_on.visible_message(span_info("[cast_on] stirs for a moment, the miracle dissipates."), span_notice("A dull warmth swells in my heart, only to fade as quickly as it arrived."))
		owner.playsound_local(owner, 'sound/magic/PSY.ogg', 100, FALSE, -1)
		playsound(cast_on, 'sound/magic/PSY.ogg', 100, FALSE, -1)
		return

	if(cast_on.has_status_effect(/datum/status_effect/buff/healing))
		to_chat(owner, span_warning("They are already under the effects of a healing aura!"))
		return

	var/datum/component/vampire_disguise/vampire_disguise = cast_on.GetComponent(/datum/component/vampire_disguise)
	switch(healing_type)
		if(REDMOON_HEALING_PROFANE)
			if(patron_restrictive && !(cast_on.patron in ALL_PROFANE_PATRONS))
				cast_on.visible_message(
					span_warning("The Inhumen Four sear the flesh of [cast_on]! a non-believer and weakling!"),
					span_notice("The Inhumen Four lash out at me with a wave of pain!"),
				)
				cast_on.emote("scream")
				return
		if(REDMOON_HEALING_DIVINE, REDMOON_HEALING_HUNT)
			if(cast_on.mob_biotypes & MOB_UNDEAD)
				var/we_are_vampire = cast_on.mind?.has_antag_datum(/datum/antagonist/vampire) || (cast_on in (cast_on.clan?.clan_members - cast_on.clan?.non_vampire_members))
				if(!(we_are_vampire && vampire_disguise?.disguised))
					if(cast_on.mind?.has_antag_datum(/datum/antagonist/vampire/lord))
						cast_on.visible_message(span_warning("[cast_on] overpowers being burned!"), span_greentext("I overpower being burned!"))
						return
					cast_on.visible_message(span_danger("[cast_on] is burned by holy light!"), span_userdanger("I'm burned by holy light!"))
					if(stun_undead)
						cast_on.Paralyze(5 SECONDS)
					cast_on.adjustFireLoss(base_healing)
					cast_on.adjust_divine_fire_stacks(1)
					cast_on.IgniteMob()
					return
		if(REDMOON_HEALING_DIVINE)
			if(HAS_TRAIT(cast_on, TRAIT_ASTRATA_CURSE))
				cast_on.visible_message(span_danger("[cast_on] recoils in pain!"), span_userdanger("Divine healing shuns me!"))
				cast_on.cursed_freak_out()
				return
			if(HAS_TRAIT(cast_on, TRAIT_DIVINE_CENTRIST) && !HAS_TRAIT(cast_on, TRAIT_DIVINE_SERVANT) && patron_restrictive)
				cast_on.visible_message(span_danger("[cast_on] recoils in shame!"), span_userdanger("The Ten reject my indecisiveness!"))
				cast_on.cursed_freak_out()
				return
			if(((cast_on.real_name in GLOB.excommunicated_players) || (cast_on.real_name in GLOB.heretical_players)) && !HAS_TRAIT(cast_on, TRAIT_FANATICAL))
				cast_on.visible_message(
					span_warning("The angry Ten sear the flesh of [cast_on]! a foolish blasphemer and heretic!"),
					span_notice("I am despised by the Ten, rejected, and they remind me just how unlovable I am with a wave of pain!"),
				)
				cast_on.emote("scream")
				return

	var/conditional_buff = FALSE
	var/situational_bonus = 1
	var/situational_blood = 0
	if(isliving(owner))
		var/mob/living/living_owner = owner
		switch(living_owner.patron?.type)
			if(/datum/patron/psydon, /datum/patron/psydon/extremist)
				cast_on.visible_message(span_info("A strange stirring feeling pours from [cast_on]!"), span_notice("Sentimental thoughts drive away my pains!"))

			if(/datum/patron/divine/astrata)
				cast_on.visible_message(span_info("A wreath of gentle light passes over [cast_on]!"), span_notice("I'm bathed in holy light!"))
				if(GLOB.tod == DAY)
					conditional_buff = TRUE

			if(/datum/patron/divine/noc)
				cast_on.visible_message(span_info("A shroud of soft moonlight falls upon [cast_on]!"), span_notice("I'm shrouded in gentle moonlight!"))
				if(GLOB.tod == NIGHT)
					conditional_buff = TRUE

			if(/datum/patron/divine/dendor)
				cast_on.visible_message(span_info("A rush of primal energy spirals about [cast_on]!"), span_notice("I'm infused with primal energies!"))
				var/static/list/natural_stuff = typecacheof(list(/obj/structure/flora/grass, /obj/structure/chair/bench/ancientlog, /obj/structure/flora))
				situational_bonus = 0
				for(var/obj/O in oview(5, owner))
					if(is_type_in_typecache(O, natural_stuff))
						situational_bonus = min(situational_bonus + 0.5, 25)
				if(situational_bonus > 0)
					conditional_buff = TRUE

			if(/datum/patron/divine/abyssor)
				cast_on.visible_message(span_info("A mist of salt-scented vapour settles on [cast_on]!"), span_notice("I'm invigorated by healing vapours!"))
				if(istype(get_turf(cast_on), /turf/open/water) || istype(get_turf(owner), /turf/open/water))
					conditional_buff = TRUE
					situational_bonus = 15
				situational_blood += BLOOD_VOLUME_SURVIVE/2

			if(/datum/patron/divine/ravox)
				cast_on.visible_message(span_info("An air of righteous defiance rises near [cast_on]!"), span_notice("I'm filled with an urge to fight on!"))
				situational_bonus = 0
				for(var/obj/effect/decal/cleanable/blood/O in oview(5, cast_on))
					situational_bonus = min(situational_bonus + 1, 25)
				conditional_buff = TRUE

			if(/datum/patron/divine/necra)
				cast_on.visible_message(span_info("A sense of quiet respite radiates from [cast_on]!"), span_notice("I feel the Undermaiden's gaze turn from me for now!"))
				if(iscarbon(cast_on))
					var/mob/living/carbon/C = cast_on
					if(C.health <= (C.maxHealth * 0.25))
						conditional_buff = TRUE
						situational_bonus = 25

			if(/datum/patron/divine/xylix)
				var/datum/patron/divine/xylix/xylix_patron = living_owner.patron
				xylix_patron.apply_lesser_heal_prayer(living_owner, cast_on)

			if(/datum/patron/divine/pestra)
				cast_on.visible_message(span_info("An aura of clinical care encompasses [cast_on]!"), span_notice("I'm sewn back together by sacred medicine!"))
				cast_on.adjustToxLoss(-situational_bonus)
				situational_blood += BLOOD_VOLUME_SURVIVE/2

			if(/datum/patron/divine/malum)
				cast_on.visible_message(span_info("A tempering heat is discharged out of [cast_on]!"), span_notice("I feel the heat of a forge soothing my pains!"))
				situational_bonus = 0
				for(var/obj/machinery/light/fueled/O in oview(5, owner))
					if(!O.on)
						continue
					situational_bonus = min(situational_bonus + 3, 25)
				if(situational_bonus > 0)
					conditional_buff = TRUE

			if(/datum/patron/divine/eora)
				cast_on.visible_message(span_info("An eminence of love blossoms around [cast_on]!"), span_notice("I'm filled with the restorative warmth of love!"))
				situational_bonus = 0
				if(HAS_TRAIT(cast_on, TRAIT_PACIFISM))
					conditional_buff = TRUE
					situational_bonus = 25

			if(/datum/patron/inhumen/zizo)
				cast_on.visible_message(span_info("Vital energies are sapped towards [cast_on]!"), span_notice("The life around me pales as I am restored!"))
				situational_bonus = 0
				for(var/obj/item/alch/bone/O in oview(5, owner))
					situational_bonus = min(situational_bonus + 5, 50)
				if(situational_bonus > 0)
					conditional_buff = TRUE

			if(/datum/patron/inhumen/graggar)
				cast_on.visible_message(span_info("Foul fumes billow outward as [cast_on] is restored!"), span_notice("A noxious scent burns my nostrils, but I feel better!"))
				var/toxloss = cast_on.getToxLoss()
				if(toxloss >= 10)
					conditional_buff = TRUE
					situational_bonus = 25
					cast_on.adjustToxLoss(situational_bonus)

			if(/datum/patron/inhumen/matthios)
				cast_on.visible_message(span_info("A shadowed hand passes [cast_on] a small, stolen vial... its contents glimmer faintly before sinking into their veins..."), span_notice("A quick swig and the ache fades..."))
				if(HAS_TRAIT(cast_on, TRAIT_BANDITCAMP) || (cast_on.real_name in GLOB.outlawed_players))
					conditional_buff = TRUE
					situational_bonus = 25

			if(/datum/patron/inhumen/baotha)
				cast_on.visible_message(span_info("A sweet, dizzying haze swirls around [cast_on], their eyes glimmering with bliss..."), span_notice("Mmm... the world softens... and I melt into it..."))
				var/static/list/drugs_buffs = list(
					/datum/status_effect/buff/druqks,
					/datum/status_effect/buff/ozium,
					/datum/status_effect/buff/moondust,
					/datum/status_effect/buff/weed,
					/datum/status_effect/buff/moondust_purest,
				)
				for(var/datum/status_effect/path as anything in drugs_buffs)
					if(living_owner.has_status_effect(path) || cast_on.has_status_effect(path))
						conditional_buff = TRUE
						situational_bonus = 25
						break

			if(/datum/patron/alternate/great_hunt/proven)
				cast_on.visible_message(span_info("The smell of wet grass and earth surrounds [cast_on]!"), span_notice("I'm surrounded by the smell of wet grass and earth!"))
				situational_bonus = check_hunt_bonuses(owner, 5, 50, 0.5)
				situational_bonus = min(situational_bonus, 25)
				if(situational_bonus > 0)
					conditional_buff = TRUE
				var/obj/item/natural/head/animal_head = owner.get_active_held_item()
				if(istype(animal_head))
					if(!animal_head.blood_value)
						to_chat(owner, span_warning("This head is not valuable enough to aid in healing!"))
					else
						situational_blood = animal_head.blood_value
						consume_hunt_bonus(animal_head)

			else
				if(istype(living_owner.patron, /datum/patron/godless))
					cast_on.visible_message(span_info("No Gods answer these prayers."), span_notice("No Gods answer these prayers."))
					return
				cast_on.visible_message(span_info("A choral sound comes from above and [cast_on] is healed!"), span_notice("I am bathed in healing choral hymns!"))

	var/amount_healed = base_healing
	if(conditional_buff)
		to_chat(owner, span_greentext("Channeling my patron's power is easier in these conditions!"))
		amount_healed += situational_bonus * REDMOON_MIRACLE_HEAL_TICKS

	if(vampire_disguise?.disguised)
		var/vitae_loss = amount_healed * (cast_on.mind?.has_antag_datum(/datum/antagonist/vampire/lord) ? 0.3 : 0.6)
		cast_on.adjust_bloodpool(-vitae_loss)
		if(cast_on.bloodpool)
			to_chat(cast_on, span_danger("My disguise holds at the cost of [round(vitae_loss)] vitae!"))
		else
			vampire_disguise.force_undisguise(cast_on)
		return

	if(iscarbon(cast_on))
		var/mob/living/carbon/carbon_target = cast_on
		if(miracle_blocked_by_embeds(carbon_target))
			cast_on.visible_message(
				span_danger("The wounds tear and rip around the embedded objects!"),
				span_userdanger("Agonising pain shoots through my body as magycks try to sew around the embedded objects!"),
			)
			carbon_target.adjustBruteLoss(20)
			playsound(carbon_target, 'sound/combat/dismemberment/dismem (2).ogg', 100)
			carbon_target.emote("agony")
			return

	var/heal_per_tick = get_miracle_heal_per_tick(conditional_buff, situational_bonus)
	apply_miracle_healing_buff(cast_on, heal_per_tick, situational_blood)
