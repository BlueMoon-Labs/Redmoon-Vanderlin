/mob/living/proc/lustcap(amt)
	var/lust_cap = (get_climax_threshold()) * 0.8 // 80% of the mob's orgasm arousal (lust_tolerance * 3) // BLUEMOON EDIT
	if((get_lust() + amt) >= lust_cap)
		set_lust(lust_cap - 1)

/**
  * Returns a lust value depending if the genital has a lust modifier.
  *
  * Arguments:
  * * amount: Amount of lust given.
  * * genital: Genital to check for any lust modifiers.
  * TODO - TURN THE TRAITS INTO COMPONENTS
*/
/mob/living/carbon/proc/check_stimulation(amount, genital)
	var/list/common_flags = list()

	// Check if the given genital is an "anus"
	if(genital == "anus")
		if(!dna.features["has_anus"])
			for(var/anus_trait in GLOB.anus_traits)
				if(HAS_TRAIT(src, anus_trait))
					LAZYADD(common_flags, anus_trait)

			if(!isemptylist(common_flags))
				var/new_amount = amount * GLOB.anus_traits[common_flags[1]]  // Multiply the arousal amount by the first trait added
				return new_amount

			return amount

	// Set a G variable to a proper genital instead of a string if it's one.
	var/obj/item/organ/genital/G = istype(genital, /obj/item/organ/genital) ? genital : getorganslot(genital)

	for(var/stim_mod in GLOB.lust_modifiers)
		if(CHECK_BITFIELD(G?.genital_flags, text2num(stim_mod)))
			LAZYADD(common_flags, stim_mod)

	if(G && !isemptylist(common_flags))
		var/new_amount = amount * GLOB.lust_modifiers[common_flags[1]] // Multiply the arousal amount by the first stimulation flag added

		if(CHECK_BITFIELD(text2num(common_flags[1]), GENITAL_EDGINGONLY))
			lustcap(new_amount)

		return new_amount

	return amount

/**
  * Returns the fluid modifier if the genital has one.
  *
  * Arguments:
  * * amount: Amount of fluid to be released.
  * * genital: Genital to check for any fluid modifiers.
*/
/mob/living/proc/get_fluid_mod(obj/item/organ/genital/G)
	if(CHECK_BITFIELD(G?.genital_flags, GENITAL_DISAPPOINTING))
		return 0.5
	return 1

/mob/living/carbon/handle_post_sex(amount, orifice, mob/living/partner, organ = null, cum_inside = FALSE, anonymous = FALSE)
	if(organ)
		amount = check_stimulation(amount, organ)

	. = ..()
