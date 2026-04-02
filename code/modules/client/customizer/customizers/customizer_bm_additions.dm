/datum/customizer_choice/bodypart_feature/hair/head/humanoid/New()
	. = ..()

	if(!GLOB.bm_hair_paths || !GLOB.bm_hair_paths.len)
		GLOB.bm_hair_paths = init_sprite_accessory_paths(/datum/sprite_accessory/bm/hair, GLOB.bm_hair_paths)

	if(!sprite_accessories)
		sprite_accessories = list()
	for(var/path in GLOB.bm_hair_paths)
		if(!(path in sprite_accessories))
			sprite_accessories += path

/datum/customizer_choice/bodypart_feature/hair/head/humanoid/New()
	. = ..()

	GLOB.bm_hair_paths = init_sprite_accessory_paths(/datum/sprite_accessory/bm/hair, GLOB.bm_hair_paths)

	if(!sprite_accessories)
		sprite_accessories = list()
	for(var/path in GLOB.bm_hair_paths)
		if(!(path in sprite_accessories))
			sprite_accessories += path

/datum/customizer_choice/organ/tail/dracon/New()
	. = ..()
	GLOB.bm_tails_lizard = init_sprite_accessory_paths(/datum/sprite_accessory/bm/tails/lizard, GLOB.bm_tails_lizard)
	GLOB.bm_tails_lizard_animated = init_sprite_accessory_paths(/datum/sprite_accessory/bm/tails_animated/lizard, GLOB.bm_tails_lizard_animated)

	if(!sprite_accessories)
		sprite_accessories = list()
	for(var/path in GLOB.bm_tails_lizard)
		if(!(path in sprite_accessories))
			sprite_accessories += path
	for(var/path in GLOB.bm_tails_lizard_animated)
		if(!(path in sprite_accessories))
			sprite_accessories += path
