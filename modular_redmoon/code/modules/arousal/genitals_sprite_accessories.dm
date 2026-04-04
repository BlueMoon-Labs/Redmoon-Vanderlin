/datum/customizer/organ/penis
	customizer_choices = list(/datum/customizer_choice/organ/penis)
	allows_disabling = TRUE

/datum/customizer_choice/organ/penis
	name = "Член"
	organ_type = /obj/item/organ/genital/penis

/datum/sprite_accessory
	var/alt_aroused = FALSE //CIT CODE if this is TRUE, then the genitals will use an alternate icon_state when aroused.
	var/taur_icon //leave null if the genital doesn't have a taur counterpart.
	var/accepted_taurs = STYLE_HOOF_TAURIC|STYLE_PAW_TAURIC //Types that match with the accessory.
	var/feat_taur //the text string of the dna feature to check for those who want to opt out.
	var/taur_dimension_y = 32
	var/taur_dimension_x = 32

/*
 * This is an example of a penis object in the code.
 * The icon_state of the penis is structured as follows:
 * "penis_human_4_1_FRONT"
 * Where "human" is the type of the penis, "4" is the size stage of the penis, and "1" means it's the erect sprite, while "0" would be the soft one.
 * If the sprite is like this: "penis_human_4_s_1_FRONT", the extra "_s" means it's used by the default skintones (the list of default skin tones that "Albino, Caucasian, etc.").
 * Those "_s" sprites use a more pink-ish tone instead of white, to match the different default skin tones automatically,
 * while the icon states without the "_s" are used by the custom skin tone.
 * In the future, it would be best to solve this, as it creates useless duplicated icon states, and therefore heavier file sizes.
 * It would be best to just have 1 set of icon states that apply themselves normally to both custom skin tone users and match default skin tone users,
 * effectively removing the need of using the extra "_s". - Goku
 */

/datum/sprite_accessory/bm
	var/color_src

//DICKS,COCKS,PENISES,WHATEVER YOU WANT TO CALL THEM
/datum/sprite_accessory/bm/penis
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob.dmi'
	name = "penis"			//the preview name of the accessory
	color_src = "cock_color"
	alt_aroused = TRUE
	feat_taur = "cock_taur"
	var/ru_name = "человеческий"

/datum/sprite_accessory/bm/penis/human
	icon_state = "human"
	name = "Human"
	ru_name = "человеческий"

/datum/sprite_accessory/bm/penis/human_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "human"
	name = "Human (New Tg)"
	ru_name = "человеческий"

/datum/sprite_accessory/bm/penis/knotted
	icon_state = "knotted"
	name = "Knotted"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	taur_dimension_x = 64
	ru_name = "узловатый"

/datum/sprite_accessory/bm/penis/knotted_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "knotted"
	name = "Knotted (New Tg)"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	taur_dimension_x = 64
	ru_name = "узловатый"

/datum/sprite_accessory/bm/penis/flared
	icon_state = "flared"
	name = "Flared"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	taur_dimension_x = 64
	ru_name = "конический"

/datum/sprite_accessory/bm/penis/flared_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "flared"
	name = "Flared (New Tg)"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	taur_dimension_x = 64
	ru_name = "конический"

/datum/sprite_accessory/bm/penis/barbknot

	icon_state = "barbknot"
	name = "Barbed, Knotted"
	ru_name = "узловатый и немного колючий"

/datum/sprite_accessory/bm/penis/barbknot_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "barbknot"
	name = "Barbed, Knotted (New Tg)"
	ru_name = "узловатый и немного колючий"

/datum/sprite_accessory/bm/penis/tapered
	icon_state = "tapered"
	name = "Tapered"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	taur_dimension_x = 64
	ru_name = "утончённый к концу"

/datum/sprite_accessory/bm/penis/tapered_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "tapered"
	name = "Tapered (New Tg)"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	taur_dimension_x = 64
	ru_name = "утончённый к концу"

/datum/sprite_accessory/bm/penis/taperedbarbed
	icon_state = "barbtapered"
	name = "Tapered Barbed"
	taur_icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/taur_penis_onmob.dmi'
	ru_name = "утончённый к концу и покрыт шипами"

/datum/sprite_accessory/bm/penis/tentacle
	icon_state = "tentacle"
	name = "Tentacled"
	ru_name = "тентяклевидный"

/datum/sprite_accessory/bm/penis/tentacle_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "tentacle"
	name = "Tentacled (New Tg)"
	ru_name = "тентяклевидный"

/datum/sprite_accessory/bm/penis/hemi
	icon_state = "hemi"
	name = "Hemi"
	ru_name = "двойной"

/datum/sprite_accessory/bm/penis/hemi_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "hemi"
	name = "Hemi (New Tg)"
	ru_name = "двойной"

/datum/sprite_accessory/bm/penis/hemiknot
	icon_state = "hemiknot"
	name = "Knotted Hemi"
	ru_name = "двойной узловатый"

/datum/sprite_accessory/bm/penis/hemiknot_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "hemiknot"
	name = "Knotted Hemi (New Tg)"
	ru_name = "двойной узловатый"

