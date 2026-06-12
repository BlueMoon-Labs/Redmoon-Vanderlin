/datum/customizer/organ/wings/moth
	customizer_choices = list(/datum/customizer_choice/organ/wings/moth)
	allows_disabling = FALSE

/datum/customizer_choice/organ/wings/moth
	name = "Moth wings"
	organ_type = /obj/item/organ/wings/moth
	allows_accessory_color_customization = FALSE
	sprite_accessories = list(
		/datum/sprite_accessory/wings/moth/atlas,
		/datum/sprite_accessory/wings/moth/brown,
		/datum/sprite_accessory/wings/moth/deathhead,
	)

/obj/item/organ/wings/moth
	name = "Moth wings"
	accessory_type = /datum/sprite_accessory/wings/moth/brown
