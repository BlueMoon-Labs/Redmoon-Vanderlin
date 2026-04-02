/// Результат разбора одного слота персонажа
/datum/bm_character_export
	var/ckey
	var/slot          // номер слота
	var/list/raw      // все прочитанные поля (ключ -> значение)
	var/save_version  // версия сейва (число)
	var/list/errors   // строки с ошибками/варнингами

/// Читает локальный файл preferences.sav и возвращает список /datum/bm_character_export
/// Один элемент списка = один заполненный characterN
/proc/read_bm_savefile(path)
	var/list/characters = list()

	if(!fexists(path))
		world.log << "read_bm_savefile: file not found: [path]"
		return characters

	var/savefile/S = new /savefile(path)
	if(!S)
		world.log << "read_bm_savefile: cannot open savefile: [path]"
		return characters

	// Считаем версию корня, чтобы можно было ориентироваться
	S.cd = "/"
	var/savefile_version = null
	S["version"] >> savefile_version

	// Пробегаем по директориям characterN
	for(var/entry in S.dir)
		if(copytext(entry, 1, 10) != "character")
			continue

		var/slot_num = text2num(copytext(entry, 10))
		if(!slot_num)
			continue

		var/datum/bm_character_export/exp = new
		exp.slot = slot_num
		exp.save_version = savefile_version
		exp.raw = list()
		exp.errors = list()
		// ckey из корня
		exp.ckey = _bm_read_ckey(S)

		// читаем все поля конкретного персонажа
		_bm_read_character_slot(S, entry, exp)

		// если персонаж пустой (нет real_name), можно пропустить
		if(!exp.raw["real_name"])
			continue

		characters += exp

	return characters

/// Читает ckey из корня сейва, если есть
/proc/_bm_read_ckey(savefile/S)
	var/old_cd = S.cd
	S.cd = "/"
	var/ckey_value = null

	// многие билды не хранят ckey в savefile, try/catch нам не нужен, оператор >> сам тихо даст null
	S["ckey"] >> ckey_value

	S.cd = old_cd
	return ckey_value

/// Читает все нужные поля из директории characterN в экспорт
/proc/_bm_read_character_slot(savefile/S, dir_name, datum/bm_character_export/exp)
	var/old_cd = S.cd
	S.cd = "[dir_name]"

	// 1) Базовая информация
	_bm_read_basic_info(S, exp)

	// 2) Внешность и species
	_bm_read_species_and_appearance(S, exp)

	// 3) Job preferences и связанные вещи
	_bm_read_jobs_and_records(S, exp)

	// 4) Features (мутант‑части, NSFW, vore и т.п.)
	_bm_read_features(S, exp)

	// 5) Loadout, unlockables, фаворитные аутфиты
	_bm_read_loadout(S, exp)

	// 6) Прочие списки/настройки персонажа (quirks, языки, и т.п.)
	_bm_read_misc(S, exp)

	S.cd = old_cd

/proc/_bm_read_basic_info(savefile/S, datum/bm_character_export/exp)
	var/list/R = exp.raw

	R["real_name"]            = _bm_read_value(S, "real_name")
	R["name_is_always_random"] = _bm_read_value(S, "name_is_always_random")
	R["gender"]               = _bm_read_value(S, "gender")
	R["age"]                  = _bm_read_value(S, "age")
	R["disabilities"]         = _bm_read_value(S, "disabilities")
	R["ui_style"]             = _bm_read_value(S, "UI_style") // на всякий случай
	R["hud_style"]            = _bm_read_value(S, "hud_style")

	// security/medical records
	R["security_note"]        = _bm_read_value(S, "security_note")
	R["security_record"]      = _bm_read_value(S, "security_record")
	R["medical_record"]       = _bm_read_value(S, "medical_record")
	R["general_record"]       = _bm_read_value(S, "general_record")

/proc/_bm_read_species_and_appearance(savefile/S, datum/bm_character_export/exp)
	var/list/R = exp.raw

	// species
	R["species"]              = _bm_read_value(S, "species")

	// базовая внешность
	R["hair_style_name"]      = _bm_read_value(S, "hair_style_name")
	R["facial_hair_style_name"] = _bm_read_value(S, "facial_hair_style_name")
	R["hair_color"]           = _bm_read_value(S, "hair_color")
	R["facial_hair_color"]    = _bm_read_value(S, "facial_hair_color")
	R["underwear"]            = _bm_read_value(S, "underwear")
	R["underwear_color"]      = _bm_read_value(S, "underwear_color")
	R["undershirt"]           = _bm_read_value(S, "undershirt")
	R["undershirt_color"]     = _bm_read_value(S, "undershirt_color")
	R["socks"]                = _bm_read_value(S, "socks")
	R["socks_color"]          = _bm_read_value(S, "socks_color")
	R["shoe_style"]           = _bm_read_value(S, "shoe_style")
	R["backpack"]             = _bm_read_value(S, "backpack")
	R["skin_tone"]            = _bm_read_value(S, "skin_tone")
	R["eye_color"]            = _bm_read_value(S, "eye_color")
	R["left_eye_color"]       = _bm_read_value(S, "left_eye_color")
	R["right_eye_color"]      = _bm_read_value(S, "right_eye_color")
	R["body_size"]            = _bm_read_value(S, "body_size")

	R["custom_species"]       = _bm_read_value(S, "custom_species")
	R["language"]             = _bm_read_value(S, "language")

	// advanced coloring / mutant coloring flags
	R["color_scheme"]         = _bm_read_value(S, "color_scheme")
	R["mcolor"]               = _bm_read_value(S, "feature_mcolor")       // может быть и в features, но читаем как есть
	R["mcolor2"]              = _bm_read_value(S, "feature_mcolor2")
	R["mcolor3"]              = _bm_read_value(S, "feature_mcolor3")

	// flavor text & notes
	R["flavor_text"]          = _bm_read_value(S, "flavor_text")
	R["silicon_flavor_text"]  = _bm_read_value(S, "silicon_flavor_text")
	R["ooc_notes"]            = _bm_read_value(S, "ooc_notes")

