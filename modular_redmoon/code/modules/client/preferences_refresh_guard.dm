/// Blocks stale preference browser URLs from re-running actions after F5/refresh.
/datum/preferences/proc/pref_link_token_valid(list/href_list)
	if(href_list["preference"] == "preview_dir")
		return TRUE
	if(!pref_action_token)
		return FALSE
	// Auxiliary windows (customizers, keybinds, etc.) omit the token.
	if(!href_list["pref_token"])
		return TRUE
	return href_list["pref_token"] == pref_action_token
