//ПОРТИРОВАНО

/client

	var/list/screen_maps = list()

/client/proc/create_popup(name, ratiox = 100, ratioy = 100)
	winclone(src, "popupwindow", name)
	var/list/winparams = list()
	winparams["size"] = "[ratiox]x[ratioy]"
	winparams["on-close"] = "handle-popup-close [name]"
	winset(src, "[name]", list2params(winparams))
	winshow(src, "[name]", 1)

	var/list/params = list()
	params["parent"] = "[name]"
	params["type"] = "map"
	params["size"] = "[ratiox]x[ratioy]"
	params["anchor1"] = "0,0"
	params["anchor2"] = "[ratiox],[ratioy]"
	winset(src, "[name]_map", list2params(params))

	return "[name]_map"

/atom/movable/screen/background
	name = "background"
	icon = 'modular_redmoon/icons/ui/backgrounds.dmi'
	icon_state = "clear"
	layer = GAME_PLANE
	plane = GAME_PLANE

/atom/movable/screen/proc/fill_rect(x1, y1, x2, y2)
	if(assigned_map)
		screen_loc = "[assigned_map]:[x1],[y1] to [x2],[y2]"
	else
		screen_loc = "[x1],[y1] to [x2],[y2]"

/client/proc/setup_popup(popup_name, width = 9, height = 9, \
		tilesize = 2, bg_icon)
	if(!popup_name)
		return
	clear_map("[popup_name]_map")
	var/x_value = world.icon_size * tilesize * width
	var/y_value = world.icon_size * tilesize * height
	var/map_name = create_popup(popup_name, x_value, y_value)

	var/atom/movable/screen/background/background = new
	background.assigned_map = map_name
	background.fill_rect(1, 1, width, height)
	if(bg_icon)
		background.icon_state = bg_icon
	register_map_obj(background)

	return map_name

/client/proc/clear_map(map_name)
	if(!map_name || !(map_name in screen_maps))
		return FALSE
	for(var/atom/movable/screen/screen_obj in screen_maps[map_name])
		screen_maps[map_name] -= screen_obj
		if(screen_obj.del_on_map_removal)
			qdel(screen_obj)
	screen_maps -= map_name


/**
 * Closes a popup.
 */
/client/proc/close_popup(popup)
	winshow(src, popup, 0)
	handle_popup_close(popup)

/**
 * When the popup closes in any way (player or proc call) it calls this.
 */
/client/verb/handle_popup_close(window_id as text)
	set hidden = TRUE
	clear_map("[window_id]_map")

/**
 * Registers screen obj with the client, which makes it visible on the
 * assigned map, and becomes a part of the assigned map's lifecycle.
 */
/client/proc/register_map_obj(atom/movable/screen/screen_obj)
	if(!screen_obj.assigned_map)
		CRASH("Can't register [screen_obj] without 'assigned_map' property.")
	if(!screen_maps[screen_obj.assigned_map])
		screen_maps[screen_obj.assigned_map] = list()
	// NOTE: Possibly an expensive operation
	var/list/screen_map = screen_maps[screen_obj.assigned_map]
	if(!screen_map.Find(screen_obj))
		screen_map += screen_obj
	if(!screen.Find(screen_obj))
		screen += screen_obj


//КОНЕЦ ПОРТИРОВАНО

/mob/living/carbon/human
	/// Профиль для окна взаимодействия
	var/datum/interaction_profile/interaction_profile


/datum/interaction_profile
	var/datum/weakref/host
	var/atom/movable/screen/map_view/interaction_screen/interaction_screen
	var/mutable_appearance/current_mob_appearance
	var/mutable_appearance/current_background
	var/list/actions_by_part
	var/list/all_actions_by_part

/datum/interaction_profile/proc/new_action_parts_map()
	return list(
		"head"      = list(),
		"chest"     = list(),
		"groin"     = list(),
		"left_arm"  = list(),
		"right_arm" = list(),
		"left_leg"  = list(),
		"right_leg" = list(),
		"tail"      = list(),
	)

/datum/interaction_profile/proc/ensure_action_maps()
	if(!islist(actions_by_part))
		actions_by_part = new_action_parts_map()
	if(!islist(all_actions_by_part))
		all_actions_by_part = new_action_parts_map()

/datum/interaction_profile/proc/reset_action_map(list/action_map)
	if(!islist(action_map))
		return
	for(var/part in action_map)
		action_map[part] = list()

