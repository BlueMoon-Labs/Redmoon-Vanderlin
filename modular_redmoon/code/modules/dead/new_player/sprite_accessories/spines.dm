/datum/sprite_accessory/bm/spines
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)
	// mutant_part_string = "spines"

// /datum/sprite_accessory/bm/spines/is_not_visible(var/mob/living/carbon/human/H, var/tauric)
// 	return (!H.dna.features["spines"] || H.dna.features["spines"] == "None" || H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR))

/datum/sprite_accessory/bm/spines_animated
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER)

// /datum/sprite_accessory/bm/spines_animated/is_not_visible(var/mob/living/carbon/human/H, var/tauric)
// 	return ((!H.dna.features["spines"] || H.dna.features["spines"] == "None" || H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR)) || H.dna.species.mutant_bodyparts["tail"])

/datum/sprite_accessory/bm/spines/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/bm/spines_animated/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/bm/spines/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/bm/spines_animated/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/bm/spines/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/bm/spines_animated/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/bm/spines/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/bm/spines_animated/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/bm/spines/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/bm/spines_animated/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/bm/spines/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/bm/spines_animated/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"
