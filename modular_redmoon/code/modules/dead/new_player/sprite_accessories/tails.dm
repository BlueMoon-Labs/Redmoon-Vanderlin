/datum/sprite_accessory/bm/tails
	abstract_type = /datum/sprite_accessory/tail
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_key_name = "Tail"
	relevant_layers = list(BODY_FRONT_LAYER, BODY_BEHIND_LAYER)
	color_key_defaults = list(KEY_HAIR_COLOR)
	var/can_wag = FALSE

/datum/sprite_accessory/bm/tails/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDETAIL)

/datum/sprite_accessory/bm/tails_animated
	abstract_type = /datum/sprite_accessory/tail
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_key_name = "Tail"
	// mutant_part_string = "tailwag" //keep this the same, ALWAYS, this is incredibly important for colouring!
	relevant_layers = list(BODY_FRONT_LAYER, BODY_BEHIND_LAYER)
	var/can_wag = FALSE

/datum/sprite_accessory/bm/tails_animated/is_visible(obj/item/organ/organ, obj/item/bodypart/bodypart, mob/living/carbon/owner)
	return is_human_part_visible(owner, HIDETAIL)

/******************************************
************* Lizard Tails ****************
*******************************************/

/datum/sprite_accessory/bm/tails/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/bm/tails_animated/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/bm/tails/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/bm/tails_animated/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/bm/tails/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/bm/tails_animated/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/bm/tails/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/bm/tails_animated/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/******************************************
************** Human Tails ****************
*******************************************/

/datum/sprite_accessory/bm/tails/human/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/bm/tails_animated/human/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

// /datum/sprite_accessory/bm/tails_animated/human/is_not_visible(var/mob/living/carbon/human/H, var/tauric)
// 	return (((H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR)) || tauric)|| H.dna.species.mutant_bodyparts["tail_human"])

/datum/sprite_accessory/bm/tails/human/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	relevant_layers = list(BODY_FRONT_LAYER)
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/bee
	name = "Bee"
	icon_state = "bee"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/bee
	name = "Bee"
	icon_state = "bee"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/cat
	name = "Cat"
	icon_state = "cat"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = HAIR

/datum/sprite_accessory/bm/tails_animated/human/cat
	name = "Cat"
	icon_state = "cat"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = HAIR

/datum/sprite_accessory/bm/tails/human/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/twocat
	name = "Cat, Double"
	icon_state = "twocat"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/twocat
	name = "Cat, Double"
	icon_state = "twocat"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/alttwocat // BlueMoon addition
	name = "Cat, Double, Alt"
	icon_state = "twocatalt"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/bm/tails_animated/human/alttwocat // BlueMoon addition
	name = "Cat, Double, Alt"
	icon_state = "twocatalt"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/bm/tails/human/carp // BLUEMOON CHANGE ' /shark' to ' /carp' and 'name = ' to carp
	name = "Carp"
	icon_state = "carp"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/carp // BLUEMOON CHANGE ' /shark' to ' /carp' and 'name = ' to carp.
	name = "Carp"
	icon_state = "carp"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/datacarp // BLUEMOON CHANGE ' /datashark' to ' /datacarp' and 'name = ' to datacarp. Alphabeth ignored on puprose
	name = "datacarp"
	icon_state = "datacarp"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/bm/tails_animated/human/datacarp // BLUEMOON CHANGE ' /datashark' to ' /datacarp' and 'name = ' to datacarp. Alphabeth ignored on puprose
	name = "datacarp"
	icon_state = "datacarp"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/bm/tails/human/corvid
	name = "Corvid"
	icon_state = "crow"

/datum/sprite_accessory/bm/tails_animated/human/corvid
	name = "Corvid"
	icon_state = "crow"

/datum/sprite_accessory/bm/tails/human/cow
	name = "Cow"
	icon_state = "cow"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/cow
	name = "Cow"
	icon_state = "cow"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/bm/tails_animated/human/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/bm/tails/human/eevee
	name = "Eevee"
	icon_state = "eevee"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/eevee
	name = "Eevee"
	icon_state = "eevee"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/fennec
	name = "Fennec"
	icon_state = "fennec"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/fennec
	name = "Fennec"
	icon_state = "fennec"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/fish
	name = "Fish"
	icon_state = "fish"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/fish
	name = "Fish"
	icon_state = "fish"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/fox
	name = "Fox"
	icon_state = "fox"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/fox
	name = "Fox"
	icon_state = "fox"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/horse
	name = "Horse"
	icon_state = "horse"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = HAIR

