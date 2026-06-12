/**
	# Interactions code by HONKERTRON feat TestUnit
- Contains a lot ammount of ERP and MEHANOYEBLYA
- CREDIT TO ATMTA STATION FOR MOST OF THIS CODE, I ONLY MADE IT WORK IN /vg/ - Matt
- Rewritten 30/08/16 by Zuhayr, sry if I removed anything important.
- I removed ERP and replaced it with handholding. Nothing of worth was lost. - Vic
- Fuck you, Vic. ERP is back. - TT
- >using var/ on everything, also TRUE
- "TGUIzes" the panel because yes - SandPoot
- Makes all the code good because yes as well - SandPoot
**/

/mob/proc/list_interaction_attributes()
	return list()

/mob/living/list_interaction_attributes()
	. = ..()
	if(has_hands())
		. += "...обладает руками."
	if(has_mouth())
		. += "...обладает [mouth_is_free() ? "неприкрытым" : "прикрытым"] ртом."
	// BLUEMOON ADD хвостики!
	if(has_tail())
		. += "...обладает хвостом."
	// BLUEMOON ADD END

/// The base of all interactions
/datum/interaction
	var/description
	var/simple_message
	var/simple_style = "notice"
	var/write_log_user
	var/write_log_target

	var/interaction_sound
	var/interaction_sound_volume = 50

	var/max_distance = 1

	var/interaction_flags = INTERACTION_FLAG_ADJACENT

	var/required_from_user = NONE
	var/required_from_user_exposed = NONE
	var/required_from_user_unexposed = NONE

	var/required_from_target = NONE
	var/required_from_target_exposed = NONE
	var/required_from_target_unexposed = NONE

	var/big_user_target_text = FALSE // BLUEMOON ADD большой текстик для TARGET И USER если TRUE
	var/massage_by_user = TRUE /// BLUEMOON ADD Сообщение и звук происходит от user-а? Если нет, то от цели
	/// Additional details to be shown in the interaction menu, accepts more than one entry
	var/list/additional_details

/datum/interaction/proc/requirement_label(requirement_flag)
	switch(requirement_flag)
		if(INTERACTION_REQUIRE_ANUS)
			return "анус"
		if(INTERACTION_REQUIRE_BALLS)
			return "семенники"
		if(INTERACTION_REQUIRE_BREASTS)
			return "грудь"
		if(INTERACTION_REQUIRE_EARS)
			return "уши"
		if(INTERACTION_REQUIRE_EARSOCKETS)
			return "ушные раковины"
		if(INTERACTION_REQUIRE_EYES)
			return "глаза"
		if(INTERACTION_REQUIRE_EYESOCKETS)
			return "глазницы"
		if(INTERACTION_REQUIRE_FEET)
			return "ступни"
		if(INTERACTION_REQUIRE_PENIS)
			return "пенис"
		if(INTERACTION_REQUIRE_VAGINA)
			return "вагина"
		if(INTERACTION_REQUIRE_BELLY)
			return "живот"
	return "часть тела"

/datum/interaction/proc/get_requirement_state(mob/living/subject, requirement_flag)
	if(!subject)
		return FALSE
	switch(requirement_flag)
		if(INTERACTION_REQUIRE_ANUS)
			return subject.has_anus()
		if(INTERACTION_REQUIRE_BALLS)
			return subject.has_balls()
		if(INTERACTION_REQUIRE_BREASTS)
			return subject.has_breasts()
		if(INTERACTION_REQUIRE_EARS)
			return subject.has_ears()
		if(INTERACTION_REQUIRE_EARSOCKETS)
			// Отдельной проверки раковин нет, используем уши.
			return subject.has_ears()
		if(INTERACTION_REQUIRE_EYES)
			return subject.has_eyes()
		if(INTERACTION_REQUIRE_EYESOCKETS)
			// Отдельной проверки глазниц нет, используем глаза.
			return subject.has_eyes()
		if(INTERACTION_REQUIRE_FEET)
			return subject.has_feet()
		if(INTERACTION_REQUIRE_PENIS)
			return subject.has_penis()
		if(INTERACTION_REQUIRE_VAGINA)
			return subject.has_vagina()
		if(INTERACTION_REQUIRE_BELLY)
			return subject.has_belly()
	return FALSE

