/datum/preferences/proc/get_next_dir(current_dir, invert = FALSE)
	var/list/dirs = list(NORTH, EAST, SOUTH, WEST)

	var/idx = dirs.Find(current_dir)
	if(!idx)
		idx = 1

	if(invert)
		idx--
		if(idx < 1)
			idx = dirs.len
	else
		idx++
		if(idx > dirs.len)
			idx = 1

	return dirs[idx]

/datum/preferences/proc/handle_preview_dir_click(mob/user, href_list)
	var/invert = text2num(href_list["invert"]) ? TRUE : FALSE
	preview_direction = get_next_dir(preview_direction, invert)
	update_preview_icon(preview_direction)

/datum/preferences/proc/handle_body_color_input(mob/user)
	var/current_tone = read_preference(/datum/preference/choiced/skin_tone)
	var/new_color = input(user, "Выбери цвет кожи/шерсти своего персонажа", "THE THROAT", "#[normalize_skin_tone_hex(current_tone)]") as color|null
	if(!new_color)
		return
	write_preference(/datum/preference/choiced/skin_tone, normalize_skin_tone_hex(sanitize_hexcolor(new_color)))
	reset_all_customizer_accessory_colors()
	update_preview_icon(preview_direction)
