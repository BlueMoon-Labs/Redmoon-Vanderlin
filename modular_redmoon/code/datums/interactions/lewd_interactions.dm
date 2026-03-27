// If I could have gotten away with using a tilde in the type path, I would have.
/datum/interaction/lewd
	var/description = null
	var/simple_style = "lewd"
	var/interaction_flags = INTERACTION_FLAG_ADJACENT | INTERACTION_FLAG_OOC_CONSENT
	var/interaction_sound_volume = 70

	/// Use the number of required feet.
	var/require_user_num_feet
	var/require_target_num_feet

	/// Time before actions can be done again
	var/user_refractory_cost
	var/target_refractory_cost
