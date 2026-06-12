/proc/redmoon_meets_pq(ckey, required_pq)
	if(!required_pq)
		return TRUE
	#ifdef USES_PQ
	return get_playerquality(ckey) >= required_pq
	#else
	return TRUE
	#endif

/proc/get_redmoon_antag_pq_requirement(antag_flag)
	switch(antag_flag)
		if(ROLE_BANDIT)
			return 25
		if(ROLE_WRETCH)
			return 50
	return 0

/proc/get_redmoon_job_pq_requirement(datum/job/job)
	if(!job)
		return 0
	if(istype(job, /datum/job/lunatic) || job.title == JOB_LUNATIC)
		return 75
	if(istype(job, /datum/job/bandit) || job.title == ROLE_BANDIT)
		return 25
	var/datum/job/advclass/advclass = job
	if(istype(advclass))
		if(CTAG_BANDIT in advclass.category_tags)
			return 25
		if(CTAG_WRETCH in advclass.category_tags)
			return 50
	return 0

/datum/job/special_job_check(mob/dead/new_player/player)
	. = ..()
	if(!.)
		return FALSE
	var/required_pq = get_redmoon_job_pq_requirement(src)
	if(required_pq && player?.client && !redmoon_meets_pq(player.client.ckey, required_pq))
		return FALSE
	return TRUE

/datum/job/advclass/check_requirements(mob/living/carbon/human/to_check, triumph_restriction_lift = FALSE)
	if(!..())
		return FALSE
	var/required_pq = get_redmoon_job_pq_requirement(src)
	if(required_pq && !redmoon_meets_pq(to_check.ckey, required_pq))
		return FALSE
	return TRUE

/mob/dead/new_player/IsJobUnavailable(rank, latejoin = FALSE)
	. = ..()
	if(. != JOB_AVAILABLE)
		return .
	var/datum/job/job = SSjob.GetJob(rank)
	var/required_pq = get_redmoon_job_pq_requirement(job)
	if(required_pq && client && !redmoon_meets_pq(client.ckey, required_pq))
		return JOB_UNAVAILABLE_QUALITY
	return .

/datum/controller/subsystem/job/check_job_eligibility(mob/dead/new_player/player, datum/job/job)
	. = ..()
	if(!.)
		return FALSE
	var/required_pq = get_redmoon_job_pq_requirement(job)
	if(required_pq && !redmoon_meets_pq(player.ckey, required_pq))
		JobDebug("Eligibility failed: player quality, Player: [player], Job: [job.title], Required: [required_pq]")
		return FALSE
	return TRUE

/datum/controller/subsystem/gamemode/get_candidates(be_special, job_ban, observers, ready_newplayers, living_players, required_time, inherit_required_time = TRUE, midround_antag_pref, no_antags = TRUE, list/restricted_roles, list/required_roles)
	. = ..()
	if(!length(.) || !be_special)
		return .
	var/required_pq = get_redmoon_antag_pq_requirement(be_special)
	if(!required_pq)
		return .
	var/list/filtered = list()
	for(var/mob/candidate as anything in .)
		if(redmoon_meets_pq(candidate.ckey, required_pq))
			filtered += candidate
	return filtered

/datum/controller/subsystem/migrants/can_be_role(client/player, role_type)
	. = ..()
	if(!.)
		return FALSE
	var/datum/migrant_role/role = MIGRANT_ROLE(role_type)
	if(!role)
		return FALSE
	var/datum/job/migrant_job = SSjob.GetJobType(role.migrant_job)
	if(!migrant_job)
		return FALSE
	var/required_pq = get_redmoon_job_pq_requirement(migrant_job)
	if(required_pq && !redmoon_meets_pq(player.ckey, required_pq))
		return FALSE
	if(migrant_job.antag_role)
		var/antag_type = migrant_job.antag_role::job_rank
		required_pq = get_redmoon_antag_pq_requirement(antag_type)
		if(required_pq && !redmoon_meets_pq(player.ckey, required_pq))
			return FALSE
	return TRUE
