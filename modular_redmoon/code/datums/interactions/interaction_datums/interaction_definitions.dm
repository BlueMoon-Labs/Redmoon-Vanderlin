/datum/interaction
	var/list/body_parts = list(BODY_PART_CHEST)

/datum/interaction/handshake
	description = "Пожать руку."
	simple_message = "USER пожимает руку TARGET."
	required_from_user = INTERACTION_REQUIRE_HANDS
	required_from_target = INTERACTION_REQUIRE_HANDS
	interaction_sound = 'modular_redmoon/sound/interactions/thudswoosh.ogg'
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)

/datum/interaction/pat
	description = "Похлопать по плечу."
	simple_message = "USER хлопает TARGET по плечу."
	required_from_user = INTERACTION_REQUIRE_HANDS
	interaction_sound = 'modular_redmoon/sound/interactions/thudswoosh.ogg'

/datum/interaction/cheer
	description = "Подбодрить посвистыванием!"
	required_from_user = INTERACTION_REQUIRE_MOUTH
	simple_message = "USER подбадривает TARGET радостным посвистыванием!"
	interaction_sound = 'modular_redmoon/sound/interactions/svist.ogg'
	max_distance = 25
	interaction_flags = NONE

/datum/interaction/highfive
	description = "Дать пять!"
	simple_message = "USER даёт пять TARGET!"
	interaction_sound = 'modular_redmoon/sound/interactions/slap.ogg'
	required_from_user = INTERACTION_REQUIRE_HANDS
	required_from_target = INTERACTION_REQUIRE_HANDS
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)

/datum/interaction/headpat
	description = "Погладить по голове"
	simple_message = "USER гладит TARGET по голове." //BLUEMOON EDIT
	required_from_user = INTERACTION_REQUIRE_HANDS
	interaction_sound = 'modular_redmoon/sound/interactions/thudswoosh.ogg'
	body_parts = list(BODY_PART_HEAD)

/datum/interaction/fistbump
	description = "Удариться кулачками!"
	simple_message = "USER бьётся кулачком о кулачком TARGET! О да!"
	required_from_user = INTERACTION_REQUIRE_HANDS
	required_from_target = INTERACTION_REQUIRE_HANDS
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)

/datum/interaction/pinkypromise
	description = "Пообещать что-то на мизинчиках."
	simple_message = "USER хватается своим мизинчиком за мизинчик TARGET! Клятва Мизинчиками! Давно пора!"
	required_from_user = INTERACTION_REQUIRE_HANDS
	required_from_target = INTERACTION_REQUIRE_HANDS
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)

/datum/interaction/holdhand
	description = "Взяться за руку."
	simple_message = "USER хватается за руку TARGET."
	required_from_user = INTERACTION_REQUIRE_HANDS
	required_from_target = INTERACTION_REQUIRE_HANDS
	interaction_sound = 'modular_redmoon/sound/interactions/thudswoosh.ogg'
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)

/datum/interaction/salute
	description = "Исполнить Воинское Приветствие!"
	simple_message = "USER исполняет воинское приветствие при виде TARGET!"
	required_from_user = INTERACTION_REQUIRE_HANDS
	interaction_sound = 'modular_redmoon/sound/interactions/salute.ogg'
	max_distance = 25
	interaction_flags = NONE

/datum/interaction/handwave
	description = "Помахать рукой."
	simple_message = "USER приветливо машет TARGET."
	required_from_user = INTERACTION_REQUIRE_HANDS
	max_distance = 25
	interaction_flags = NONE
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)

/datum/interaction/bird
	description = "Показать Средний Палец"
	simple_message = "USER демонстрирует TARGET средний палец!"
	required_from_user = INTERACTION_REQUIRE_HANDS
	interaction_sound = 'modular_redmoon/sound/interactions/vineboom.ogg'
	max_distance = 25
	interaction_flags = NONE
	body_parts = list(BODY_PART_LARM, BODY_PART_RARM)