/datum/interaction_profile/proc/get_favorite_actions(mob/living/user)
	if(!user?.client?.prefs)
		return list()
	if(!islist(user.client.prefs.favorite_interactions))
		user.client.prefs.favorite_interactions = list()
	return user.client.prefs.favorite_interactions

/datum/interaction_profile/proc/persist_favorite_actions(mob/living/user)
	if(!user?.client?.prefs)
		return
	if(!islist(user.client.prefs.favorite_interactions))
		user.client.prefs.favorite_interactions = list()
	user.client.prefs.save_preferences()

/datum/interaction_profile/proc/sort_actions_with_favorites(list/source_actions, list/favorite_actions)
	if(!islist(source_actions))
		return list()
	if(!islist(favorite_actions) || !length(favorite_actions))
		return source_actions.Copy()

	var/list/sorted_actions = list()
	for(var/favorite_id in favorite_actions)
		for(var/list/action in source_actions)
			if(action["id"] == favorite_id)
				sorted_actions += list(action)

	for(var/list/action in source_actions)
		if(!(action["id"] in favorite_actions))
			sorted_actions += list(action)

	return sorted_actions

/datum/interaction_profile/proc/build_all_actions(mob/living/user)
	ensure_action_maps()
	reset_action_map(all_actions_by_part)

	if(!islist(SSinteractions?.interactions))
		return

	for(var/interaction_key in SSinteractions.interactions)
		var/datum/interaction/I = SSinteractions.interactions[interaction_key]
		if (!I || !I.description)
			continue
		if (I.interaction_flags & INTERACTION_FLAG_HIDE_IN_PANEL)
			continue
		if (!islist(I.body_parts) || !length(I.body_parts))
			continue

		var/list/action = list(
			"id"   = "[I.type]",
			"name" = I.description,
		)

		for (var/part in I.body_parts)
			if (!(part in all_actions_by_part))
				continue
			all_actions_by_part[part] += list(action)

	var/list/favorite_actions = get_favorite_actions(user)
	for(var/part in all_actions_by_part)
		all_actions_by_part[part] = sort_actions_with_favorites(all_actions_by_part[part], favorite_actions)

/datum/interaction_profile/proc/build_actions(mob/living/user, mob/living/target)
	if (!user || !target)
		return

	ensure_action_maps()
	reset_action_map(actions_by_part)

	if(!islist(SSinteractions?.interactions))
		return

	for (var/interaction_key in SSinteractions.interactions)
		var/datum/interaction/I = SSinteractions.interactions[interaction_key]
		if (!I || !I.description)
			continue
		if (I.interaction_flags & INTERACTION_FLAG_HIDE_IN_PANEL)
			continue

		// Проверка базовых и расширенных требований.
		if (!I.evaluate_user(user, TRUE, FALSE))
			continue
		if (!I.evaluate_target(user, target, TRUE))
			continue
		if (!I.evaluate_extended_requirements(user, target, TRUE))
			continue

		if (!islist(I.body_parts) || !length(I.body_parts))
			continue

		var/list/action = list(
			"id"   = "[I.type]",
			"name" = I.description,
		)

		for (var/part in I.body_parts)
			if (!(part in actions_by_part))
				continue
			actions_by_part[part] += list(action)

	var/list/favorite_actions = get_favorite_actions(user)
	for(var/part in actions_by_part)
		actions_by_part[part] = sort_actions_with_favorites(actions_by_part[part], favorite_actions)


/datum/interaction_profile/New(var/host_mob)
	. = ..()
	host = WEAKREF(host_mob)


/datum/interaction_profile/Destroy(force, ...)
	. = ..()
	host = null


/// Экран для отображения тела в TGUI (аналог examine_panel_screen)
/atom/movable/screen/map_view/interaction_screen
	name = "interaction body screen"


/// Обновление превью моба на экране
/datum/interaction_profile/proc/update_preview()
	if (!interaction_screen || !current_background)
		return

	var/mob/living/M = host.resolve()
	if (!M)
		return

	current_mob_appearance = new(M)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix()
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	current_mob_appearance.add_overlay(current_background)

	interaction_screen.cut_overlays()
	interaction_screen.add_overlay(current_mob_appearance)


// ====== Открытие через Ctrl+ShiftClick ======

