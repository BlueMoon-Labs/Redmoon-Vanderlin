/atom/movable/proc/queue_speech_barks(list/hearers, message, range, list/spans, list/message_mods)
	if(message_mods[WHISPER_MODE])
		return
	if(SEND_SIGNAL(src, COMSIG_MOVABLE_QUEUE_BARK, hearers, args))
		return
	if(!vocal_bark && !vocal_bark_id)
		return

	for(var/mob/M in hearers)
		if(!M.client)
			continue
		if(!(M.client.prefs.hear_barks))
			hearers -= M

	var/is_yell = (say_test(message) == "2" || say_test(message) == "3")
	var/barks = min(round((LAZYLEN(message) / vocal_speed)) + 1, BARK_MAX_BARKS)
	var/total_delay = 0
	vocal_current_bark = world.time
	for(var/i in 1 to barks)
		if(total_delay > BARK_MAX_TIME)
			break
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, bark), hearers, range, (vocal_volume * (is_yell ? 1.5 : 1)), BARK_DO_VARY(vocal_pitch, vocal_pitch_range), vocal_current_bark), total_delay)
		total_delay += rand(DS2TICKS(vocal_speed / BARK_SPEED_BASELINE), DS2TICKS(vocal_speed / BARK_SPEED_BASELINE) + DS2TICKS((vocal_speed / BARK_SPEED_BASELINE) * (is_yell ? 0.5 : 1))) TICKS

/atom/movable/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language = null, list/message_mods = list(), original_message)
	var/list/hearers = get_hearers_in_view(range, source)
	. = ..()
	queue_speech_barks(hearers, message, range, spans, message_mods)
