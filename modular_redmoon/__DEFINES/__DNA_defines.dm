//species traits for mutantraces
#define MUTCOLORS		1
#define MUTCOLORS_PARTSONLY	8	//Used if we want the mutant colour to be only used by mutant bodyparts. Don't combine this with MUTCOLORS, or it will be useless.
#define DIGITIGRADE		10	//Uses weird leg sprites. Optional for Lizards, required for ashwalkers. Don't give it to other races unless you make sprites for this (see human_parts_greyscale.dmi)
#define NOLIVER			12
#define NOEYES			16
#define MARKINGS		17
#define MUTCOLORS2		18
#define MUTCOLORS3		19
#define MATRIXED		22	//if icon is color matrix'd
#define SKINTONE		23	//uses skin tones
#define CUSTOM_SKINTONE	24	//adds a "_g" suffix to bodypart overlays icon states if a custom skintone is used.
#define HORNCOLOR		25
#define WINGCOLOR		26
#define ROBOTIC_LIMBS	27 //has robotic limbs that render like organic ones
#define CAN_SCAR		28 // If this species can be scarred (fleshy)
/// Used for determining which wounds are applicable to this species.
#define HAS_FLESH	29 /// if we have flesh (can suffer slash/piercing/burn wounds, requires they don't have NOBLOOD)
#define HAS_BONE	30 /// if we have bones (can suffer bone wounds)
