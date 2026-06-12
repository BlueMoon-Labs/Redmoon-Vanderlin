/datum/preferences
	var/bark_id = "mutedc3"
	var/bark_speed = 4
	var/bark_pitch = 1
	var/bark_variance = 0.2
	var/hear_barks = TRUE
	COOLDOWN_DECLARE(bark_previewing)

/datum/preferences/proc/sanitize_bark_preferences()
	if(!length(GLOB.bark_list))
		return
	if(!(bark_id in GLOB.bark_list))
		bark_id = length(GLOB.bark_random_list) ? pick(GLOB.bark_random_list) : bark_id
	var/datum/bark/B = GLOB.bark_list[bark_id]
	if(!B)
		return
	bark_speed = round(clamp(bark_speed, initial(B.minspeed), initial(B.maxspeed)), 1)
	bark_pitch = clamp(bark_pitch, initial(B.minpitch), initial(B.maxpitch))
	bark_variance = clamp(bark_variance, initial(B.minvariance), initial(B.maxvariance))

/datum/preferences/proc/_load_barks(savefile/S)
	S["bark_id"] >> bark_id
	S["bark_speed"] >> bark_speed
	S["bark_pitch"] >> bark_pitch
	S["bark_variance"] >> bark_variance
	S["hear_barks"] >> hear_barks
	sanitize_bark_preferences()

/datum/preferences/proc/_save_barks(savefile/S)
	WRITE_FILE(S["bark_id"], bark_id)
	WRITE_FILE(S["bark_speed"], bark_speed)
	WRITE_FILE(S["bark_pitch"], bark_pitch)
	WRITE_FILE(S["bark_variance"], bark_variance)
	WRITE_FILE(S["hear_barks"], hear_barks)

/datum/preferences/proc/apply_bark_prefs_to(mob/living/carbon/human/character)
	if(QDELETED(character) || !ishuman(character))
		return
	character.set_bark(bark_id)
	character.vocal_speed = bark_speed
	character.vocal_pitch = bark_pitch
	character.vocal_pitch_range = bark_variance

/datum/preferences/proc/get_bark_display_name()
	var/datum/bark/B = GLOB.bark_list[bark_id]
	return B ? initial(B.name) : "INVALID"

/datum/preferences/proc/get_bark_choice_list(mob/user)
	var/list/choices = list()
	for(var/id in GLOB.bark_list)
		var/datum/bark/B = GLOB.bark_list[id]
		if(initial(B.ignore))
			continue
		if(initial(B.ckeys_allowed))
			var/list/allowed = initial(B.ckeys_allowed)
			if(!allowed.Find(user.client.ckey))
				continue
		choices[initial(B.name)] = id
	return choices

/datum/preferences/proc/print_bark_prefs_page()
	var/list/dat = list()
	dat += "<meta charset='utf-8'><style>\
		body { background-color: #2a2218; color: #c4b08a; font-family: Verdana, Geneva, sans-serif; margin: 8px; }\
		table.bark-prefs { width: 100%; border-collapse: collapse; }\
		table.bark-prefs td { padding: 4px 6px; border-bottom: 1px solid #5c4a32; vertical-align: top; }\
		h3 { margin: 0 0 8px 0; text-align: center; color: #e8dcc4; font-size: 13px; letter-spacing: 0.5px; }\
		.bark-note { font-size: 11px; color: #9a8870; margin-top: 10px; line-height: 1.35; }\
		a { color: #d4c4a0; }\
		</style>"
	dat += "<h3>Vocal Barks</h3>"
	dat += "<table class='bark-prefs'>"
	dat += "<tr><td><b>Bark sound</b></td><td><a href='?_src_=prefs;task=change_bark_pref;bark_task=sound'>[get_bark_display_name()]</a></td></tr>"
	dat += "<tr><td><b>Speed</b></td><td><a href='?_src_=prefs;task=change_bark_pref;bark_task=speed'>[bark_speed]</a></td></tr>"
	dat += "<tr><td><b>Pitch</b></td><td><a href='?_src_=prefs;task=change_bark_pref;bark_task=pitch'>[bark_pitch]</a></td></tr>"
	dat += "<tr><td><b>Variance</b></td><td><a href='?_src_=prefs;task=change_bark_pref;bark_task=variance'>[bark_variance]</a></td></tr>"
	var/hear_state = hear_barks ? "On" : "Off"
	var/hear_color = hear_barks ? "#6ecf6e" : "#cc6666"
	dat += "<tr><td><b>Hear barks</b></td><td><a href='?_src_=prefs;task=change_bark_pref;bark_task=hear' style='color:[hear_color];'>[hear_state]</a></td></tr>"
	dat += "<tr><td colspan=2><center><a href='?_src_=prefs;task=change_bark_pref;bark_task=preview'><b>Preview bark</b></a></center></td></tr>"
	dat += "</table>"
	dat += "<div class='bark-note'>Barks replace the default speech blip when a sound is selected.<br>\
	Lower speed = faster barks. Click SAVE in the character menu after changing settings.</div>"
	return dat