/datum/sprite_accessory/bm/tails_animated/human/horse
	name = "Horse"
	icon_state = "horse"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = HAIR

/datum/sprite_accessory/bm/tails/human/husky
	name = "Husky"
	icon_state = "husky"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/husky
	name = "Husky"
	icon_state = "husky"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/insect
	name = "Insect"
	icon_state = "insect"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/insect
	name = "Insect"
	icon_state = "insect"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/bm/tails_animated/human/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/bm/tails/human/murid // BLUEMOON Fink edited
	name = "Murid"
	icon_state = "murid"
	color_src = MUTCOLORS
	icon = 'modular_redmoon/icons/from_bluemoon/mob/bm_tails.dmi'
	matrixed_sections = MATRIX_NONE

/datum/sprite_accessory/bm/tails_animated/human/murid // BLUEMOON Fink edited
	name = "Murid"
	icon_state = "murid"
	color_src = MUTCOLORS
	icon = 'modular_redmoon/icons/from_bluemoon/mob/bm_tails.dmi'
	matrixed_sections = MATRIX_NONE

/datum/sprite_accessory/bm/tails/orca
	name = "Orca"
	icon_state = "orca"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/orca
	name = "Orca"
	icon_state = "orca"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/otie
	name = "Otusian"
	icon_state = "otie"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/otie
	name = "Otusian"
	icon_state = "otie"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/ailurus
	name = "Red Panda"
	icon_state = "wah"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/ailurus
	name = "Red Panda"
	icon_state = "wah"
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/pede
	name = "Scolipede"
	icon_state = "pede"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/pede
	name = "Scolipede"
	icon_state = "pede"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/sabresune // BLUEMOON CHANGE PORT from Citadel_Snowflake.dm file
	name = "Sabresune"
	icon_state = "sabresune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/sabresune // BLUEMOON CHANGE PORT from Citadel_Snowflake.dm file
	name = "Sabresune"
	icon_state = "sabresune"
	color_src = MATRIXED
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/sergal
	name = "Sergal"
	icon_state = "sergal"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/sergal
	name = "Sergal"
	icon_state = "sergal"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/shark
	name = "Shark"
	icon_state = "shark"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/shark
	name = "Shark"
	icon_state = "shark"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/skunk
	name = "Skunk"
	icon_state = "skunk"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails_animated/human/skunk
	name = "skunk"
	icon_state = "skunk"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails/human/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/bm/tails_animated/human/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/bm/tails/human/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/bm/tails_animated/human/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/bm/tails/human/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"

/datum/sprite_accessory/bm/tails_animated/human/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"

/datum/sprite_accessory/bm/tails/human/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/tamamo_kitsune
	name = "Tamamo Kitsune Tails" //Tamamo-no-Tiro, let it be known!
	icon_state = "9sune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/tamamo_kitsune
	name = "Tamamo Kitsune Tails"
	icon_state = "9sune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/triple_kitsune
	name = "Triple Kitsune Tails"
	icon_state = "3sune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/triple_kitsune
	name = "Triple Kitsune Tails"
	icon_state = "3sune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/takahiro_kitsune
	name = "Takahiro Kitsune Tails" //takahiro had five tails i just wanted to follow the 'T' naming convention vs. tamamo and triple
	icon_state = "7sune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/human/takahiro_kitsune
	name = "Takahiro Kitsune Tails"
	icon_state = "7sune"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/human/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/human/tiger
	name = "Tiger"
	icon_state = "tiger"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails_animated/human/tiger
	name = "Tiger"
	icon_state = "tiger"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails/human/wolf
	name = "Wolf"
	icon_state = "wolf"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/human/wolf
	name = "Wolf"
	icon_state = "wolf"
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	matrixed_sections = MATRIX_RED

/******************************************
************** Furry Tails ****************
*******************************************/

/datum/sprite_accessory/bm/tails/mam_tails
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	recommended_species = list("mammal", "slimeperson", "podweak", "felinid", "insect", "undead_mammal", "undead_insect")
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

