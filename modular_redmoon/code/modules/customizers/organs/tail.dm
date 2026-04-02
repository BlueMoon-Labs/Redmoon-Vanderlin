/datum/sprite_accessory/tail
	color_key_defaults = list(KEY_SKIN_COLOR)

/datum/customizer/organ/tail/axian
	customizer_choices = list(/datum/customizer_choice/organ/tail/axian)
	allows_disabling = FALSE

/datum/customizer_choice/organ/tail/axian
	name = "Axian Tail"
	organ_type = /obj/item/organ/tail/axian
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/tail/sharknofin,
		/datum/sprite_accessory/tail/shark,
		/datum/sprite_accessory/bm/tails/orca)

/obj/item/organ/tail/axian
	name = "Axian tail"
	accessory_type = /datum/sprite_accessory/tail/shark

/datum/customizer/organ/tail/lupian
	customizer_choices = list(/datum/customizer_choice/organ/tail/lupian)
	allows_disabling = FALSE

/datum/customizer_choice/organ/tail/lupian
	name = "Lupian tail"
	organ_type = /obj/item/organ/tail/lupian
	sprite_accessories = list(
		/datum/sprite_accessory/tail/wolf,
		/datum/sprite_accessory/tail/husky)

/obj/item/organ/tail/lupian
	name = "Lupian tail"
	accessory_type = /datum/sprite_accessory/tail/wolf

/datum/customizer/organ/tail/vulpkanin
	customizer_choices = list(/datum/customizer_choice/organ/tail/vulpkanin)
	allows_disabling = FALSE

/datum/customizer_choice/organ/tail/vulpkanin
	name = "Vulpkanin tail"
	organ_type = /obj/item/organ/tail/vulpkanin
	sprite_accessories = list(
		/datum/sprite_accessory/tail/fox,
		/datum/sprite_accessory/tail/wolf,
		/datum/sprite_accessory/bm/tails/human/husky,
		)

/obj/item/organ/tail/vulpkanin
	name = "Vulpkanin tail"
	accessory_type = /datum/sprite_accessory/tail/fox

/datum/customizer/organ/tail/tabaxi
	customizer_choices = list(/datum/customizer_choice/organ/tail/tabaxi)
	allows_disabling = FALSE

/datum/customizer_choice/organ/tail/tabaxi
	name = "Tabaxi tail"
	organ_type = /obj/item/organ/tail/tabaxi
	sprite_accessories = list(
		/datum/sprite_accessory/tail/catbig,
		/datum/sprite_accessory/tail/tiger,
		/datum/sprite_accessory/tail/leopard,
		/datum/sprite_accessory/tail/fox,
		/datum/sprite_accessory/tail/wolf,
	)

/obj/item/organ/tail/tabaxi
	name = "Tabaxi tail"
	accessory_type = /datum/sprite_accessory/tail/catbig

/datum/customizer/organ/tail/dracon
	customizer_choices = list(/datum/customizer_choice/organ/tail/dracon)
	allows_disabling = FALSE

/datum/customizer_choice/organ/tail/dracon
	name = "Dracon tail"
	organ_type = /obj/item/organ/tail/dracon
	sprite_accessories = list(
		/datum/sprite_accessory/tail/lizard/smooth,
	)

/obj/item/organ/tail/dracon
	name = "Dracon tail"
	accessory_type = /datum/sprite_accessory/tail/lizard/smooth