/datum/sprite_accessory/bm/penis/barbedhemiknot
	icon_state = "bhemiknot"
	name = "Barbed, Knotted Hemi"
	ru_name = "двойной, узловатый и немного колючий"

/datum/sprite_accessory/bm/penis/thick
	icon_state = "thick"
	name = "Thick"
	ru_name = "обрезанный"

/datum/sprite_accessory/bm/penis/nondescript
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/penis_onmob (2).dmi'
	icon_state = "nondescript"
	name = "Thick (New Tg)"
	ru_name = "обрезанный"

//Testicles
/datum/sprite_accessory/bm/testicles
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/testicles_onmob.dmi'
	icon_state = "testicle"
	name = "testicle"		//the preview name of the accessory
	color_src = "balls_color"

/datum/sprite_accessory/bm/testicles/single
	icon_state = "single"
	name = "Single" //Single as "single pair", for clarity.

/datum/sprite_accessory/bm/testicles/single_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/testicles_onmob (2).dmi'
	icon_state = "single"
	name = "Single (New Tg)"

/datum/sprite_accessory/bm/testicles/hidden
	icon_state = "hidden"
	name = "Hidden" //not sure why these were missing, but I'm pretty certain people might want these.

/datum/sprite_accessory/bm/testicles/sheath
	icon_state = "sheath"
	name = "Sheath"

/datum/sprite_accessory/bm/testicles/sheath_new
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/testicles_onmob (2).dmi'
	icon_state = "sheath"
	name = "Sheath (New Tg)"

//Vaginas
/datum/sprite_accessory/bm/vagina
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/vagina_onmob.dmi'
	name = "vagina"
	color_src = "vag_color"
	alt_aroused = TRUE

/datum/sprite_accessory/bm/vagina/human
	icon_state = "human"
	name = "Human"

/datum/sprite_accessory/bm/vagina/tentacles
	icon_state = "tentacle"
	name = "Tentacle"

/datum/sprite_accessory/bm/vagina/dentata
	icon_state = "dentata"
	name = "Dentata"

/datum/sprite_accessory/bm/vagina/hairy //BlueMoon Edit
	icon_state = "hairy"
	name = "Hairy"

/datum/sprite_accessory/bm/vagina/spade //BlueMoon Edit
	icon_state = "spade"
	name = "Spade"

/datum/sprite_accessory/bm/vagina/furred //BlueMoon Edit
	icon_state = "furred"
	name = "Furred"

/datum/sprite_accessory/bm/vagina/gaping
	icon_state = "gaping"
	name = "Gaping"

/datum/sprite_accessory/bm/vagina/cloaca
	name = "cloaca"
	icon_state = "cloaca"
//BlueMoon Edit
/datum/sprite_accessory/bm/vagina/feline
	icon_state = "furred"
	name = "Feline"

/datum/sprite_accessory/bm/vagina/equine
	icon_state = "gaping"
	name = "Equine"

/datum/sprite_accessory/bm/vagina/cervine
	icon_state = "gaping"
	name = "Cervine"

/datum/sprite_accessory/bm/vagina/sergal
	icon_state = "sergal"
	name = "Sergal"

/datum/sprite_accessory/bm/vagina/hemi
	icon_state = "human"
	name = "Hemi"

/datum/sprite_accessory/bm/vagina/puffy
	icon_state = "hairy"
	name = "Puffy"

/datum/sprite_accessory/bm/vagina/teshari
	name = "Cloaca (For Teshari Only)"
	icon_state = "cloaca_teshari"
//BlueMoon Edit End

//BREASTS BE HERE
/datum/sprite_accessory/bm/breasts
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/breasts_onmob.dmi'
	name = "breasts"
	color_src = "breasts_color"

/datum/sprite_accessory/bm/breasts/pair
	icon_state = "pair"
	name = "Pair"

/datum/sprite_accessory/bm/breasts/quad
	icon_state = "quad"
	name = "Quad"

/datum/sprite_accessory/bm/breasts/sextuple
	icon_state = "sextuple"
	name = "Sextuple"

//BUTT
/datum/sprite_accessory/bm/butt
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/butt_onmob.dmi'
	icon_state = "butt"
	name = "butt"
	color_src = "butt_color"

/datum/sprite_accessory/bm/butt
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/butt_onmob.dmi'

/datum/sprite_accessory/bm/butt/pair
	icon_state = "pair"
	name = "Pair"

//Bellies
/datum/sprite_accessory/bm/belly
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/belly_onmob.dmi'
	icon_state = "belly"
	name = "belly"
	color_src = "belly_color"

//there literally shouldn't be any other ass types besides one because that'd be weird, this is just here to keep things consistent for the genital system.
/datum/sprite_accessory/bm/belly/pair
	icon_state = "pair"
	name = "Pair"

/datum/sprite_accessory/bm/anus
	icon = 'modular_redmoon/icons/from_bluemoon/mob/genitals/anus_onmob.dmi'
	icon_state = "anus"
	name = "anus"
	color_src = "anus_color"

/datum/sprite_accessory/bm/anus/donut
	icon_state = DEF_ANUS_SHAPE
	name = DEF_ANUS_SHAPE

/datum/sprite_accessory/bm/anus/squished
	icon_state = "squished"
	name = "squished"
