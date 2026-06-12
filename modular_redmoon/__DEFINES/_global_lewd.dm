
#define GENITAL_BLACKLISTED		(1<<0) //for genitals that shouldn't be added to GLOB.genitals_list.
#define GENITAL_INTERNAL		(1<<1)
#define GENITAL_HIDDEN			(1<<2)
#define GENITAL_THROUGH_CLOTHES	(1<<3)
#define GENITAL_FUID_PRODUCTION	(1<<4)
#define CAN_MASTURBATE_WITH		(1<<5)
#define MASTURBATE_LINKED_ORGAN	(1<<6) //used to pass our mission to the linked organ
#define CAN_CLIMAX_WITH			(1<<7)
#define GENITAL_CAN_AROUSE		(1<<8)
#define GENITAL_UNDIES_HIDDEN	(1<<9)
#define UPDATE_OWNER_APPEARANCE	(1<<10)
#define GENITAL_CAN_TAUR		(1<<11)
#define CAN_CUM_INTO 			(1<<12) //Sandstorm change
#define HAS_EQUIPMENT			(1<<13) //nother sandstorm change
#define GENITAL_CAN_STUFF       (1<<14) //Splurt edit, used for pregnancy
#define GENITAL_CHASTENED		(1<<15) //SPLURT edit
#define GENITAL_IMPOTENT		(1<<16) //SPLURT edit
#define GENITAL_EDGINGONLY		(1<<17) //SPLURT edit
#define GENITAL_DISAPPOINTING	(1<<18)	//SPLURT edit
#define GENITAL_OVERSTIM		(1<<19) //SPLURT edit
#define GENITAL_HYPERSENS		(1<<20) //SPLURT edit



#define TRAIT_CHASTENED_ANUS "chastened_anus"
#define TRAIT_IMPOTENT_ANUS "impotent_anus"
#define TRAIT_EDGINGONLY_ANUS "edgingonly_anus"
#define TRAIT_DISAPPOINTING_ANUS "disappointing_anus"
#define TRAIT_OVERSTIM_ANUS "overstim_anus"
#define TRAIT_HYPERSENS_ANUS "hypersens_anus"

#define LOG_VICTIM		(1 << 19)
#define COMSIG_MOB_LUST_UPDATED "mob_lust_updated"
#define isbelly(A) istype(A, /obj/belly)
GLOBAL_LIST_INIT(lust_modifiers, list("[GENITAL_HYPERSENS]" = 3, "[GENITAL_OVERSTIM]" = 1.8, "[GENITAL_DISAPPOINTING]" = 0.75, "[GENITAL_EDGINGONLY]" = 0.5, "[GENITAL_IMPOTENT]" = 0))
GLOBAL_LIST_INIT(anus_traits, list("[TRAIT_HYPERSENS_ANUS]" = 3, "[TRAIT_OVERSTIM_ANUS]" = 1.8, "[TRAIT_DISAPPOINTING_ANUS]" = 0.75, "[TRAIT_EDGINGONLY_ANUS]" = 0.5, "[TRAIT_IMPOTENT_ANUS]" = 0))

GLOBAL_LIST_INIT(breast_nouns, list("грудь", "сиськи", "сферы", "титьки", "бюст", "вымя", "буфера", "молочные ёмкости")) //Yeah I need help coming up with better names

GLOBAL_LIST_INIT(balls_nouns, list("шары", "яйца", "семенники", "орехи", "яичники", "держатели семени", "сферы с семенем", "канистры с семенем", "семенные маслобойники", "шарики для битья", "сферы для битья", "канистры для битья", "маслобойники для битья"))

GLOBAL_LIST_INIT(butt_nouns, list("попа", "попка", "жопа", "задница", "ягодицы", "срака", "бампер", "попец"))

GLOBAL_LIST_INIT(breast_values, list("плоского" = 0, "a" =  1, "b" = 2, "c" = 3, "d" = 4, "e" = 5, "f" = 6, "g" = 7, "h" = 8, "i" = 9, "j" = 10, "k" = 11, "l" = 12, "m" = 13, "n" = 14, "o" = 15, "huge" = 16, "massive" = 17, "giga" = 25, "impossible" = 30))

/obj/belly
	name = "belly"
	desc = "It's a belly"

// ==============================
// Описания каким органом ты трахаешь (BlueMoon Add)
// ==============================

/proc/get_penis_shape_desc(mob/living/carbon/human/H)
	var/obj/item/organ/genital/penis/P = H?.getorganslot(ORGAN_SLOT_PENIS)
	if(!P)
		return "член"

	var/datum/sprite_accessory/S = GLOB.cock_shapes_list[P.shape]
	var/lowershape = lowertext(S?.icon_state || P.shape)

	switch(lowershape)
		if("penis", "human") return "член"
		if("knotted") return "узловатый член"
		if("flared") return "конический член"
		if("barbknot") return "узловатый шипованный член"
		if("tapered") return "утончённый член"
		if("tentacle") return "тентяклевидный член"
		if("taperedteshari") return "тешарьский член"
		if("taperedbarbed") return "утонченный шипованный член"
		if("thick", "nondescript") return "обрезанный член"
		// Если кто-то это будет трогать, придумайте что-то с окончаниями (автор не соизволил)
		if("hemi") return "двойные члены"
		if("hemiknot") return "двойные узловатые члены"
		if("bhemiknot") return "двойные с узлами колючие члены"

		else return "необычной формы член"