/datum/interaction/proc/check_exposure_requirements(mob/living/subject, exposed_flags, unexposed_flags, silent = TRUE, subject_label = "Субъект")
	var/static/list/requirement_flags = list(
		INTERACTION_REQUIRE_ANUS,
		INTERACTION_REQUIRE_BALLS,
		INTERACTION_REQUIRE_BREASTS,
		INTERACTION_REQUIRE_EARS,
		INTERACTION_REQUIRE_EARSOCKETS,
		INTERACTION_REQUIRE_EYES,
		INTERACTION_REQUIRE_EYESOCKETS,
		INTERACTION_REQUIRE_FEET,
		INTERACTION_REQUIRE_PENIS,
		INTERACTION_REQUIRE_VAGINA,
		INTERACTION_REQUIRE_BELLY,
	)

	for(var/requirement_flag in requirement_flags)
		var/wants_exposed = exposed_flags & requirement_flag
		var/wants_unexposed = unexposed_flags & requirement_flag
		if(!wants_exposed && !wants_unexposed)
			continue

		var/state = get_requirement_state(subject, requirement_flag)
		if(wants_exposed && wants_unexposed)
			if(!state)
				if(!silent)
					to_chat(subject, span_warning("[subject_label] не имеет части тела: [requirement_label(requirement_flag)]."))
				return FALSE
			continue

		if(wants_exposed)
			if(state != HAS_EXPOSED_GENITAL && state != TRUE)
				if(!silent)
					to_chat(subject, span_warning("[subject_label] не имеет открытой части тела: [requirement_label(requirement_flag)]."))
				return FALSE
			continue

		if(state != HAS_UNEXPOSED_GENITAL)
			if(!silent)
				to_chat(subject, span_warning("[subject_label] не имеет скрытой части тела: [requirement_label(requirement_flag)]."))
			return FALSE

	return TRUE

/datum/interaction/proc/evaluate_extended_requirements(mob/living/user, mob/living/target, silent = TRUE)
	if(required_from_user & INTERACTION_REQUIRE_TOPLESS)
		if(!user.is_topless())
			if(!silent)
				to_chat(user, span_warning("Верхняя одежда мешает действию."))
			return FALSE
	if(required_from_user & INTERACTION_REQUIRE_BOTTOMLESS)
		if(!user.is_bottomless())
			if(!silent)
				to_chat(user, span_warning("Нижняя одежда мешает действию."))
			return FALSE
	if(required_from_user & INTERACTION_REQUIRE_TAIL)
		if(!user.has_tail())
			if(!silent)
				to_chat(user, span_warning("У вас нет хвоста."))
			return FALSE

	if(!check_exposure_requirements(user, required_from_user_exposed, required_from_user_unexposed, silent, "Вы"))
		return FALSE
	if(!check_exposure_requirements(target, required_from_target_exposed, required_from_target_unexposed, silent, "Цель"))
		return FALSE

	if(require_user_legs)
		if(!user.has_legs(require_user_legs))
			if(!silent)
				to_chat(user, span_warning("Недостаточно подходящих ног для действия."))
			return FALSE
	if(require_target_legs)
		if(!target.has_legs(require_target_legs))
			if(!silent)
				to_chat(user, span_warning("У цели недостаточно подходящих ног для действия."))
			return FALSE
	if(require_user_num_legs)
		var/user_legs_count = user.has_legs(require_user_legs ? require_user_legs : REQUIRE_ANY)
		if(user_legs_count < require_user_num_legs)
			if(!silent)
				to_chat(user, span_warning("Для действия нужно больше ног."))
			return FALSE
	if(require_target_num_legs)
		var/target_legs_count = target.has_legs(require_target_legs ? require_target_legs : REQUIRE_ANY)
		if(target_legs_count < require_target_num_legs)
			if(!silent)
				to_chat(user, span_warning("У цели недостаточно ног для действия."))
			return FALSE
	if(require_user_num_feet)
		if(user.get_num_feet() < require_user_num_feet)
			if(!silent)
				to_chat(user, span_warning("Для действия нужно больше ступней."))
			return FALSE
	if(require_target_num_feet)
		if(target.get_num_feet() < require_target_num_feet)
			if(!silent)
				to_chat(user, span_warning("У цели недостаточно ступней для действия."))
			return FALSE

	if((interaction_flags & INTERACTION_FLAG_USER_NOT_TIRED) && user.get_refraction_dif() > 0)
		if(!silent)
			to_chat(user, span_warning("Вы слишком утомлены для этого действия."))
		return FALSE
	if((interaction_flags & INTERACTION_FLAG_TARGET_NOT_TIRED) && target.get_refraction_dif() > 0)
		if(!silent)
			to_chat(user, span_warning("Цель слишком утомлена для этого действия."))
		return FALSE

	return TRUE

