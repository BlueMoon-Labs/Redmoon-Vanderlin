#define MATRIX_RED			"red"
#define MATRIX_GREEN		"green"
#define MATRIX_BLUE			"blue"
#define MATRIX_RED_GREEN	"red_green"
#define MATRIX_RED_BLUE		"red_blue"
#define MATRIX_GREEN_BLUE	"green_blue"
#define MATRIX_ALL			"red_green_blue"
#define MATRIX_NONE			"none"

//organ defines
#define BUTT_LAYER_INDEX		1
#define ANUS_LAYER_INDEX		2
#define VAGINA_LAYER_INDEX		3
#define TESTICLES_LAYER_INDEX	4
#define GENITAL_LAYER_INDEX		5
#define PENIS_LAYER_INDEX		6
#define BELLY_LAYER_INDEX		7
#define BREASTS_LAYER_INDEX		8

#define GENITAL_LAYER_INDEX_LENGTH 8 //keep it updated with each new index added, thanks.

#define DEF_VAGINA_SHAPE	"Human"

#define COCK_SIZE_DEF		6

#define COCK_DIAMETER_RATIO_MAX		0.42
#define COCK_DIAMETER_RATIO_DEF		0.25
#define COCK_DIAMETER_RATIO_MIN		0.15

#define DEF_COCK_SHAPE		"human"

#define BALLS_VOLUME_BASE	25
#define BALLS_VOLUME_MULT	1

#define DEF_BALLS_SHAPE		"Single"

//SPLURT change, support for more sizes
#define BALLS_SIZE_MIN		1
#define BALLS_SIZE_DEF		2
#define BALLS_SIZE_2		3
#define BALLS_SIZE_3		4
#define BALLS_SIZE_MAX		5

#define CUM_RATE			2 // units per 10 seconds
#define CUM_RATE_MULT		1
#define CUM_EFFICIENCY		1 //amount of nutrition required per life()

#define BREASTS_VOLUME_BASE	50	//base volume for the reagents in the breasts, multiplied by the size then multiplier. 50u for A cups, 850u for HH cups.
#define BREASTS_VOLUME_MULT	1	//global multiplier for breast volume.

#define BREASTS_SIZE_DEF	"c" //lowercase cause those sprite accessory don't use uppercased letters.

#define DEF_BREASTS_SHAPE	"Pair"

#define MILK_RATE			3
#define MILK_RATE_MULT		1
#define MILK_EFFICIENCY		1

#define BUTT_SIZE_DEF		0
#define BUTT_SIZE_MAX		8  //butt genitals are special in that they have caps. if there's the event there's even bigger butt sprites, raise this number.

#define BELLY_SIZE_MIN		0
#define BELLY_SIZE_DEF		1
#define BELLY_SIZE_MAX		10

#define DEF_ANUS_SHAPE "donut"

//visibility toggles defines to avoid errors typos code errors.
#define GEN_VISIBLE_ALWAYS "Always visible"
#define GEN_VISIBLE_NO_CLOTHES "Hidden by clothes"
#define GEN_VISIBLE_NO_UNDIES "Hidden by underwear"
#define GEN_VISIBLE_NEVER "Always hidden"

//Damage stuffs
#define LUST_DAMAGE "lust"

#define GEN_REMOVE_EQUIPMENT "Remove Equipment"
#define GEN_INSERT_EQUIPMENT "Insert Equipment"

#define GEN_ALLOW_EGG_STUFFING "Allows toys and egg stuffing"

GLOBAL_LIST_INIT(genitals_interactions, list(GEN_REMOVE_EQUIPMENT, GEN_INSERT_EQUIPMENT))
#define GENITAL_INFLATION_THRESHOLD 0.5

//Citadel toggles because bitflag memes
#define MEDIHOUND_SLEEPER	(1<<0)
#define EATING_NOISES		(1<<1)
#define DIGESTION_NOISES	(1<<2)
#define BREAST_ENLARGEMENT	(1<<3)
#define PENIS_ENLARGEMENT	(1<<4)
#define FORCED_FEM			(1<<5)
#define FORCED_MASC			(1<<6)
#define HYPNO				(1<<7)
#define NEVER_HYPNO			(1<<8)
#define NO_APHRO			(1<<9)
#define NO_ASS_SLAP			(1<<10)
#define BIMBOFICATION		(1<<11)
#define NO_AUTO_WAG			(1<<12)
#define GENITAL_EXAMINE		(1<<13)
#define VORE_EXAMINE		(1<<14)
#define TRASH_FORCEFEED		(1<<15)
#define BUTT_ENLARGEMENT	(1<<16)
#define BELLY_INFLATION		(1<<17)
#define CHASTITY			(1<<18)
#define STIMULATION			(1<<19)
#define EDGING				(1<<20)
#define NO_DISCO_DANCE		(1<<21)
#define CUM_ONTO			(1<<22)
#define SEX_JITTER			(1<<23) //The maximum limit was reached by Gardelin0
//Note: reminder, if you're a coder adding more bitflags here in the event we add more horny things, the maximum is (1<<23).
#define TOGGLES_CITADEL 0


#define NULL_COALESCE(var, default) (isnull(var) ? (default) : (var))
