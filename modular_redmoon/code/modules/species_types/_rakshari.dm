/datum/species/rakshari
	possible_ages = NORMAL_AGES_LIST
	species_traits = list(NO_UNDERWEAR)
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes/rakshari,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/rakshari,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
	)

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid/rakshari,
		/datum/customizer/bodypart_feature/hair/facial/humanoid/rakshari,
		/datum/customizer/bodypart_feature/accessory/rakshari,
		/datum/customizer/bodypart_feature/face_detail,
	)