/// Checks if user can do an interaction, action_check is for whether you're actually doing it or not (useful for the menu and not removing the buttons)
/datum/interaction/proc/evaluate_user(mob/living/user, silent = TRUE, apply_cooldown = TRUE)
	if(SSinteractions.is_blacklisted(user))
		return FALSE

	if(required_from_user & INTERACTION_REQUIRE_MOUTH)
		if(!user.has_mouth())
			if(!silent)
				to_chat(user, "<span class='warning'>У вас нет рта.</span>")
			return FALSE

		if(!user.mouth_is_free())
			if(!silent)
				to_chat(user, "<span class='warning'>Ваш рот прикрыт.</span>")
			return FALSE

	if(required_from_user & INTERACTION_REQUIRE_HANDS)
		if(!user.has_hands())
			if(!silent)
				to_chat(user, span_warning("У вас нет рук."))
			return FALSE

	if(required_from_user & INTERACTION_REQUIRE_KNOT)
		if(!user.has_knotted_penis())
			if(!silent)
				to_chat(user, span_warning("Для этого действия нужен узловатый член."))
			return FALSE

	if(required_from_user & INTERACTION_REQUIRE_DOUBLE_PENIS)
		if(!user.has_double_penis())
			if(!silent)
				to_chat(user, span_warning("Для этого действия нужны два члена."))
			return FALSE

	if(!check_exposure_requirements(user, required_from_user_exposed, required_from_user_unexposed, silent, "Вы"))
		return FALSE

	if(COOLDOWN_FINISHED(user, last_interaction_time))
		return TRUE

	if(apply_cooldown)
		return FALSE
	else
		return TRUE

/// Same as evaluate_user, but for target
/datum/interaction/proc/evaluate_target(mob/living/user, mob/living/target, silent = TRUE)
	if(SSinteractions.is_blacklisted(target))
		return FALSE

	if(!(interaction_flags & INTERACTION_FLAG_USER_IS_TARGET))
		if(user == target)
			if(!silent)
				to_chat(user, span_warning("Ты не можешь так поступить с собой."))
			return FALSE

	if(required_from_target & INTERACTION_REQUIRE_MOUTH)
		if(!target.has_mouth())
			if(!silent)
				to_chat(user, span_warning("Цель не имеет рта."))
			return FALSE

		if(!target.mouth_is_free())
			if(!silent)
				to_chat(user, span_warning("Рот цели прикрыт."))
			return FALSE

	if(required_from_target & INTERACTION_REQUIRE_HANDS)
		if(!target.has_hands())
			if(!silent)
				to_chat(user, span_warning("Цель не имеет рук."))
			return FALSE

	if(required_from_target & INTERACTION_REQUIRE_TOPLESS)
		if(!target.is_topless())
			if(!silent)
				to_chat(user, span_warning("У цели должна быть обнажена верхняя часть тела."))
			return FALSE

	if(required_from_target & INTERACTION_REQUIRE_BOTTOMLESS)
		if(!target.is_bottomless())
			if(!silent)
				to_chat(user, span_warning("У цели должна быть обнажена нижняя часть тела."))
			return FALSE

	if(!check_exposure_requirements(target, required_from_target_exposed, required_from_target_unexposed, silent, "Цель"))
		return FALSE

	return TRUE