/datum/sprite_accessory/bm/tails/mam_tails/none
	name = "None"
	icon_state = "none"
	recommended_species = null
	relevant_layers = null

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated
	color_src = MATRIXED
	icon = 'modular_redmoon/icons/from_bluemoon/mob/mam_tails.dmi'
	relevant_layers = list(BODY_BEHIND_LAYER, BODY_FRONT_LAYER)

// /datum/sprite_accessory/bm/tails_animated/mam_tails_animated/is_not_visible(var/mob/living/carbon/human/H, var/tauric)
// 	return (((H.wear_suit && (H.wear_suit.flags_inv & HIDETAUR)) || tauric) || H.dna.species.mutant_bodyparts["mam_tail"])

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/none
	name = "None"
	icon_state = "none"
	relevant_layers = null

/datum/sprite_accessory/bm/tails/mam_tails/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/axolotl
	name = "Axolotl"
	icon_state = "axolotl"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/batl
	name = "Bat (Long)"
	icon_state = "batl"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/batl
	name = "Bat (Long)"
	icon_state = "batl"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/bats
	name = "Bat (Short)"
	icon_state = "bats"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/bats
	name = "Bat (Short)"
	icon_state = "bats"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/bee
	name = "Bee"
	icon_state = "bee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/bee
	name = "Bee"
	icon_state = "bee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/bm/tails/mam_tails/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/catbig
	name = "Cat, Big"
	icon_state = "catbig"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/twocat
	name = "Cat, Double"
	icon_state = "twocat"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/twocat
	name = "Cat, Double"
	icon_state = "twocat"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/twocat // BlueMoon addition
	name = "Cat, Double, Alt"
	icon_state = "twocatalt"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/twocat // BlueMoon addition
	name = "Cat, Double, Alt"
	icon_state = "twocatalt"
	matrixed_sections = MATRIX_RED_BLUE

/datum/sprite_accessory/bm/tails/mam_tails/carp // BLUEMOON CHANGE ' /shark' to ' /carp' and 'name = ' to carp
	name = "Carp"
	icon_state = "carp"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/carp // BLUEMOON CHANGE ' /shark' to ' /carp' and 'name = ' to carp
	name = "Carp"
	icon_state = "carp"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/carp/datacarp //BLUEMOON CHANGE ' /datashark' to ' /datacarp' and 'name = ' to datacarp. Alphabeth ignored on puprose
	name = "DataCarp"
	icon_state = "datacarp"

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/carp/datacarp // BLUEMOON CHANGE ' /datashark' to ' /datacarp' and 'name = ' to datacarp. Alphabeth ignored on puprose
	name = "DataCarp"
	icon_state = "datacarp"

/datum/sprite_accessory/bm/tails/mam_tails/corvid
	name = "Corvid"
	icon_state = "crow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/corvid
	name = "Corvid"
	icon_state = "crow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/cow
	name = "Cow"
	icon_state = "cow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/cow
	name = "Cow"
	icon_state = "cow"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails/mam_tails/eevee
	name = "Eevee"
	icon_state = "eevee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/eevee
	name = "Eevee"
	icon_state = "eevee"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/fennec
	name = "Fennec"
	icon_state = "fennec"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/fennec
	name = "Fennec"
	icon_state = "fennec"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/fish
	name = "Fish"
	icon_state = "fish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/fish
	name = "Fish"
	icon_state = "fish"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/fox
	name = "Fox"
	icon_state = "fox"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/fox
	name = "Fox"
	icon_state = "fox"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/hawk
	name = "Hawk"
	icon_state = "hawk"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/hawk
	name = "Hawk"
	icon_state = "hawk"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/horse
	name = "Horse"
	icon_state = "horse"
	color_src = HAIR

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/horse
	name = "Horse"
	icon_state = "horse"
	color_src = HAIR

