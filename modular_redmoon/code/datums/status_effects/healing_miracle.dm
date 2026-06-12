/datum/status_effect/buff/healing/miracle
	id = "healing"
	alert_type = /atom/movable/screen/alert/status_effect/buff/healing
	examine_text = "SUBJECTPRONOUN is bathed in a restorative aura!"
	duration = 10 SECONDS

	var/initial_blood_restore = 0

/datum/status_effect/buff/healing/miracle/on_creation(mob/living/new_owner, duration_override, new_healing_on_tick, blood_restore = 0)
	initial_blood_restore = blood_restore
	return ..()

/datum/status_effect/buff/healing/miracle/on_apply()
	. = ..()
	if(initial_blood_restore)
		owner.adjust_blood_volume(initial_blood_restore, maximum = BLOOD_VOLUME_NORMAL)

/datum/action/cooldown/spell/healing
	/// Total equivalent used for devotion/faith signals — actual heal is HoT per tick.
	base_healing = REDMOON_ACOLYTE_HEAL_PER_TICK * REDMOON_MIRACLE_HEAL_TICKS
	blood_restoration = 0
	wound_modifier = 0

/datum/action/cooldown/spell/healing/greater
	base_healing = REDMOON_GREATER_HEAL_PER_TICK * REDMOON_MIRACLE_HEAL_TICKS
	blood_restoration = 0
	wound_modifier = 0

/datum/action/cooldown/spell/healing/hunt
	base_healing = REDMOON_HUNT_HEAL_PER_TICK * REDMOON_MIRACLE_HEAL_TICKS
	blood_restoration = 0
	wound_modifier = 0

/datum/action/cooldown/spell/healing/proc/get_miracle_heal_per_tick(conditional_buff, situational_bonus)
	var/heal_per_tick = REDMOON_ACOLYTE_HEAL_PER_TICK
	if(istype(src, /datum/action/cooldown/spell/healing/greater))
		heal_per_tick = REDMOON_GREATER_HEAL_PER_TICK
	else if(istype(src, /datum/action/cooldown/spell/healing/hunt))
		heal_per_tick = REDMOON_HUNT_HEAL_PER_TICK
	if(conditional_buff)
		heal_per_tick += situational_bonus
	return heal_per_tick

/datum/action/cooldown/spell/healing/proc/miracle_blocked_by_embeds(mob/living/carbon/target)
	for(var/obj/item/embedded as anything in target.get_embedded_objects())
		if(istype(embedded, /obj/item/natural/worms/leech))
			continue
		return TRUE
	return FALSE

/datum/action/cooldown/spell/healing/proc/apply_miracle_healing_buff(mob/living/cast_on, heal_per_tick, situational_blood)
	var/effective_total = heal_per_tick * REDMOON_MIRACLE_HEAL_TICKS
	SEND_SIGNAL(owner, COMSIG_LIVING_HEALED_OTHER, effective_total)
	cast_on.apply_status_effect(STATUS_EFFECT_HEALING_MIRACLE, null, heal_per_tick, situational_blood)
