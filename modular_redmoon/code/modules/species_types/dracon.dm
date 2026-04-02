/mob/living/carbon/human/species/dracon
	race = /datum/species/dracon

/datum/species/dracon
	name = "Drakian"
	id = SPEC_ID_DRACON
	desc = "<b>Drakian</b><br>\
	Mighty scaled individuals who claim to be descendants of the dragons of yore.<br>\
	(+1 Strength)"

	allowed_pronouns = PRONOUNS_LIST
	use_skintones = TRUE
	species_traits = list(EYECOLOR, HAIR, LIPS, STUBBLE, OLDGREY)
	possible_ages = ALL_AGES_LIST
	changesource_flags = WABBAJACK

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
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
	specstats_m = list(STATKEY_STR = 1, STATKEY_PER = 0, STATKEY_INT = 0, STATKEY_CON = 0, STATKEY_END = 0, STATKEY_SPD = 0, STATKEY_LCK = 0)
	specstats_f = list(STATKEY_STR = 1, STATKEY_PER = 0, STATKEY_INT = 0, STATKEY_CON = 0, STATKEY_END = 0, STATKEY_SPD = 0, STATKEY_LCK = 0)

	enflamed_icon = "widefire"

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/dracon,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/dracon,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/dracon,
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
		/datum/customizer/organ/snout/dracon,
		/datum/customizer/organ/tail/dracon,
		/datum/customizer/organ/ears/dracon,
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

/datum/species/dracon/check_roundstart_eligible()
	return TRUE

/datum/species/dracon/get_skin_list()
    return list(
        "Pale Sand"      = "f2e0c8",
        "Bone"           = "e6d7c3",
        "Olive Green"    = "6b8e23",
        "Moss Green"     = "4f6d1f",
        "Forest Green"   = "2f4f1f",
        "Deep Emerald"   = "1d4f3b",
        "Slate Blue"     = "4a607f",
        "Midnight Blue"  = "1c2338",
        "Charcoal"       = "2b2b30",
        "Ash Grey"       = "8b8f96",
        "Rust Red"       = "b3482f",
        "Crimson"        = "8b0000",
        "Bronze"         = "a66a33",
        "Desert Tan"     = "c49a6c",
        "Stone"          = "7b6f60",
    )

/datum/species/dracon/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/dracon/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
