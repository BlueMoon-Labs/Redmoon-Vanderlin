GLOBAL_LIST_INIT(erp_consent_cycle_ask, list(BEVICTIM_ASK, BEVICTIM_YES, BEVICTIM_NO))
GLOBAL_LIST_INIT(erp_consent_cycle_no, list(BEVICTIM_NO, BEVICTIM_YES))

DEFINE_BITFIELD(citadel_toggles, list(
	"Medihound sleeper" = MEDIHOUND_SLEEPER,
	"Eating noises" = EATING_NOISES,
	"Digestion noises" = DIGESTION_NOISES,
	"Breast enlargement" = BREAST_ENLARGEMENT,
	"Penis enlargement" = PENIS_ENLARGEMENT,
	"Forced feminization" = FORCED_FEM,
	"Forced masculinization" = FORCED_MASC,
	"Hypnosis" = HYPNO,
	"Never hypnosis" = NEVER_HYPNO,
	"No aphrodisiacs" = NO_APHRO,
	"No ass slap" = NO_ASS_SLAP,
	"Bimbofication" = BIMBOFICATION,
	"No auto wag" = NO_AUTO_WAG,
	"Genital examine" = GENITAL_EXAMINE,
	"Vore examine" = VORE_EXAMINE,
	"Trash forcefeed" = TRASH_FORCEFEED,
	"Butt enlargement" = BUTT_ENLARGEMENT,
	"Belly inflation" = BELLY_INFLATION,
	"Chastity" = CHASTITY,
	"Stimulation" = STIMULATION,
	"Edging" = EDGING,
	"No disco dance" = NO_DISCO_DANCE,
	"Cum onto partner" = CUM_ONTO,
	"Sex jitter" = SEX_JITTER,
))

/datum/preferences/proc/get_erp_consent_pref_value(pref_id)
	switch(pref_id)
		if("erppref")
			return erppref
		if("nonconpref")
			return nonconpref
		if("unholypref")
			return unholypref
		if("extremepref")
			return extremepref
		if("extremeharm")
			return extremeharm
		if("vorepref")
			return vorepref
		if("mobsexpref")
			return mobsexpref
		if("hornyantagspref")
			return hornyantagspref
		if("tattoopref")
			return tattoopref
	return null

/datum/preferences/proc/set_erp_consent_pref_value(pref_id, value)
	switch(pref_id)
		if("erppref")
			erppref = value
		if("nonconpref")
			nonconpref = value
		if("unholypref")
			unholypref = value
		if("extremepref")
			extremepref = value
		if("extremeharm")
			extremeharm = value
		if("vorepref")
			vorepref = value
		if("mobsexpref")
			mobsexpref = value
		if("hornyantagspref")
			hornyantagspref = value
		if("tattoopref")
			tattoopref = value

/datum/preferences/proc/sanitize_erp_preferences()
	erppref = sanitize_inlist(erppref, GLOB.erp_consent_cycle_ask, BEVICTIM_ASK)
	nonconpref = sanitize_inlist(nonconpref, GLOB.erp_consent_cycle_ask, BEVICTIM_ASK)
	vorepref = sanitize_inlist(vorepref, GLOB.erp_consent_cycle_ask, BEVICTIM_ASK)
	tattoopref = sanitize_inlist(tattoopref, GLOB.erp_consent_cycle_ask, BEVICTIM_ASK)
	unholypref = sanitize_inlist(unholypref, GLOB.erp_consent_cycle_no, BEVICTIM_NO)
	extremepref = sanitize_inlist(extremepref, GLOB.erp_consent_cycle_no, BEVICTIM_NO)
	extremeharm = sanitize_inlist(extremeharm, GLOB.erp_consent_cycle_no, BEVICTIM_NO)
	mobsexpref = sanitize_inlist(mobsexpref, GLOB.erp_consent_cycle_no, BEVICTIM_NO)
	hornyantagspref = sanitize_inlist(hornyantagspref, GLOB.erp_consent_cycle_no, BEVICTIM_NO)
	arousal_multiplier = clamp(arousal_multiplier, 0, 200)
	moaning_multiplier = clamp(moaning_multiplier, 0, 100)
	gfluid_blacklist = SANITIZE_LIST(gfluid_blacklist)

/datum/preferences/proc/erp_consent_link_color(value)
	switch(value)
		if(BEVICTIM_YES)
			return "#6ecf6e"
		if(BEVICTIM_NO)
			return "#cc6666"
	return "#e6c619"

/datum/preferences/proc/cycle_erp_consent_pref(pref_id, use_ask_cycle = TRUE)
	var/list/options = use_ask_cycle ? GLOB.erp_consent_cycle_ask : GLOB.erp_consent_cycle_no
	var/current = get_erp_consent_pref_value(pref_id)
	var/index = options.Find(current)
	if(!index)
		index = 1
	index = (index % length(options)) + 1
	set_erp_consent_pref_value(pref_id, options[index])

/datum/preferences/proc/print_erp_consent_row(list/dat, pref_id, label, use_ask_cycle = TRUE)
	var/value = get_erp_consent_pref_value(pref_id)
	if(!value)
		return
	var/color = erp_consent_link_color(value)
	dat += "<tr><td><b>[label]</b></td><td><a href='?_src_=prefs;task=change_erp_pref;erp_task=cycle;pref_id=[pref_id];ask_cycle=[use_ask_cycle ? 1 : 0]' style='color:[color];'>[value]</a></td></tr>"

