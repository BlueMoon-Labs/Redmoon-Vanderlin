#define HIDETAUR		(1<<11) //gotta hide that snowflake
#define HIDESNOUT		(1<<12) //or do we actually hide our snoots
#define HIDEACCESSORY	(1<<13) //hides the jumpsuit accessory.
//sandstorm edit
#define HIDEUNDERWEAR	(1<<14) //hides underwear, socks and shirt
#define HIDEWRISTS		(1<<15) //hides wrists
//
//flags for outfits that have mutant race variants: Most of these require additional sprites to work.
#define STYLE_DIGITIGRADE		(1<<0) //jumpsuits, suits and shoes
#define STYLE_MUZZLE			(1<<1) //hats or masks
#define STYLE_SNEK_TAURIC		(1<<2) //taur-friendly suits
#define STYLE_PAW_TAURIC		(1<<3)
#define STYLE_HOOF_TAURIC		(1<<4)
#define STYLE_ALL_TAURIC		(STYLE_SNEK_TAURIC|STYLE_PAW_TAURIC|STYLE_HOOF_TAURIC)
#define STYLE_NO_ANTHRO_ICON	(1<<5) //When digis fit the default sprite fine and need no copypasted states. This is the case of skirts and winter coats, for example.
#define USE_SNEK_CLIP_MASK		(1<<6)
#define USE_QUADRUPED_CLIP_MASK	(1<<7)
#define USE_TAUR_CLIP_MASK		(USE_SNEK_CLIP_MASK|USE_QUADRUPED_CLIP_MASK)

//digitigrade legs settings.
#define NOT_DIGITIGRADE				0
#define FULL_DIGITIGRADE			1
#define SQUISHED_DIGITIGRADE		2

#define ITEM_SLOT_EYES (1<<3)
#define ITEM_SLOT_EARS_LEFT (1<<4)
#define ITEM_SLOT_EARS_RIGHT (1<<21)

GLOBAL_LIST_INIT(slots, list("head", "wear_mask", "back", "wear_suit", "w_uniform", "w_underwear", "w_socks", "w_shirt", "shoes", "belt", "gloves", "glasses", "ears", "ears_extra", "s_store")) // Sandstorm edit
GLOBAL_LIST_INIT(slot2slot, list("head" = ITEM_SLOT_HEAD, "wear_mask" = ITEM_SLOT_MASK, "neck" = ITEM_SLOT_NECK, "back" = ITEM_SLOT_BACK, "wear_suit" = ITEM_SLOT_ARMOR, "w_uniform" = ITEM_SLOT_SHIRT, "w_underwear" = ITEM_SLOT_PANTS, "w_socks" = ITEM_SLOT_SHOES, "w_shirt" = ITEM_SLOT_SHIRT, "ears_extra" = ITEM_SLOT_EARS_RIGHT, "shoes" = ITEM_SLOT_SHOES, "belt" = ITEM_SLOT_BELT, "gloves" = ITEM_SLOT_GLOVES, "glasses" = ITEM_SLOT_EYES, "ears" = ITEM_SLOT_EARS_LEFT, "s_store" = ITEM_SLOT_CLOAK, "wrists" = ITEM_SLOT_WRISTS)) // Sandstorm edit