/datum/preferences/proc/show_bark_prefs_ui(mob/user)
	var/list/dat = print_bark_prefs_page()
	var/datum/browser/popup = new(user, "bark_prefs", "<div align='center'>Vocal Barks</div>", 420, 420)
	popup.set_content(dat.Join())
	popup.open(use_onclose = FALSE)

/datum/preferences/proc/handle_bark_prefs_topic(mob/user, href_list)
	switch(href_list["bark_task"])
		if("sound")
			var/list/choices = get_bark_choice_list(user)
			if(!length(choices))
				to_chat(user, span_warning("No bark sounds are available."))
				return
			var/choice = input(user, "Choose your desired vocal bark", "Character Preference") as null|anything in choices
			if(choice)
				bark_id = choices[choice]
				sanitize_bark_preferences()
		if("speed")
			var/datum/bark/B = GLOB.bark_list[bark_id]
			if(!B)
				return
			var/new_speed = input(user, "Bark speed (higher = slower). Min: [initial(B.minspeed)]. Max: [initial(B.maxspeed)]", "Character Preference", bark_speed) as null|num
			if(!isnull(new_speed))
				bark_speed = round(clamp(new_speed, initial(B.minspeed), initial(B.maxspeed)), 1)
		if("pitch")
			var/datum/bark/B = GLOB.bark_list[bark_id]
			if(!B)
				return
			var/new_pitch = input(user, "Baseline bark pitch. Min: [initial(B.minpitch)]. Max: [initial(B.maxpitch)]", "Character Preference", bark_pitch) as null|num
			if(!isnull(new_pitch))
				bark_pitch = clamp(new_pitch, initial(B.minpitch), initial(B.maxpitch))
		if("variance")
			var/datum/bark/B = GLOB.bark_list[bark_id]
			if(!B)
				return
			var/new_variance = input(user, "Bark pitch variance. Min: [initial(B.minvariance)]. Max: [initial(B.maxvariance)]", "Character Preference", bark_variance) as null|num
			if(!isnull(new_variance))
				bark_variance = clamp(new_variance, initial(B.minvariance), initial(B.maxvariance))
		if("hear")
			hear_barks = !hear_barks
		if("preview")
			if(!COOLDOWN_FINISHED(src, bark_previewing))
				to_chat(user, span_warning("Please wait before previewing again."))
				return
			if(!parent?.mob)
				return
			COOLDOWN_START(src, bark_previewing, 5 SECONDS)
			var/atom/movable/barkbox = new(get_turf(parent.mob))
			barkbox.set_bark(bark_id)
			barkbox.vocal_speed = bark_speed
			barkbox.vocal_pitch = bark_pitch
			barkbox.vocal_pitch_range = bark_variance
			var/total_delay = 0
			for(var/i in 1 to (round((32 / bark_speed)) + 1))
				addtimer(CALLBACK(barkbox, TYPE_PROC_REF(/atom/movable, bark), list(parent.mob), 7, 70, BARK_DO_VARY(bark_pitch, bark_variance)), total_delay)
				total_delay += rand(DS2TICKS(bark_speed / BARK_SPEED_BASELINE), DS2TICKS(bark_speed / BARK_SPEED_BASELINE) + DS2TICKS(bark_speed / BARK_SPEED_BASELINE)) TICKS
			QDEL_IN(barkbox, total_delay + 1)
	update_menu_data(user, list("bark"))

/datum/preferences/load_character(slot)
	. = ..()
	if(!.)
		return
	if(!path || !fexists(path))
		return
	var/savefile/S = new /savefile(path)
	if(!S)
		return
	S.cd = "/character[slot || default_slot]"
	_load_barks(S)

/datum/preferences/save_character()
	. = ..()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/character[default_slot]"
	_save_barks(S)
	return TRUE

/datum/preferences/apply_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE)
	. = ..()
	apply_bark_prefs_to(character)

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "barks")
		show_bark_prefs_ui(user)
		return
	if(href_list["task"] == "change_bark_pref")
		handle_bark_prefs_topic(user, href_list)
		show_bark_prefs_ui(user)
		return
	return ..()
