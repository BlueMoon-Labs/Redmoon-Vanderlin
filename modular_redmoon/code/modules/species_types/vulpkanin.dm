/mob/living/carbon/human/species/vulpkanin
	race = /datum/species/vulpkanin

/datum/attribute_holder/sheet/job/species/vulpkanin
	raw_attribute_list = list(
		STAT_PERCEPTION = 1,
		STAT_INTELLIGENCE = 1,
		STAT_SPEED = 1,
	)

/datum/species/vulpkanin
	name = "Vulpkanin"
	id = SPEC_ID_VULPKANIN

	desc = "Based on the writings of the living Fietje von Zenitstadt: A subspecies of the more common \"Lupian\", found almost exclusively in thick forests.\
	They are usually shorter and meeker, but in turn more perceptive than their Volf-like brethren. \
	Their name is quite obvious, coming from the Venards they closely resemble. \
	Venardines are often much more solitary than Lupians, lacking the fervent pack mentality of their parent race. \
	To this dae, their origin is heavily disputed by few archivists across Psydonia - though the rest, perhaps for sanity's sake, consider them to be just Lupians.<br>\
	(+1 Perception, +1 Intelligence)"

	allowed_pronouns = PRONOUNS_LIST
	species_traits = list(EYECOLOR, HAIR, LIPS, STUBBLE, OLDGREY)
	use_skintones = TRUE
	liked_food = GROSS | MEAT | FRIED
	possible_ages = ALL_AGES_LIST
	changesource_flags = WABBAJACK
	species_traits = list(NO_UNDERWEAR)

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

	enflamed_icon = "widefire"

	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/vulpkanin,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_SNOUT = /obj/item/organ/snout/vulpkanin,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_TAIL = /obj/item/organ/tail/vulpkanin,
		ORGAN_SLOT_BREASTS = /obj/item/organ/genital/breasts,
		ORGAN_SLOT_BUTT = /obj/item/organ/genital/butt,
		ORGAN_SLOT_VAGINA = /obj/item/organ/genital/vagina,
	)

	bodypart_features = list(
		/datum/bodypart_feature/hair/head,
	)

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
		/datum/customizer/organ/snout/vulpkanin,
		/datum/customizer/organ/tail/vulpkanin,
		/datum/customizer/organ/genital/penis,
		/datum/customizer/organ/genital/testicles,
		/datum/customizer/organ/genital/vagina,
		/datum/customizer/organ/genital/breasts,
		/datum/customizer/organ/genital/butt,
		/datum/customizer/organ/genital/belly,
		/datum/customizer/organ/genital/anus
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

/datum/species/vulpkanin/check_roundstart_eligible()
	return TRUE

/datum/species/vulpkanin/get_skin_list()
    return list(
        "Arctic White"   = "fdf6ee",
        "Ivory"          = "f3e1ce",
        "Pale Cream"     = "f0d4a4",
        "Soft Ginger"    = "e48a45",
        "Bright Orange"  = "d86a2f",
        "Deep Fox Red"   = "b4471f",
        "Burnt Sienna"   = "934026",
        "Dark Brown"     = "3b261c",
        "Chocolate"      = "5a3724",
        "Sandy"          = "c89a67",
        "Golden Tan"     = "d4af7a",
        "Ash Grey"       = "9a9b96",
        "Silver Fox"     = "b8b9b3",
        "Black"          = "181310",
        "Copper"         = "c56232",
    )


/datum/species/vulpkanin/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	C.grant_language(/datum/language/common)
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))

/datum/species/vulpkanin/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
