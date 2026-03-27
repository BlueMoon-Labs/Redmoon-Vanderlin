/datum/sprite_accessory/bm/frills
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mutant_bodyparts.dmi'
	relevant_layers = list(BODY_ADJ_LAYER)
	// mutant_part_string = "frills"

// /datum/sprite_accessory/bm/frills/is_not_visible(var/mob/living/carbon/human/H, var/tauric)
// 	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
// 	return (!H.dna.features["frills"] || H.dna.features["frills"] == "None" || H.head && (H.head.flags_inv & HIDEEARS) || !HD || HD.is_robotic_limb(FALSE))

/datum/sprite_accessory/bm/frills/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/bm/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/bm/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/bm/frills/short
	name = "Short"
	icon_state = "short"
