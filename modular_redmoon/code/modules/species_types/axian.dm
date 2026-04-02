/mob/living/carbon/human/species/axian
	race = /datum/species/axian

/datum/species/axian
	name = "Axian"
	id = SPEC_ID_AXIAN
	native_language = "Deepspeak"

	desc = "<b>Axian</b><br>\
	Axians are a proud, shark-like people that have a heritage founded in maritime trade, \
	tax evasion, and piracy. They have a strong distaste for the nobility and taxation, \
	making them a target of discrimination in the Azurean lands. They are oftentimes scapegoats for crime. \
	Due to their penchant for trade and travel, they can be found all over the world, oftentimes \
	seeing places many could not even dream of. They look down at those they considered the 'settled' \
	and often uproot themselves quite often in their lifetimes. However, due to the isolation in Azure, many Axians \
	find their sanity being clawed away as they find themselves stuck in one place.<br>\
	(+1 Constitution, +1 Endurance)"
	allowed_pronouns = PRONOUNS_LIST
	species_traits = list(EYECOLOR, HAIR, LIPS, STUBBLE, OLDGREY)
	inherent_traits = list(TRAIT_WATER_BREATHING, TRAIT_FISHFACE, TRAIT_GOOD_SWIM)
	inherent_skills = list(
		/datum/attribute/skill/labor/fishing = 2,
		/datum/attribute/skill/misc/swimming = 3,
	)

	possible_ages = ALL_AGES_LIST
	use_skintones = TRUE
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
	specstats_m = list(STATKEY_STR = 0, STATKEY_PER = 0, STATKEY_INT = 0, STATKEY_CON = 1, STATKEY_END = 1, STATKEY_SPD = 0, STATKEY_LCK = 0)
	specstats_f = list(STATKEY_STR = 0, STATKEY_PER = 0, STATKEY_INT = 0, STATKEY_CON = 1, STATKEY_END = 1, STATKEY_SPD = 0, STATKEY_LCK = 0)

	enflamed_icon = "widefire"

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/akula,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/akula,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/axian,
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
		/datum/customizer/organ/snout/akula,
		/datum/customizer/organ/tail/axian,
		/datum/customizer/organ/ears/axian,
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

/datum/species/axian/check_roundstart_eligible()
	return TRUE

/datum/species/axian/get_skin_list()
	// Manually sorted please sort your new entries
	return list(
		"Algae Borne" = SKIN_COLOR_ALGAE,
		"Deep Borne" = SKIN_COLOR_DEEP,
		"Jellyfish Borne" = SKIN_COLOR_JELLYFISH,
		"kelp Borne" = SKIN_COLOR_KELP,
		"Reef Borne" = SKIN_COLOR_REEF,
		"Sand Borne" = SKIN_COLOR_SAND,
		"Shallow Borne" = SKIN_COLOR_SHALLOW,
		"Urchin Borne" = SKIN_COLOR_URCHIN,
	)

/datum/species/axian/get_possible_names(gender = MALE)
	var/static/list/male_names = file2list("strings/rt/names/axian/axianmale.txt")
	var/static/list/female_names = file2list("strings/rt/names/axian/axianfemale.txt")
	return (gender == FEMALE) ? female_names : male_names

/datum/species/axian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/deepspeak)

/datum/species/axian/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/deepspeak)
