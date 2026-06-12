/datum/species
	var/always_play_send_voice = FALSE

/datum/species/werewolf
	always_play_send_voice = TRUE

/datum/species/werewolf/proc/cancel_default_bark(atom/movable/source, list/hearers, distance, volume, pitch)
	SIGNAL_HANDLER
	return TRUE
