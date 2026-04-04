/mob/living/carbon/human/species/moth
	race = /datum/species/moth

/datum/attribute_holder/sheet/job/species/moth
	raw_attribute_list = list(
		STAT_PERCEPTION = 1,
		STAT_INTELLIGENCE = 1,
		STAT_SPEED = 1,
	)

/datum/species/moth
	name = "Fluvian"
	id = SPEC_ID_MOTH
	desc = "Many comparisons have been made to the common moths in an attempt to describe this unique species. From the appetite for clothing to the disconcertingly insectoid appearance, the name 'Moth' is forever stamped onto the common vocabulary. The comparison, however, falls short on the matter of flight.<br>\
	(+1 Speed)"

	allowed_pronouns = PRONOUNS_LIST
	species_traits = list(EYECOLOR, HAIR, LIPS, STUBBLE, OLDGREY)
	use_skintones = TRUE

	possible_ages = ALL_AGES_LIST
	use_skintones = TRUE
	changesource_flags = WABBAJACK

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/moth_male.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/moth_female.dmi'
	dam_icon_m = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female
	offset_features_m = list(
		OFFSET_RING = list(0,0),\
		OFFSET_GLOVES = list(0,0),\
		OFFSET_WRISTS = list(0,0),\
		OFFSET_HANDS = list(0,0),\
		OFFSET_CLOAK = list(0,0),\
		OFFSET_FACEMASK = list(0,0),\
		OFFSET_HEAD = list(0,0),\
		OFFSET_FACE = list(0,0),\
		OFFSET_BELT = list(0,0),\
		OFFSET_BACK = list(0,0),\
		OFFSET_NECK = list(0,0),\
		OFFSET_MOUTH = list(0,0),\
		OFFSET_PANTS = list(0,0),\
		OFFSET_SHIRT = list(0,0),\
		OFFSET_ARMOR = list(0,0),\
		OFFSET_UNDIES = list(0,0),\
	)
	offset_features_f = list(
		OFFSET_RING = list(0,-1),\
		OFFSET_GLOVES = list(0,0),\
		OFFSET_WRISTS = list(0,0),\
		OFFSET_HANDS = list(0,0),\
		OFFSET_CLOAK = list(0,0),\
		OFFSET_FACEMASK = list(0,-1),\
		OFFSET_HEAD = list(0,-1),\
		OFFSET_FACE = list(0,-1),\
		OFFSET_BELT = list(0,0),\
		OFFSET_BACK = list(0,-1),\
		OFFSET_NECK = list(0,-1),\
		OFFSET_MOUTH = list(0,-1),\
		OFFSET_PANTS = list(0,0),\
		OFFSET_SHIRT = list(0,0),\
		OFFSET_ARMOR = list(0,0),\
		OFFSET_UNDIES = list(0,0),\
	)

	enflamed_icon = "widefire"

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/moth,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_NECK_FEATURE = /obj/item/organ/neck_feature/moth,
		ORGAN_SLOT_WINGS = /obj/item/organ/wings/moth,
		ORGAN_SLOT_BUTT = /obj/item/organ/genital/butt,
		ORGAN_SLOT_BELLY = /obj/item/organ/genital/belly,
		ORGAN_SLOT_ANUS = /obj/item/organ/genital/anus,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
		ORGAN_SLOT_WOMB = /obj/item/organ/genital/womb,
		ORGAN_SLOT_PENIS = /obj/item/organ/genital/penis,
		ORGAN_SLOT_TESTICLES = /obj/item/organ/genital/testicles
	)

	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
	)

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/ears/moth,
		/datum/customizer/organ/neck_feature/moth,
		/datum/customizer/organ/wings/moth
		)

	body_marking_sets = list(
		/datum/body_marking_set/none,
		/datum/body_marking_set/belly,
		/datum/body_marking_set/tiger,
		/datum/body_marking_set/tiger_dark,
	)

	body_markings = list(
		/datum/body_marking/tonage
	)

/datum/species/moth/check_roundstart_eligible()
	return TRUE

/datum/species/moth/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/moth/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
