/datum/preferences
	/// Invalidates stale preference browser URLs on refresh/reload.
	var/pref_action_token = ""
	/// Blocks duplicate IE topic replays within the same tick.
	var/list/last_prefs_href_list
	var/last_prefs_href_tick = 0
	/// Ctrl+mousewheel zoom on the prefs browser control (IE/Trident).
	var/pref_browser_zoom = "1"

	var/datum/character_offer_instance/offer
