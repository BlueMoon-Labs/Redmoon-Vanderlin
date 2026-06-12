/proc/ismasculine(A)
	. = FALSE
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		if(C.dna.features["body_model"] == MALE)
			. = TRUE

/proc/isfeminine(A)
	. = FALSE
	if(iscarbon(A))
		var/mob/living/carbon/C = A
		if(C.dna.features["body_model"] == FEMALE)
			. = TRUE
