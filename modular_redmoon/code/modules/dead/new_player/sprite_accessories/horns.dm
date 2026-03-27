/datum/sprite_accessory/bm/horns
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mutant_bodyparts.dmi'
	color_src = HORNCOLOR
	relevant_layers = list(HORNS_LAYER)
	mutable_category = "HEAD"

// /datum/sprite_accessory/bm/horns/is_not_visible(var/mob/living/carbon/human/H, var/tauric)
// 	var/obj/item/bodypart/head/HD = H.get_bodypart(BODY_ZONE_HEAD)
// 	return (!H.dna.features["horns"] || H.dna.features["horns"] == "None" || H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.is_robotic_limb(FALSE))

/datum/sprite_accessory/bm/horns/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/bm/horns/curled
	name = "Curled"
	icon_state = "curled"

/datum/sprite_accessory/bm/horns/angler
	name = "Angeler"
	icon_state = "angler"
	color_src = MUTCOLORS

/datum/sprite_accessory/bm/horns/antler
	name = "Deer Antlers"
	icon_state = "deer"

/datum/sprite_accessory/bm/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/bm/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/bm/horns/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/bm/horns/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/bm/horns/teppy
	name = "Teppy (Tall)"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/32x64_mutant_bodyparts.dmi'
	icon_state = "teppy"

/datum/sprite_accessory/bm/horns/stag
	name = "Stag (Tall)"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/32x64_mutant_bodyparts.dmi'
	icon_state = "stag"
