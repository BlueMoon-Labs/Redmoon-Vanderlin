/datum/customizer/organ/neck_feature
	abstract_type = /datum/customizer/organ/neck_feature
	name = "Neck Feature"

/datum/customizer_choice/organ/neck_feature
	abstract_type = /datum/customizer_choice/organ/neck_feature
	name = "Neck Feature"
	organ_type = /obj/item/organ/neck_feature
	organ_slot = ORGAN_SLOT_NECK_FEATURE

/datum/customizer/organ/neck_feature/medicator
	customizer_choices = list(/datum/customizer_choice/organ/neck_feature/medicator)

/datum/customizer_choice/organ/neck_feature/medicator
	name = "Medicator Fluff"
	allows_accessory_color_customization = FALSE
	organ_type = /obj/item/organ/neck_feature/medicator
	sprite_accessories = list(
		/datum/sprite_accessory/neck_feature/fluff/medicator
	)

/datum/customizer/organ/neck_feature/moth
	customizer_choices = list(/datum/customizer_choice/organ/neck_feature/moth)

/datum/customizer_choice/organ/neck_feature/moth
	name = "Moth Fluff"
	allows_accessory_color_customization = TRUE
	organ_type = /obj/item/organ/neck_feature/moth
	sprite_accessories = list(
		/datum/sprite_accessory/neck_feature/moth_fluff/atlas,
		/datum/sprite_accessory/neck_feature/moth_fluff/deathhead,
		/datum/sprite_accessory/neck_feature/moth_fluff/firewatch,
		/datum/sprite_accessory/neck_feature/moth_fluff/gothic,
		/datum/sprite_accessory/neck_feature/moth_fluff/jungle,
		/datum/sprite_accessory/neck_feature/moth_fluff/lovers,
		/datum/sprite_accessory/neck_feature/moth_fluff/luna,
		/datum/sprite_accessory/neck_feature/moth_fluff/monarch,
		/datum/sprite_accessory/neck_feature/moth_fluff/moonfly,
		/datum/sprite_accessory/neck_feature/moth_fluff/oakworm,
		/datum/sprite_accessory/neck_feature/moth_fluff/plain,
		/datum/sprite_accessory/neck_feature/moth_fluff/poison,
	)
