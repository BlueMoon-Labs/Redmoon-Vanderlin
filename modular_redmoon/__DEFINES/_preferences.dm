
//Preference toggles
#define NO_ANTAG				(1<<16)
#define VERB_CONSENT			(1<<17) // Sandstorm - ERP Mechanic Addition
#define LEWD_VERB_SOUNDS		(1<<18) // Sandstorm - ERP Mechanic Addition
#define TG_PLAYER_PANEL			(1<<19) // SPLURT - Opt for the TG splashscreen player panel
#define SOUND_JUKEBOXES			(1<<20)
#define RANGED_VERBS_CONSENT	(1<<21) // BLUEMOON ADD интеракты с расстояния

#define CUSTOM_OOC			(1<<0)
#define CUSTOM_AOOC			(1<<1)

#define TOGGLES_DEFAULT_CUSTOM_COLORS (CUSTOM_OOC|CUSTOM_AOOC)

//randomised elements
#define RANDOM_ANTAG_ONLY 1
#define RANDOM_DISABLED 2
#define RANDOM_ENABLED 3

#define DB_FLAG_AGE_CONFIRMATION_INCOMPLETE		(1<<1)
#define DB_FLAG_AGE_CONFIRMATION_COMPLETE		(1<<2)

#define DEFAULT_CYBORG_NAME "Default Cyborg Name"

// 'Be Victim' consent options for preferences panel / antag target HUD
#define BEVICTIM_NO "No"
#define BEVICTIM_ASK "Ask"
#define BEVICTIM_YES "Yes"

// Values for /datum/preference/savefile_identifier
/// This preference is character specific.
#define PREFERENCE_CHARACTER "character"
/// This preference is account specific.
#define PREFERENCE_PLAYER "player"