/datum/preferences/proc/print_erp_toggle_row(list/dat, label, href_task, enabled)
	var/state = enabled ? "On" : "Off"
	var/color = enabled ? "#6ecf6e" : "#cc6666"
	dat += "<tr><td><b>[label]</b></td><td><a href='?_src_=prefs;task=change_erp_pref;erp_task=[href_task]' style='color:[color];'>[state]</a></td></tr>"

/datum/preferences/proc/print_erp_prefs_page()
	var/list/dat = list()
	dat += "<meta charset='utf-8'><style>\
		body { background-color: #2a2218; color: #c4b08a; font-family: Verdana, Geneva, sans-serif; margin: 8px; }\
		table.erp-prefs { width: 100%; border-collapse: collapse; }\
		table.erp-prefs td { padding: 4px 6px; border-bottom: 1px solid #5c4a32; vertical-align: top; }\
		h3 { margin: 0 0 8px 0; text-align: center; color: #e8dcc4; font-size: 13px; letter-spacing: 0.5px; }\
		.erp-note { font-size: 11px; color: #9a8870; margin-top: 10px; line-height: 1.35; }\
		a { color: #d4c4a0; }\
		</style>"
	dat += "<h3>ERP / Consent</h3>"
	dat += "<table class='erp-prefs'>"
	print_erp_consent_row(dat, "erppref", "ERP", TRUE)
	print_erp_consent_row(dat, "nonconpref", "Non-con (CNC)", TRUE)
	print_erp_consent_row(dat, "vorepref", "Vore", TRUE)
	print_erp_consent_row(dat, "tattoopref", "Tattoos", TRUE)
	print_erp_consent_row(dat, "unholypref", "Unholy content", FALSE)
	print_erp_consent_row(dat, "extremepref", "Extreme content", FALSE)
	print_erp_consent_row(dat, "extremeharm", "Extreme harm", FALSE)
	print_erp_consent_row(dat, "mobsexpref", "Hostile mobs", FALSE)
	print_erp_consent_row(dat, "hornyantagspref", "Horny antags", FALSE)
	dat += "</table>"

	dat += "<br><table class='erp-prefs'>"
	print_erp_toggle_row(dat, "See ERP messages", "toggle_verb_consent", toggles & VERB_CONSENT)
	print_erp_toggle_row(dat, "ERP action sounds", "toggle_lewd_sounds", toggles & LEWD_VERB_SOUNDS)
	print_erp_toggle_row(dat, "Ranged ERP", "toggle_ranged_consent", toggles & RANGED_VERBS_CONSENT)
	print_erp_toggle_row(dat, "Arousable", "toggle_arousable", arousable)
	print_erp_toggle_row(dat, "Custom arousal multiplier", "toggle_arousal_multiplier", use_arousal_multiplier)
	dat += "<tr><td><b>Arousal strength</b></td><td><a href='?_src_=prefs;task=change_erp_pref;erp_task=set_arousal_multiplier'>[arousal_multiplier]%</a></td></tr>"
	print_erp_toggle_row(dat, "Manual moan chance", "toggle_moaning_multiplier", use_moaning_multiplier)
	dat += "<tr><td><b>Moan chance</b></td><td><a href='?_src_=prefs;task=change_erp_pref;erp_task=set_moaning_multiplier'>[moaning_multiplier]%</a></td></tr>"
	dat += "</table>"

	dat += "<br><center><a href='?_src_=prefs;preference=erp;task=cit_toggles'>Mechanics (Citadel toggles)</a></center>"
	dat += "<div class='erp-note'>Ask = prompt before scenes. Yes = consent. No = opt out.<br>\
	See ERP messages hides lewd chat within 7 tiles when off.<br>\
	Click SAVE in the character menu after changing settings.</div>"
	return dat

/datum/preferences/proc/show_erp_prefs_ui(mob/user)
	var/list/dat = print_erp_prefs_page()
	var/datum/browser/popup = new(user, "erp_prefs", "<div align='center'>ERP Preferences</div>", 420, 560)
	popup.set_content(dat.Join())
	popup.open(use_onclose = FALSE)

/datum/preferences/proc/handle_erp_prefs_topic(mob/user, href_list)
	switch(href_list["erp_task"])
		if("cycle")
			var/pref_id = href_list["pref_id"]
			var/use_ask_cycle = text2num(href_list["ask_cycle"])
			if(!get_erp_consent_pref_value(pref_id))
				return
			cycle_erp_consent_pref(pref_id, use_ask_cycle)
		if("toggle_verb_consent")
			toggles ^= VERB_CONSENT
		if("toggle_lewd_sounds")
			toggles ^= LEWD_VERB_SOUNDS
		if("toggle_ranged_consent")
			toggles ^= RANGED_VERBS_CONSENT
		if("toggle_arousable")
			arousable = !arousable
		if("toggle_arousal_multiplier")
			use_arousal_multiplier = !use_arousal_multiplier
		if("toggle_moaning_multiplier")
			use_moaning_multiplier = !use_moaning_multiplier
		if("set_arousal_multiplier")
			var/new_value = input(user, "Arousal multiplier (0-200%)", "ERP Preferences", arousal_multiplier) as num|null
			if(isnull(new_value))
				return
			arousal_multiplier = clamp(round(new_value), 0, 200)
		if("set_moaning_multiplier")
			var/new_value = input(user, "Moan chance (0-100%)", "ERP Preferences", moaning_multiplier) as num|null
			if(isnull(new_value))
				return
			moaning_multiplier = clamp(round(new_value), 0, 100)

/datum/preferences/proc/handle_erp_citadel_toggles(mob/user)
	var/new_toggles = input_bitfield(user, "ERP Mechanics", "citadel_toggles", cit_toggles, nheight = 520)
	if(!isnull(new_toggles))
		cit_toggles = new_toggles