/mob/living/carbon/human/CtrlShiftClickOn(atom/clicked_atom, list/modifiers)
    . = ..()
    if (!istype(clicked_atom, /mob/living/carbon/human))
        return

    var/mob/living/carbon/human/target = clicked_atom

    var/datum/interaction_profile/profile = target.interaction_profile
    if (!profile)
        profile = new(target)
        target.interaction_profile = profile

    profile.ui_interact(src, null)

// ====== TGUI-хуки для датум-профиля ======

/datum/interaction_profile/ui_state()
	return GLOB.always_state


/datum/interaction_profile/ui_static_data(mob/user, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	var/list/data = list()
	var/mob/living/M = host.resolve()
	if (!M)
		return data

	data["entity_from"] = user.real_name
	data["entity_to"] = M.real_name
	data["character_ref"] = interaction_screen?.assigned_map

	return data


/datum/interaction_profile/ui_data(mob/user)
	. = ..()
	var/list/data = list()
	var/mob/living/M = host?.resolve()
	if(!M)
		return data
	build_actions(user, M)
	build_all_actions(user)
	data["actions_by_part"] = actions_by_part
	data["all_actions_by_part"] = all_actions_by_part
	data["favorite_actions"] = get_favorite_actions(user)
	return data

/datum/interaction_profile/proc/find_interaction_by_id(action_id)
	for (var/interaction_key in SSinteractions.interactions)
		var/datum/interaction/I = SSinteractions.interactions[interaction_key]
		if (!I)
			continue
		if ("[I.type]" == action_id)
			return I

	return null

/datum/interaction_profile/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return

	var/mob/living/user = ui.user
	var/mob/living/target = host?.resolve()
	if (!user || !target)
		return

	switch (action)
		if ("run_action_once")
			var/action_id = params["action_id"]

			var/datum/interaction/I = find_interaction_by_id(action_id)
			if (!I)
				return

			I.do_action(user, target)
			build_actions(user, target)
			return TRUE
		if("toggle_preferred_action")
			var/action_id = "[params["action_id"]]"
			if(!length(action_id))
				return
			var/list/favorite_actions = get_favorite_actions(user)
			if(action_id in favorite_actions)
				favorite_actions -= action_id
			else
				favorite_actions += action_id
			if(user?.client?.prefs)
				user.client.prefs.favorite_interactions = favorite_actions
				persist_favorite_actions(user)
			build_actions(user, target)
			build_all_actions(user)
			return TRUE
		if("move_preferred_action")
			var/action_id = "[params["action_id"]]"
			var/direction = "[params["direction"]]"
			var/list/favorite_actions = get_favorite_actions(user)
			var/current_index = favorite_actions.Find(action_id)
			if(!current_index)
				return
			var/new_index = current_index
			if(direction == "up")
				new_index = max(1, current_index - 1)
			else if(direction == "down")
				new_index = min(length(favorite_actions), current_index + 1)
			if(new_index != current_index)
				var/swap_action = favorite_actions[new_index]
				favorite_actions[new_index] = favorite_actions[current_index]
				favorite_actions[current_index] = swap_action
			if(user?.client?.prefs)
				user.client.prefs.favorite_interactions = favorite_actions
				persist_favorite_actions(user)
			build_actions(user, target)
			build_all_actions(user)
			return TRUE
		if("clear_preferred_actions")
			var/list/favorite_actions = get_favorite_actions(user)
			favorite_actions.Cut()
			if(user?.client?.prefs)
				user.client.prefs.favorite_interactions = favorite_actions
				persist_favorite_actions(user)
			build_actions(user, target)
			build_all_actions(user)
			return TRUE

/datum/interaction_profile/ui_interact(mob/user, datum/tgui/ui, datum/tgui/parent_ui)
	var/mob/living/M = host.resolve()
	if (!M)
		return

	if (!interaction_screen)
		interaction_screen = new
		interaction_screen.name = "interaction body screen"

		// создаём отдельную мини-карту через setup_popup
		var/map_name = user.client.setup_popup("interaction_panel_[REF(M)]", 1, 1, 2, null)
		interaction_screen.assigned_map = map_name
		interaction_screen.del_on_map_removal = FALSE
		interaction_screen.screen_loc = "[interaction_screen.assigned_map]:1,1"

	if (!current_background)
		current_background = mutable_appearance('icons/effects/effects.dmi', "nothing", layer = SPACE_LAYER)

	update_preview()

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		user.client.register_map_obj(interaction_screen)
		interaction_screen.setDir(SOUTH)
		ui = new(user, src, "InteractMenu", "Взаимодействие с телом")
		ui.open()