/proc/_bm_read_jobs_and_records(savefile/S, datum/bm_character_export/exp)
	var/list/R = exp.raw

	R["job_preferences"]      = _bm_read_value(S, "job_preferences")
	R["alt_titles_preferences"] = _bm_read_value(S, "alt_titles_preferences")
	R["hide_ckey"]            = _bm_read_value(S, "hide_ckey")
	R["antag_toggles"]        = _bm_read_value(S, "antag_toggles")
	R["preferred_map"]        = _bm_read_value(S, "preferred_map")

	// эмоута панель
	R["custom_emote_panel"]   = _bm_read_value(S, "custom_emote_panel")

/proc/_bm_read_features(savefile/S, datum/bm_character_export/exp)
	var/list/R = exp.raw

	// общий список features
	R["features"] = _bm_read_value(S, "features")

	// для удобства ещё отдельно вытащим некоторые частоиспользуемые ключи, если они есть в savefile как отдельные поля
	R["mutant_colors"]        = list(
		"mcolor"  = _bm_read_value(S, "feature_mcolor"),
		"mcolor2" = _bm_read_value(S, "feature_mcolor2"),
		"mcolor3" = _bm_read_value(S, "feature_mcolor3")
	)

	// vore / NSFW
	R["vore_flags"]           = _bm_read_value(S, "vore_flags")
	R["belly_prefs"]          = _bm_read_value(S, "belly_prefs")
	R["vore_taste"]           = _bm_read_value(S, "vore_taste")
	R["vore_smell"]           = _bm_read_value(S, "vore_smell")
	R["vore_sound"]           = _bm_read_value(S, "vore_sound")

	R["arousable"]            = _bm_read_value(S, "arousable")
	R["cit_toggles"]          = _bm_read_value(S, "cit_toggles")
	R["all_quirks"]           = _bm_read_value(S, "all_quirks")

	R["body_weight"]          = _bm_read_value(S, "body_weight")
	R["virility"]             = _bm_read_value(S, "virility")
	R["fertility"]            = _bm_read_value(S, "fertility")
	R["egg_fertility"]        = _bm_read_value(S, "egg_fertility")
	R["egg_strength"]         = _bm_read_value(S, "egg_strength")
	R["womb_egg_capacity"]    = _bm_read_value(S, "womb_egg_capacity")
	R["womb_egg_volume"]      = _bm_read_value(S, "womb_egg_volume")
	R["oviposition_method"]   = _bm_read_value(S, "oviposition_method")
	R["inert_eggs"]           = _bm_read_value(S, "inert_eggs")

/proc/_bm_read_loadout(savefile/S, datum/bm_character_export/exp)
	var/list/R = exp.raw

	R["loadout_data"]         = _bm_read_value(S, "loadout")
	R["unlockable_loadout"]   = _bm_read_value(S, "unlockable_loadout")
	R["favorite_outfits"]     = _bm_read_value(S, "favorite_outfits")

	R["tcg_cards"]            = _bm_read_value(S, "tcg_cards")
	R["tcg_decks"]            = _bm_read_value(S, "tcg_decks")

/proc/_bm_read_misc(savefile/S, datum/bm_character_export/exp)
	var/list/R = exp.raw

	R["known_languages"]      = _bm_read_value(S, "known_languages")

	R["persistent_scars"]     = _bm_read_value(S, "persistent_scars")
	R["modified_limbs"]       = _bm_read_value(S, "modified_limbs")
	R["tattoos"]              = _bm_read_value(S, "tattoos")

	R["headshot_path"]        = _bm_read_value(S, "headshot")
	R["deathgasp_sound"]      = _bm_read_value(S, "deathgasp_sound")
	R["custom_sounds"]        = _bm_read_value(S, "custom_sounds")

	R["extra_settings"]       = _bm_read_value(S, "extra_settings")

/// Безопасно читает значение из savefile и возвращает его
/proc/_bm_read_value(savefile/S, key)
	var/value = null
	// >> сам по себе безопасен, если ключа нет
	S[key] >> value
	return value
