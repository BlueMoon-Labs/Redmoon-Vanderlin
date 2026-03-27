/datum/sprite_accessory/bm
	var/gender_specific //Something that can be worn by either gender, but looks different on each
	var/color_src = MUTCOLORS	//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
	var/dimension_x = 32
	var/dimension_y = 32
	var/center = FALSE	//Should we center the sprite?
	var/alpha_mask_state
	var/matrixed_sections = MATRIX_NONE //if color_src is MATRIXED, how many sections does it have? 1-3
	var/ignore = FALSE //NEVER include in customization if set to TRUE

	//Special / holdover traits for Citadel specific sprites.
	var/extra = FALSE
	var/extra_color_src = MUTCOLORS2						//The color source for the extra overlay.
	var/extra2 = FALSE
	var/extra2_color_src = MUTCOLORS3

	//for snowflake/donor specific sprites
	var/list/ckeys_allowed

	//For soft-restricting markings to species IDs
	var/list/recommended_species

	// set to FALSE if your sprite accecory is already colored and you dont want it to be recolored
	var/do_colouration = TRUE

	var/mutable_category // simply do not worry about this value

/datum/sprite_accessory/bm/proc/is_not_visible(var/mob/living/carbon/human/H, var/tauric) //return if the accessory shouldn't be shown
	return FALSE
