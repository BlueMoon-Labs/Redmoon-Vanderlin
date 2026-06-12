//Preferences stuff
	//Hairstyles
GLOBAL_LIST_EMPTY(hair_styles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hair_styles_male_list)		//stores only hair names
GLOBAL_LIST_EMPTY(hair_styles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hair_styles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
GLOBAL_LIST_EMPTY(facial_hair_styles_male_list)	//stores only hair names
GLOBAL_LIST_EMPTY(facial_hair_styles_female_list)	//stores only hair names
GLOBAL_LIST_EMPTY(hair_gradients_list) //stores /datum/sprite_accessory/hair_gradient indexed by name
	//Lizard Bits (all datum lists indexed by name)
GLOBAL_LIST_EMPTY(tails_list_lizard)
GLOBAL_LIST_EMPTY(animated_tails_list_lizard)
GLOBAL_LIST_EMPTY(snouts_list)
GLOBAL_LIST_EMPTY(horns_list)
GLOBAL_LIST_EMPTY(frills_list)
GLOBAL_LIST_EMPTY(spines_list)
GLOBAL_LIST_EMPTY(legs_list)
GLOBAL_LIST_EMPTY(animated_spines_list)

	//Mutant Human bits
GLOBAL_LIST_EMPTY(tails_list_human)
GLOBAL_LIST_EMPTY(animated_tails_list_human)
GLOBAL_LIST_EMPTY(ears_list)
GLOBAL_LIST_EMPTY(wings_list)
GLOBAL_LIST_EMPTY(wings_open_list)
GLOBAL_LIST_EMPTY(deco_wings_list)
GLOBAL_LIST_EMPTY(r_wings_list)
GLOBAL_LIST_EMPTY(insect_wings_list)
GLOBAL_LIST_EMPTY(insect_fluffs_list)
GLOBAL_LIST_EMPTY(insect_markings_list)
GLOBAL_LIST_EMPTY(arachnid_legs_list)
GLOBAL_LIST_EMPTY(arachnid_spinneret_list)
GLOBAL_LIST_EMPTY(arachnid_mandibles_list)
GLOBAL_LIST_EMPTY(caps_list)

GLOBAL_LIST_EMPTY(mam_body_markings_list)
GLOBAL_LIST_EMPTY(mam_ears_list)
GLOBAL_LIST_EMPTY(mam_tails_list)
GLOBAL_LIST_EMPTY(mam_tails_animated_list)
GLOBAL_LIST_EMPTY(taur_list)
GLOBAL_LIST_EMPTY(mam_snouts_list)

//a way to index the right bodypart list given the type of bodypart
GLOBAL_LIST_INIT(mutant_reference_list, list(
	"tail_lizard" = GLOB.tails_list_lizard,
	"waggingtail_lizard" = GLOB.animated_tails_list_lizard,
	"tail_human" = GLOB.tails_list_human,
	"waggingtail_human" = GLOB.animated_tails_list_human,
	"spines" = GLOB.spines_list,
	"waggingspines" = GLOB.animated_spines_list,
	"snout" = GLOB.snouts_list,
	"frills" = GLOB.frills_list,
	"horns" = GLOB.horns_list,
	"ears" = GLOB.ears_list,
	"wings" = GLOB.wings_list,
	"wingsopen" = GLOB.wings_open_list,
	"deco_wings" = GLOB.deco_wings_list,
	"legs" = GLOB.legs_list,
	"insect_wings" = GLOB.insect_wings_list,
	"insect_fluff" = GLOB.insect_fluffs_list,
	"insect_markings" = GLOB.insect_markings_list,
	"arachnid_legs" = GLOB.arachnid_legs_list,
	"arachnid_spinneret" = GLOB.arachnid_spinneret_list,
	"arachnid_mandibles" = GLOB.arachnid_mandibles_list,
	"caps" = GLOB.caps_list,
	"mam_tail" = GLOB.mam_tails_list,
	"mam_waggingtail" = GLOB.mam_tails_animated_list,
	"mam_body_markings" = GLOB.mam_body_markings_list,
	"mam_ears" = GLOB.mam_ears_list,
	"mam_snouts" = GLOB.mam_snouts_list,
	"taur" = GLOB.taur_list))

//references wag types to regular types, wings open to wings, etc
GLOBAL_LIST_INIT(mutant_transform_list, list("wingsopen" = "wings",
	"waggingtail_human" = "tail_human",
	"waggingtail_lizard" = "tail_lizard",
	"waggingspines" = "spines",
	"mam_waggingtail" = "mam_tail"))

GLOBAL_LIST_EMPTY(bm_hair_paths)
GLOBAL_LIST_EMPTY(bm_tails_lizard)
GLOBAL_LIST_EMPTY(bm_tails_lizard_animated)
GLOBAL_LIST_EMPTY(cock_shapes_list_paths)
