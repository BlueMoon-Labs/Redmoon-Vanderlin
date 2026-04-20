#define BODY_PART_HEAD      "head"
#define BODY_PART_CHEST     "chest"
#define BODY_PART_GROIN     "groin"
#define BODY_PART_LARM      "left_arm"
#define BODY_PART_RARM      "right_arm"
#define BODY_PART_LLEG      "left_leg"
#define BODY_PART_RLEG      "right_leg"
#define BODY_PART_TAIL      "tail"

/obj/item/bodypart
	var/disabled = FALSE

/mob/living/carbon/has_left_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/L in hand_bodyparts)
		if(L.held_index % 2)
			if(!check_disabled || !L.disabled)
				return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_left_hand()
	return TRUE

/mob/living/carbon/has_right_hand(check_disabled = TRUE)
	for(var/obj/item/bodypart/L in hand_bodyparts)
		if(!(L.held_index % 2))
			if(!check_disabled || !L.disabled)
				return TRUE
	return FALSE

/mob/living/carbon/alien/larva/has_right_hand()
	return TRUE

/mob/proc/has_left_leg()
	return TRUE

/mob/living/carbon/has_left_leg()
	var/obj/item/bodypart/l_leg = get_bodypart(BODY_ZONE_L_LEG)
	if(l_leg)
		return TRUE
	else
		return FALSE

/mob/proc/has_right_leg()
	return TRUE

/mob/living/carbon/has_right_leg()
	var/obj/item/bodypart/r_leg = get_bodypart(BODY_ZONE_R_LEG)
	if(r_leg)
		return TRUE
	else
		return FALSE

/mob/living/carbon/get_num_arms(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == ARM_RIGHT)
			if(!check_disabled || !affecting.disabled)
				.++
		if(affecting.body_part == ARM_LEFT)
			if(!check_disabled || !affecting.disabled)
				.++


//sometimes we want to ignore that we don't have the required amount of arms.
/mob/proc/get_arm_ignore()
	return FALSE

/mob/living/carbon/alien/larva/get_arm_ignore()
	return TRUE //so we can still handcuff larvas.


/mob/proc/get_num_legs(check_disabled = TRUE)
	return 2

/mob/living/carbon/get_num_legs(check_disabled = TRUE)
	. = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/affecting = X
		if(affecting.body_part == LEG_RIGHT)
			if(!check_disabled || !affecting.disabled)
				.++
		if(affecting.body_part == LEG_LEFT)
			if(!check_disabled || !affecting.disabled)
				.++