/// Actually doing the action, has a few checks to see if it's valid, usually overwritten to be make things actually happen and what-not
/datum/interaction/proc/do_action(mob/living/user, mob/living/target, apply_cooldown = TRUE)
	if(!(interaction_flags & INTERACTION_FLAG_USER_IS_TARGET))
		if(user == target) //tactical href fix
			to_chat(user, span_warning("Ты не можешь нацелиться на себя."))
			return FALSE
	if(get_dist(user, target) > max_distance && user != target)
		to_chat(user, span_warning("Слишком далеко."))
		return FALSE
	if(interaction_flags & INTERACTION_FLAG_ADJACENT && !(user.Adjacent(target) && target.Adjacent(user) || isbelly(user.loc) && user.loc:owner == target || isbelly(target.loc) && target.loc:owner == user)) // BLUEMOON EDIT can interact if in belly
		to_chat(user, span_warning("Ты не достаёшь."))
		return FALSE
	if(!evaluate_user(user, silent = FALSE, apply_cooldown = apply_cooldown))
		return FALSE
	if(!evaluate_target(user, target, silent = FALSE))
		return FALSE
	if(!evaluate_extended_requirements(user, target, silent = FALSE))
		return FALSE

	if(write_log_user)
		user.log_message("[write_log_user] [target]", LOG_ATTACK)
	if(write_log_target)
		target.log_message("[write_log_target] [user]", LOG_VICTIM, log_globally = FALSE)

	display_interaction(user, target)
	post_interaction(user, target, apply_cooldown)
	return TRUE

/// Display the message
/datum/interaction/proc/display_interaction(mob/living/user, mob/living/target)
	if(simple_message)
		var/use_message = replacetext(simple_message, "USER", big_user_target_text ? "<b>\the [user]</b>" : "\the [user]") // BLUEMOON ADD большой текст
		use_message = replacetext(use_message, "TARGET", big_user_target_text ? "<b>\the [target]</b>" : "\the [target]") // BLUEMOON ADD большой текст
		if(massage_by_user)
			user.visible_message("<span class='[simple_style]'>[capitalize(use_message)]</span>")
		else
			target.visible_message("<span class='[simple_style]'>[capitalize(use_message)]</span>")

/// After the interaction, the base only plays the sound and only if it has one
/datum/interaction/proc/post_interaction(mob/living/user, mob/living/target, apply_cooldown = TRUE)
	if(apply_cooldown)
		COOLDOWN_START(user, last_interaction_time, 0.5 SECONDS)
	if(interaction_sound)
		var/soundfile_to_play

		// pickweight so you can make a certain sound play
		// more times. This does NOT mean you are forced to
		// use the system. If you do not make the list
		// associative, all options will have the same chances!
		if(islist(interaction_sound))
			soundfile_to_play = pickweight(interaction_sound)
		else
			soundfile_to_play = interaction_sound
		if(interaction_flags & INTERACTION_FLAG_OOC_CONSENT)
			playsound(get_turf(massage_by_user ? user : target), soundfile_to_play, interaction_sound_volume, 1, -1)
		else
			playsound(get_turf(massage_by_user ? user : target), soundfile_to_play, interaction_sound_volume, 1, -1)
	return
