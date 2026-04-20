// If I could have gotten away with using a tilde in the type path, I would have.
/datum/interaction

	simple_style = "lewd"
	interaction_flags = INTERACTION_FLAG_ADJACENT | INTERACTION_FLAG_OOC_CONSENT
	interaction_sound_volume = 70

	/// Use the number of required feet.
	var/require_user_num_feet
	var/require_target_num_feet

	/// Time before actions can be done again
	var/user_refractory_cost
	var/target_refractory_cost
	var/require_target_legs
	var/require_target_num_legs
	var/require_user_legs
	var/require_user_num_legs
