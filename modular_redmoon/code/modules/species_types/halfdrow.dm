/datum/species/human/halfelf
	possible_ages = NORMAL_AGES_LIST
	species_traits = list(NO_UNDERWEAR)
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_BREASTS = /obj/item/organ/genital/breasts,
		ORGAN_SLOT_BUTT = /obj/item/organ/genital/butt,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
		ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles,
		ORGAN_SLOT_BELLY = /obj/item/organ/genital/belly,
		ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
	)

	customizers = list(
		/datum/customizer/organ/ears/elf,
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/genital/penis,
		/datum/customizer/organ/genital/testicles,
		/datum/customizer/organ/genital/vagina,
		/datum/customizer/organ/genital/breasts,
		/datum/customizer/organ/genital/butt,
		/datum/customizer/organ/genital/belly,
		/datum/customizer/organ/genital/anus
	)
