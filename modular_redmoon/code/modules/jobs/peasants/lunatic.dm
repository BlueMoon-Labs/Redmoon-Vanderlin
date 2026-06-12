/datum/attribute_holder/sheet/job/lunatic
	raw_attribute_list = list(
		STAT_INTELLIGENCE = -4,
		STAT_PERCEPTION = -3,
		STAT_CONSTITUTION = -2,
		STAT_ENDURANCE = -1,
		/datum/attribute/skill/misc/sneaking = list(10, 30),
	)

/datum/job/lunatic
	title = JOB_LUNATIC
	tutorial = "The Lunatic, shunned by society and a magnet for misfortune. Your task is simple yet perilous: survive by any means, though your very existence invites danger from every corner. It is said that Scarlet Dawn drives those most familiar with it, the most insane."
	department_flag = PEASANTS
	display_order = JDO_LUNATIC
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 3
	spawn_positions = 3
	bypass_lastclass = TRUE
	banned_leprosy = FALSE
	banned_lunatic = FALSE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/lunatic
	can_random = FALSE
	can_have_apprentices = FALSE
	can_be_apprentice = TRUE

	attribute_sheet = /datum/attribute_holder/sheet/job/lunatic

	traits = list(
		TRAIT_PACIFISM,
		TRAIT_DEADNOSE,
		TRAIT_MANIAC_AWOKEN,
		TRAIT_SCHIZO_AMBIENCE,
		TRAIT_JESTERPHOBIA,
	)

/datum/job/lunatic/New()
	. = ..()
	if(title && !(title in GLOB.peasant_positions))
		GLOB.peasant_positions += title

/datum/outfit/lunatic
	name = JOB_LUNATIC

/datum/outfit/lunatic/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.STALUC = rand(3, 8)
	if(prob(35))
		head = /obj/item/clothing/head/knitcap
	pants = /obj/item/clothing/pants/tights/colored/vagrant
	shirt = /obj/item/clothing/shirt/undershirt/colored/vagrant
	armor = /obj/item/clothing/shirt/rags
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/flashlight/flare/torch/prelit
