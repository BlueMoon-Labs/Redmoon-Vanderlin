/datum/customizer/organ/snout
	abstract_type = /datum/customizer/organ/snout
	name = "Snout"

/datum/customizer_choice/organ/snout
	abstract_type = /datum/customizer_choice/organ/snout
	name = "Snout"
	organ_type = /obj/item/organ/snout
	organ_slot = ORGAN_SLOT_SNOUT

/datum/customizer/organ/snout/beak
	name = "Beak"
	customizer_choices = list(/datum/customizer_choice/organ/snout/beak)

/datum/customizer_choice/organ/snout/beak
	name = "Beak"
	organ_type = /obj/item/organ/snout/beak
	sprite_accessories = list(
		/datum/sprite_accessory/snout/bird,
		/datum/sprite_accessory/snout/bigbeak,
		/datum/sprite_accessory/snout/bigbeakshort,
		/datum/sprite_accessory/snout/slimbeak,
		/datum/sprite_accessory/snout/slimbeakshort,
		/datum/sprite_accessory/snout/slimbeakalt,
		/datum/sprite_accessory/snout/hookbeak,
		/datum/sprite_accessory/snout/hookbeakbig,
	)

/datum/customizer/organ/snout/beak/thin
	name = "Thin Beak"
	customizer_choices = list(/datum/customizer_choice/organ/snout/beak/thin)

/datum/customizer_choice/organ/snout/beak/thin
	name = "Thin Beak"
	organ_type = /obj/item/organ/snout/beak
	allows_accessory_color_customization = FALSE
	default_accessory = /datum/sprite_accessory/snout/thin_beak/slimbeak
	sprite_accessories = list(
		/datum/sprite_accessory/snout/thin_beak/bigbeak,
		/datum/sprite_accessory/snout/thin_beak/bigbeakshort,
		/datum/sprite_accessory/snout/thin_beak/slimbeak,
		/datum/sprite_accessory/snout/thin_beak/slimbeakshort,
		/datum/sprite_accessory/snout/thin_beak/slimbeakalt,
		/datum/sprite_accessory/snout/thin_beak/hookbeak,
		/datum/sprite_accessory/snout/thin_beak/hookbeakbig,
	)

/datum/customizer/organ/snout/akula
	customizer_choices = list(/datum/customizer_choice/organ/snout/akula)
	allows_disabling = FALSE

/datum/customizer_choice/organ/snout/akula
	name = "Axian snout"
	organ_type = /obj/item/organ/snout/akula
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/snout/shark,
		/datum/sprite_accessory/snout/sharp,
	)

/datum/customizer/organ/snout/lupian
	customizer_choices = list(/datum/customizer_choice/organ/snout/lupian)
	allows_disabling = FALSE

/datum/customizer_choice/organ/snout/lupian
	name = "Lupian snout"
	organ_type = /obj/item/organ/snout/lupian
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/snout/vulp,
		/datum/sprite_accessory/snout/husky,
		/datum/sprite_accessory/snout/wolf,
		/datum/sprite_accessory/snout/wolfalt,
		/datum/sprite_accessory/snout/hspots,
	)

/datum/customizer/organ/snout/vulpkanin
	customizer_choices = list(/datum/customizer_choice/organ/snout/vulpkanin)
	allows_disabling = FALSE

/datum/customizer_choice/organ/snout/vulpkanin
	name = "Vulpkanin snout"
	organ_type = /obj/item/organ/snout/vulpkanin
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/snout/vulp,
		/datum/sprite_accessory/snout/husky,
		/datum/sprite_accessory/snout/wolf
	)

/datum/customizer/organ/snout/tabaxi
	customizer_choices = list(/datum/customizer_choice/organ/snout/tabaxi)
	allows_disabling = FALSE

/datum/customizer_choice/organ/snout/tabaxi
	name = "Tabaxi snout"
	organ_type = /obj/item/organ/snout/tabaxi
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/snout/cat,
		/datum/sprite_accessory/snout/tajaran
	)

/datum/customizer/organ/snout/dracon
	customizer_choices = list(/datum/customizer_choice/organ/snout/dracon)
	allows_disabling = FALSE

/datum/customizer_choice/organ/snout/dracon
	name = "Dracon snout"
	organ_type = /obj/item/organ/snout/dracon
	generic_random_pick = TRUE
	sprite_accessories = list(
		/datum/sprite_accessory/snout/sharp,
		/datum/sprite_accessory/snout/sharplight
	)
