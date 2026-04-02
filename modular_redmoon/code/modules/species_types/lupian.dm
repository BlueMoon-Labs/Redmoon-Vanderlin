/mob/living/carbon/human/species/lupian
	race = /datum/species/lupian

/datum/species/lupian
	name = "Lupian"
	id = SPEC_ID_LUPIAN

	desc = "<b>Lupian</b><br>\
	As written by an Archivist from times before yours: Lupians, known by many as Volfmen, are a very prominent type of Beastkin that is easily found all across Psydonia. \
	They are oft tall and slim, carrying with them a coat of discoloured short or medium length fur. \
	Their bodies are naturally resilient and their minds as sharp as a Humen's own. \
	A Lupian will usually display loyalty to a fault, as they are quite factional beings. \
	Tales of old claim that they came to be when Noc stole Dendor’s curse to create lyfe of his own in an attempt to replicate Psydon’s, instead giving birth to a flawed beast-people.<br>\
	(+1 Constitution, +1 Intelligence)"

	allowed_pronouns = PRONOUNS_LIST
	species_traits = list(EYECOLOR, HAIR, LIPS, STUBBLE, OLDGREY)

	liked_food = GROSS | MEAT | FRIED
	use_skintones = TRUE
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
	specstats_m = list(STATKEY_STR = 0, STATKEY_PER = 0, STATKEY_INT = 1, STATKEY_CON = 1, STATKEY_END = 0, STATKEY_SPD = 0, STATKEY_LCK = 0)
	specstats_f = list(STATKEY_STR = 0, STATKEY_PER = 0, STATKEY_INT = 1, STATKEY_CON = 1, STATKEY_END = 0, STATKEY_SPD = 0, STATKEY_LCK = 0)

	enflamed_icon = "widefire"

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/lupian,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/lupian,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/lupian,
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
		/datum/customizer/organ/snout/lupian,
		/datum/customizer/organ/tail/lupian,
		/datum/customizer/organ/ears/lupian,
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

/datum/species/lupian/check_roundstart_eligible()
	return TRUE

/datum/species/lupian/get_skin_list()
    return list(
        "Snow"           = "f8f5f2",
        "Off White"      = "ede3d6",
        "Cream"          = "e2cfae",
        "Silver"         = "c0c4c8",
        "Light Grey"     = "a8aa97",
        "Steel Grey"     = "7a7f80",
        "Dark Grey"      = "4b5054",
        "Charcoal"       = "2c2f33",
        "Brown"          = "6b4a2b",
        "Dark Brown"     = "3b2e27",
        "Reddish Brown"  = "8b4a2f",
        "Golden Brown"   = "b98244",
        "Black"          = "1a1512",
        "Cream Saddle"   = "d8c3a0",
        "Dusty Tan"      = "b79a7a",
    )


/datum/species/lupian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/lupian/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