/datum/sprite_accessory/bm/tails/mam_tails/husky
	name = "Husky"
	icon_state = "husky"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/husky
	name = "Husky"
	icon_state = "husky"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/insect
	name = "Insect"
	icon_state = "insect"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/insect
	name = "Insect"
	icon_state = "insect"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/kangaroo
	name = "kangaroo"
	icon_state = "kangaroo"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/kangaroo
	name = "kangaroo"
	icon_state = "kangaroo"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/kitsune
	name = "Kitsune"
	icon_state = "kitsune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/lab
	name = "Lab"
	icon_state = "lab"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/lab
	name = "Lab"
	icon_state = "lab"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails/mam_tails/lunasune // BLUEMOON CHANGE PORT from Citadel_Snowflake.dm file also added matrix
	name = "lunasune"
	icon_state = "lunasune"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/lunasune // BLUEMOON CHANGE PORT from Citadel_Snowflake.dm file also added matrix
	name = "lunasune"
	icon_state = "lunasune"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/murid // BLUEMOON Fink edited
	name = "Murid"
	icon_state = "murid"
	color_src = MUTCOLORS
	icon = 'modular_redmoon/icons/from_bluemoon/mob/bm_tails.dmi'
	matrixed_sections = MATRIX_NONE

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/murid // BLUEMOON Fink edited
	name = "Murid"
	icon_state = "murid"
	color_src = MUTCOLORS
	icon = 'modular_redmoon/icons/from_bluemoon/mob/bm_tails.dmi'
	matrixed_sections = MATRIX_NONE

/datum/sprite_accessory/bm/tails/mam_tails/orca
	name = "Orca"
	icon_state = "orca"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/orca
	name = "Orca"
	icon_state = "orca"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/otie
	name = "Otusian"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/otie
	name = "Otusian"
	icon_state = "otie"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/rabbit
	name = "Rabbit"
	icon_state = "rabbit"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/ailurus
	name = "Red Panda"
	icon_state = "wah"
	extra = TRUE
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/ailurus
	name = "Red Panda"
	icon_state = "wah"
	extra = TRUE
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/pede
	name = "Scolipede"
	icon_state = "pede"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/sergal
	name = "Sergal"
	icon_state = "sergal"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/sergal/alt
	name = "Sergal alt"
	icon_state = "sergal_alt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/sergal/alt
	name = "Sergal alt"
	icon_state = "sergal_alt"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/sergal/alt_two
	name = "Sergal alt (2 colors)"
	icon_state = "sergal_alt_2"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/sergal/alt_two
	name = "Sergal alt (2 colors)"
	icon_state = "sergal_alt_2"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/shark
	name = "Shark"
	icon_state = "shark"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/shark
	name = "Shark"
	icon_state = "shark"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	matrixed_sections = MATRIX_GREEN_BLUE

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/shepherd
	name = "Shepherd"
	icon_state = "shepherd"
	matrixed_sections = MATRIX_GREEN_BLUE

/datum/sprite_accessory/bm/tails/mam_tails/skunk
	name = "Skunk"
	icon_state = "skunk"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/skunk
	name = "Skunk"
	icon_state = "skunk"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails/mam_tails/smooth
	name = "Smooth"
	icon_state = "smooth"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/smooth
	name = "Smooth"
	icon_state = "smooth"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/spikes
	name = "Spikes"
	icon_state = "spikes"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails/mam_tails/spikes
	name = "Spikes"
	icon_state = "spikes"
	color_src = MUTCOLORS
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/bm/tails/mam_tails/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/straighttail
	name = "Straight Tail"
	icon_state = "straighttail"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/squirrel
	name = "Squirrel"
	icon_state = "squirrel"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/tamamo_kitsune
	name = "Tamamo Kitsune Tails"
	icon_state = "9sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/tamamo_kitsune
	name = "Tamamo Kitsune Tails"
	icon_state = "9sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/triple_kitsune
	name = "Triple Kitsune Tails"
	icon_state = "3sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/triple_kitsune
	name = "Triple Kitsune Tails"
	icon_state = "3sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails/mam_tails/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/tentacle
	name = "Tentacle"
	icon_state = "tentacle"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tails/tiger
	name = "Tiger"
	icon_state = "tiger"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/tiger
	name = "Tiger"
	icon_state = "tiger"
	matrixed_sections = MATRIX_ALL

/datum/sprite_accessory/bm/tails/mam_tails/wolf
	name = "Wolf"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/wolf
	name = "Wolf"
	icon_state = "wolf"
	matrixed_sections = MATRIX_RED

/datum/sprite_accessory/bm/tails/mam_tail/takahiro_kitsune
	name = "Takahiro Kitsune Tails"
	icon_state = "7sune"
	matrixed_sections = MATRIX_RED_GREEN

/datum/sprite_accessory/bm/tails_animated/mam_tails_animated/takahiro_kitsune
	name = "Takahiro Kitsune Tails"
	icon_state = "7sune"
	matrixed_sections = MATRIX_RED_GREEN
