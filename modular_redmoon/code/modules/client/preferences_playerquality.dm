/datum/preferences/set_antag(mob/user)
	var/list/dat = list()
	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"
	dat += "<center><a href='?_src_=prefs;preference=antag;task=close' style='display:block;margin-bottom:2px'>Done</a></center>"
	dat += "<h2 style='margin:5;padding:5;line-height:1.2'>Villains</h2>"
	if(is_total_antag_banned(user.ckey))
		dat += "<font color=red><b>I am banned from antagonist roles.</b></font><br>"
		src.be_special = list()
	for(var/i in GLOB.special_roles_rogue)
		var/datum/job/pq_job = SSjob.GetJob(i)
		if((i in be_special) && pq_job && !redmoon_job_meets_pq(user.ckey, pq_job))
			be_special -= i
		if(is_antag_banned(user.ckey, i))
			dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;bancheck=[i]'>BANNED</a><br>"
		else
			if(pq_job && !redmoon_job_meets_pq(user.ckey, pq_job))
				dat += "<b>[capitalize(i)]:</b> <font color=red>Requires [pq_job.min_pq] PQ (yours: [get_playerquality(user.ckey)])</font><br>"
				continue
			var/days_remaining = null
			if(ispath(GLOB.special_roles_rogue[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs))
				days_remaining = get_remaining_days(user.client)
			if(days_remaining)
				dat += "<b>[capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS__~~\]~~__</font><br>"
			else
				dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=antag;task=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"

	var/list/vessel_ids = GLOB.vessel_ids
	var/list/available_vessel_ids = list()
	for(var/id in vessel_ids)
		if(user.client.is_whitelisted(id))
			available_vessel_ids += id

	if(length(available_vessel_ids))
		dat += "<h2 style='margin:5;padding:5;line-height:1.2'>Vessels</h2>"
		for(var/id in available_vessel_ids)
			var/enabled = (id in be_special)
			dat += "<b>[id]:</b> <a href='?_src_=prefs;preference=antag;task=be_special;be_special_type=[id]'>[enabled ? "Enabled" : "Disabled"]</a><br>"

	dat += "</body>"
	var/datum/browser/noclose/popup = new(user, "antag_setup", "<div align='center'>Special Roles</div>", 265, 340)
	popup.set_window_options(can_close = FALSE)
	popup.set_content(dat.Join())
	popup.open(use_onclose = FALSE)

/datum/preferences/proc/redmoon_block_be_special_pq(mob/user, list/href_list)
	if(href_list["preference"] != "antag" || href_list["task"] != "be_special")
		return FALSE
	var/be_special_type = href_list["be_special_type"]
	if(!be_special_type || (be_special_type in be_special))
		return FALSE
	var/datum/job/pq_job = SSjob.GetJob(be_special_type)
	if(!pq_job || redmoon_job_meets_pq(user.ckey, pq_job))
		return FALSE
	to_chat(user, span_warning("[be_special_type] requires at least [pq_job.min_pq] player quality (you have [get_playerquality(user.ckey)])."))
	set_antag(user)
	update_menu_data(user)
	build_and_show_menu(user)
	return TRUE
