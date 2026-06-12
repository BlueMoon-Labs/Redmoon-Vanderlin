// used to access COMSIG_MOB_SAY argslist
#define EMOTE_ACT 1
#define EMOTE_MTYPE 2
#define EMOTE_MESSAGE 3
#define EMOTE_INTENTIONAL 4

/// from base of [/client/proc/handle_spam_prevention] (message, mute_type)
#define COMSIG_MOB_AUTOMUTE_CHECK "client_automute_check" // The check is performed by the client.
	/// Prevents the automute system checking this client for repeated messages.
	#define WAIVE_AUTOMUTE_CHECK (1<<0)

/*
 * # COMSIG_MOB_UPDATE_GENITALS
 * From modular_splurt\code\modules\arousal\genitals.dm
 * Used by signals for determining when genitals have been updated
*/
#define COMSIG_MOB_UPDATE_GENITALS "mob_genitals_updated"

///from /obj/machinery/set_occupant(atom/movable/O): (new_occupant)
#define COMSIG_MOB_PRE_CAME "mob_pre_came"
/// From /mob/living/cum(): (mob/source, mob/living/partner, target_orifice)
#define COMSIG_MOB_POST_CAME "mob_post_came"
