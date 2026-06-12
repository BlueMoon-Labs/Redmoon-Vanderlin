/mob/living
	var/STALUC = 0

/mob/living/proc/play_overhead_indicator(icon_path, overlay_name, clear_time, overlay_layer, private = FALSE, soundin = null, y_offset = 12)
	if(!ishuman(src) || stat == DEAD)
		return
	var/mob/living/carbon/human/human = src
	var/mutable_appearance/appearance = mutable_appearance(icon_path, overlay_name, overlay_layer)
	appearance.pixel_y += y_offset
	appearance.appearance_flags = RESET_COLOR
	human.overlays_standing[MUTATIONS_LAYER] = appearance
	human.apply_overlay(MUTATIONS_LAYER)
	addtimer(CALLBACK(human, TYPE_PROC_REF(/mob/living, remove_overlay), MUTATIONS_LAYER), clear_time)
	if(soundin)
		playsound(human, soundin, 100, FALSE)

/datum/patron/divine/xylix/proc/apply_lesser_heal_prayer(mob/living/user, mob/living/target)
	target.visible_message(span_info("A fugue seems to manifest briefly across [target]!"), span_notice("My wounds vanish as if they had never been there! "))

	var/dice_roll = rand(1, 6)
	switch(dice_roll)
		if(1)
			if(prob(85 + user.STALUC))
				user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll2", 3 SECONDS, MUTATIONS_LAYER, soundin = 'sound/magic/mockery.ogg', y_offset = 32)
				user.psydo_nyte()
				var/turf/target_tile = get_ranged_target_turf(user, pick(GLOB.alldirs), 12)
				user.throw_at(target = target_tile, range = 12, speed = 2, thrower = user, spin = TRUE, force = 30)
				user.Knockdown(1 SECONDS)
				record_round_statistic(STATS_PEOPLE_SMITTEN)
				to_chat(user, span_danger("Xylix is ??laughing at you!"))
			else
				user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll1", 3 SECONDS, MUTATIONS_LAYER, soundin = 'sound/misc/psydong.ogg', y_offset = 32)
				user.psydo_nyte()
				var/turf/T = get_step(get_step(user, NORTH), NORTH)
				T.Beam(user, icon_state = "lightning[rand(1,12)]", time = 5)
				user.adjustFireLoss(150)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					H.electrocution_animation(40)
				record_round_statistic(STATS_PEOPLE_SMITTEN)
				to_chat(user, span_danger("Roll the dice better, chuclkenuts!"))
		if(2)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll3", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_1.ogg', y_offset = 32)
		if(3)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll3", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_1.ogg', y_offset = 32)
		if(4)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll4", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_2.ogg', y_offset = 32)
		if(5)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll5", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_3.ogg', y_offset = 32)
		if(6)
			user.play_overhead_indicator('modular_redmoon/icons/mob/overhead_effects.dmi', "roll6", 3 SECONDS, MUTATIONS_LAYER, soundin = 'modular_redmoon/sound/magic/xylix_4.ogg', y_offset = 32)
