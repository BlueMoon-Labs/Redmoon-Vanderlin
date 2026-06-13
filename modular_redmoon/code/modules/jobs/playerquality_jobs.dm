/proc/redmoon_job_meets_pq(ckey, datum/job/job)
	if(!job)
		return TRUE
	#ifndef USES_PQ
	return TRUE
	#else
	var/player_pq = get_playerquality(ckey)
	if(!isnull(job.min_pq) && player_pq < job.min_pq)
		return FALSE
	if(!isnull(job.max_pq) && player_pq > job.max_pq)
		return FALSE
	return TRUE
	#endif

/datum/job/special_job_check(mob/dead/new_player/player)
	. = ..()
	if(!.)
		return FALSE
	if(player?.client && !redmoon_job_meets_pq(player.client.ckey, src))
		return FALSE
	return TRUE

/datum/job/advclass/check_requirements(mob/living/carbon/human/to_check, triumph_restriction_lift = FALSE)
	if(!..())
		return FALSE
	if(!redmoon_job_meets_pq(to_check.ckey, src))
		return FALSE
	return TRUE

/mob/dead/new_player/IsJobUnavailable(rank, latejoin = FALSE)
	. = ..()
	if(. != JOB_AVAILABLE)
		return .
	var/datum/job/job = SSjob.GetJob(rank)
	if(job && client && !redmoon_job_meets_pq(client.ckey, job))
		return JOB_UNAVAILABLE_QUALITY
	return .

/datum/controller/subsystem/job/check_job_eligibility(mob/dead/new_player/player, datum/job/job)
	. = ..()
	if(!.)
		return FALSE
	if(!redmoon_job_meets_pq(player.ckey, job))
		JobDebug("Eligibility failed: player quality, Player: [player], Job: [job.title], Min PQ: [job.min_pq], Max PQ: [job.max_pq]")
		return FALSE
	return TRUE

/datum/controller/subsystem/gamemode/get_candidates(be_special, job_ban, observers, ready_newplayers, living_players, required_time, inherit_required_time = TRUE, midround_antag_pref, no_antags = TRUE, list/restricted_roles, list/required_roles)
	. = ..()
	if(!length(.) || !be_special)
		return .
	var/datum/job/pq_job = SSjob.GetJob(be_special)
	if(!pq_job)
		return .
	var/list/filtered = list()
	for(var/mob/candidate as anything in .)
		if(redmoon_job_meets_pq(candidate.ckey, pq_job))
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
	if(!redmoon_job_meets_pq(player.ckey, migrant_job))
		return FALSE
	return TRUE

/proc/redmoon_job_unavailable_quality_message(jobtitle, ckey)
	var/datum/job/job = SSjob.GetJob(jobtitle)
	var/player_pq = get_playerquality(ckey)
	if(job && !isnull(job.min_pq) && player_pq < job.min_pq)
		return "You do not meet the Player Quality requirement for [jobtitle]. (Required: [job.min_pq], Your PQ: [player_pq])"
	if(job && !isnull(job.max_pq) && player_pq > job.max_pq)
		return "You exceed the Player Quality requirement for [jobtitle]. (Maximum: [job.max_pq], Your PQ: [player_pq])"
	return "[jobtitle] requires higher player quality."
