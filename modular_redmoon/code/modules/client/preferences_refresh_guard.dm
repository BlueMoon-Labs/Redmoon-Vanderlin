/// IE's embedded browser replays the last topic URL when browse() refreshes the prefs window.
/// Tokens are embedded server-side (no JavaScript). Stale replays carry an old token after rebuild.

/datum/preferences/proc/pref_href_is_duplicate_replay(list/href_list)
	if(!href_list["pref_token"])
		return FALSE
	if(!length(last_prefs_href_list))
		return FALSE
	if(world.time != last_prefs_href_tick)
		return FALSE
	for(var/key in href_list)
		if(key == "pref_token")
			continue
		if(href_list[key] != last_prefs_href_list[key])
			return FALSE
	return TRUE

/datum/preferences/proc/record_prefs_href(list/href_list)
	last_prefs_href_list = href_list.Copy()
	last_prefs_href_tick = world.time

/datum/preferences/proc/inject_pref_action_tokens(html)
	if(!pref_action_token)
		pref_action_token = "[world.time]_[rand(1, 99999)]"
	var/needle = "'?_src_=prefs;"
	var/pos = 1
	while(pos)
		var/start = findtext(html, needle, pos)
		if(!start)
			break
		var/end = findtext(html, "'", start + length(needle))
		if(!end)
			break
		var/chunk = copytext(html, start, end)
		if(!findtext(chunk, "pref_token="))
			var/replacement = "[chunk];pref_token=[pref_action_token]"
			html = copytext(html, 1, start) + replacement + copytext(html, end)
			pos = start + length(replacement)
		else
			pos = end + 1
	return html

/datum/preferences/proc/pref_link_token_valid(list/href_list)
	if(href_list["preference"] == "preview_dir")
		return TRUE
	if(!href_list["pref_token"])
		return TRUE
	return href_list["pref_token"] == pref_action_token

/datum/preferences/proc/should_ignore_prefs_href(list/href_list)
	if(pref_href_is_duplicate_replay(href_list))
		return TRUE
	if(!pref_link_token_valid(href_list))
		return TRUE
	if(href_list["pref_token"])
		record_prefs_href(href_list)
	return FALSE

/datum/preferences/proc/capture_preferences_browser_zoom(mob/user)
	if(!user?.client)
		return
	if(!winexists(user, "stonekeep_prefwin.preferences_browser"))
		return
	var/current_zoom = winget(user, "stonekeep_prefwin.preferences_browser", "zoom")
	if(current_zoom && current_zoom != "0")
		pref_browser_zoom = current_zoom

/datum/preferences/proc/apply_preferences_browser_zoom(mob/user, zoom)
	if(!user?.client || !zoom || zoom == "0")
		return
	if(!winexists(user, "stonekeep_prefwin.preferences_browser"))
		return
	winset(user, "stonekeep_prefwin.preferences_browser", list("zoom" = zoom))

/datum/preferences/proc/apply_preferences_browser_layout(mob/user)
	if(!user?.client)
		return
	if(!winexists(user, "stonekeep_prefwin"))
		return
	winset(user, "stonekeep_prefwin", "size=[CHARSHEET_WINDOW_WIDTH]x[CHARSHEET_WINDOW_HEIGHT]")
	winset(user, "stonekeep_prefwin.preferences_browser", "size=[CHARSHEET_WINDOW_WIDTH]x[CHARSHEET_WINDOW_HEIGHT]")
	winset(user, "stonekeep_prefwin.character_preview_map", "pos=[CHARSHEET_PREVIEW_LEFT],[CHARSHEET_PREVIEW_TOP];size=[CHARSHEET_PREVIEW_WIDTH]x[CHARSHEET_PREVIEW_HEIGHT]")

/datum/preferences/proc/show_preferences_browser_html(mob/user, html)
	if(!user?.client)
		return
	capture_preferences_browser_zoom(user)
	user << browse(html, "window=stonekeep_prefwin.preferences_browser;size=[CHARSHEET_WINDOW_WIDTH]x[CHARSHEET_WINDOW_HEIGHT]")
	apply_preferences_browser_layout(user)
	var/zoom = pref_browser_zoom
	if(!zoom || zoom == "0")
		zoom = "1"
	// IE reloads HTML after browse(); apply user zoom once the control exists.
	spawn(1)
		apply_preferences_browser_zoom(user, zoom)
		apply_preferences_browser_layout(user)
	spawn(5)
		apply_preferences_browser_zoom(user, zoom)
		apply_preferences_browser_layout(user)
