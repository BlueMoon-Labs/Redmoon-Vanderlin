/// Genital slots that must only appear when explicitly enabled in ERP/customizer prefs.
var/static/list/genital_organ_slots = list(
	ORGAN_SLOT_BREASTS,
	ORGAN_SLOT_BUTT,
	ORGAN_SLOT_VAGINA,
	ORGAN_SLOT_PENIS,
	ORGAN_SLOT_TESTICLES,
	ORGAN_SLOT_BELLY,
	ORGAN_SLOT_ANUS,
)

/datum/species/regenerate_organs(mob/living/carbon/C, datum/species/old_species, replace_current = TRUE, list/excluded_zones, datum/preferences/pref_load)
	var/list/prior_optional = optional_organ_slots?.Copy() || list()
	var/list/extra_optional = list()
	for(var/slot in genital_organ_slots)
		if(slot in organs)
			extra_optional += slot
	if(length(extra_optional))
		optional_organ_slots = prior_optional | extra_optional
	. = ..()
	optional_organ_slots = prior_optional

/datum/preferences/apply_customizers_to_character(mob/living/carbon/human/human)
	. = ..()
	for(var/datum/customizer_entry/entry as anything in customizer_entries)
		if(!entry.disabled || !istype(entry, /datum/customizer_entry/organ/genital))
			continue
		var/datum/customizer_choice/customizer_choice = CUSTOMIZER_CHOICE(entry.customizer_choice_type)
		var/datum/customizer/customizer = CUSTOMIZER(entry.customizer_type)
		if(!customizer.is_allowed(src))
			continue
		customizer_choice.apply_customizer_to_character(human, src, entry)
