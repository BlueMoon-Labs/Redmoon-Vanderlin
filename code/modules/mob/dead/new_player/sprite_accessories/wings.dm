/datum/sprite_accessory/wings
	abstract_type = /datum/sprite_accessory/wings
	icon = 'icons/mob/sprite_accessory/wings/wings.dmi'
	color_key_name = "Wings"
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	/// Whether the sprite accessory has states for open wings (With an "_open" suffix).
	var/can_open = FALSE

/datum/sprite_accessory/wings/moth
	icon = 'icons/mob/sprite_accessory/wings/moth_wings.dmi'

/datum/sprite_accessory/wings/moth/atlas
	name = "Atlas"
	icon_state = "atlas"

/datum/sprite_accessory/wings/moth/brown
	name = "Brown"
	icon_state = "brown"

/datum/sprite_accessory/wings/moth/brown
	name = "Burnt_ff"
	icon_state = "burnt_off"

/datum/sprite_accessory/wings/moth/deathhead
	name = "Deathhead"
	icon_state = "deathhead"

/datum/sprite_accessory/wings/adjust_appearance_list(list/appearance_list, obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	generic_gender_feature_adjust(appearance_list, organ, bodypart, owner, OFFSET_BACK)

/datum/sprite_accessory/wings/get_icon_state(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	if(!owner || !can_open)
		return ..()
	var/obj/item/organ/wings/wings_organ = owner.getorganslot(ORGAN_SLOT_WINGS)
	if(!wings_organ || !wings_organ.is_open)
		return ..()
	return "[icon_state]_open"

#ifdef UNIT_TESTS

/datum/sprite_accessory/wings/unit_testing_icon_states(list/states)
	states += icon_state
	if(can_open)
		states += "[icon_state]_open"

#endif

/datum/sprite_accessory/wings/wide
	abstract_type = /datum/sprite_accessory/wings/wide
	icon = 'icons/mob/sprite_accessory/wings/wings_wide.dmi'
	pixel_x = -7

/datum/sprite_accessory/wings/huge
	abstract_type = /datum/sprite_accessory/wings/huge
	icon = 'icons/mob/sprite_accessory/wings/wings_huge.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_ADJ_LAYER, BODY_FRONT_LAYER)
	pixel_x = -32
	can_open = TRUE

/datum/sprite_accessory/wings/large
	abstract_type = /datum/sprite_accessory/wings/large
	icon = 'icons/mob/sprite_accessory/wings/wings_64x32.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)
	pixel_x = -16

/datum/sprite_accessory/wings/large/harpyswept
	name = "Harpy (Swept)"
	icon_state = "harpys"
	color_key_defaults = list(KEY_HAIR_COLOR)

/datum/sprite_accessory/wings/large/gargoyle
	name = "Gargoyle"
	icon_state = "gargoyle"
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER, BODY_ADJ_LAYER)
