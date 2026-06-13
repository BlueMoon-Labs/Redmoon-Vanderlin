/**
 * Discord round announcements via TGS embeds.
 * Ported from Redmoon-Peak roundspoke.dm with Vanderlin stats/config integration.
 */

/proc/roundspoke_enabled()
	return CONFIG_GET(flag/roundspoke_enabled) && world.TgsAvailable()

/proc/roundspoke_channel()
	var/channel = CONFIG_GET(string/roundspoke_channel_tag)
	if(!channel)
		channel = CONFIG_GET(string/chat_announce_new_game)
	return channel || "status"

/proc/roundspoke_send(datum/tgs_message_content/message)
	if(!roundspoke_enabled() || !message)
		return FALSE
	send2chat(message, roundspoke_channel())
	return TRUE

/proc/roundspoke_make_author()
	var/datum/tgs_chat_embed/provider/author/author = new(CONFIG_GET(string/roundspoke_author_name))
	var/icon_url = CONFIG_GET(string/roundspoke_author_icon_url)
	if(icon_url)
		author.icon_url = icon_url
	return author

/proc/roundspoke_load_media_links()
	var/file_path = CONFIG_GET(string/roundspoke_media_file)
	if(!file_path || !fexists(file_path))
		return null

	var/list/media_json = json_decode(file2text(file_path))
	if(!length(media_json))
		return null

	var/list/contents = list()
	for(var/list/entry as anything in media_json)
		if(entry["content"])
			contents += entry["content"]
	return length(contents) ? contents : null

/proc/roundspoke_pick_lore_line()
	return pick(GLOB.roundspoke_lore_quotes)

/proc/roundspoke_format_monarch_patron(patron_name)
	if(patron_name == "No Ruler")
		return "Нет правителя"
	return patron_name

/proc/roundspoke_format_gods_summary()
	var/max_influence = -INFINITY
	var/max_chosen = 0
	var/datum/storyteller/most_influential
	var/datum/storyteller/most_frequent

	for(var/storyteller_name in SSgamemode.storytellers)
		var/datum/storyteller/initialized_storyteller = SSgamemode.storytellers[storyteller_name]
		if(!initialized_storyteller)
			continue

		var/influence = SSgamemode.calculate_storyteller_influence(initialized_storyteller.type)
		if(influence > max_influence)
			max_influence = influence
			most_influential = initialized_storyteller

		if(initialized_storyteller.times_chosen > max_chosen)
			max_chosen = initialized_storyteller.times_chosen
			most_frequent = initialized_storyteller

	if(max_influence <= 0 && max_chosen <= 0)
		return "Боги не проявляли влияния"
	if(most_influential == most_frequent && max_influence > 0)
		return "Наиболее доминирующий покровитель: [most_influential.name]"
	var/list/parts = list()
	if(max_influence > 0)
		parts += "Покровитель-блюститель деца: [most_influential.name] ([max_influence] влияния)"
	if(max_chosen > 0)
		parts += "Покровитель деца: [most_frequent.name] ([max_chosen] верослужителей)"
	return parts.Join(" ")

/proc/roundspoke_format_jobs_summary()
	var/list/job_lines = list()
	for(var/datum/job/target_job as anything in SSjob.all_occupations)
		if(target_job.current_positions > 0)
			job_lines += "[target_job.title] - [target_job.current_positions]"
	return length(job_lines) ? job_lines.Join(" | ") : "Никто не трудился"

/proc/roundspoke_send_roundstart_media()
	var/list/media_links = roundspoke_load_media_links()
	if(!length(media_links))
		return
	roundspoke_send(new /datum/tgs_message_content(pick(media_links)))

/proc/roundspoke_announce_round_start()
	var/role_ping = CONFIG_GET(string/roundspoke_discord_role)
	var/join_url = CONFIG_GET(string/roundspoke_join_url)
	var/map_name = CONFIG_GET(string/stationname) || "Вандерлин"

	var/announcement = "Я собираю людей для новой партии прямо сейчас!"
	if(role_ping)
		announcement += " <@&[role_ping]>"

	var/datum/tgs_message_content/message = new(announcement)
	var/datum/tgs_chat_embed/structure/embed = new()
	message.embed = embed
	embed.title = "Начинается новая история!"
	embed.description = "Новая сессия на [map_name] начнётся примерно через пять-десять минут."
	embed.colour = "#ff0000"
	embed.author = roundspoke_make_author("Ксайликс собирает игроков на сессию")
	embed.fields = list(
		new /datum/tgs_chat_embed/field("Ксайликс говорит:", roundspoke_pick_lore_line()),
		new /datum/tgs_chat_embed/field("Заходи на сервер!", join_url || "byond://[world.internet_address]:[world.port]")
	)

	if(!roundspoke_send(message))
		return

	var/list/media_links = roundspoke_load_media_links()
	if(length(media_links))
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(roundspoke_send_roundstart_media)), 5 SECONDS)

/world/TgsInitializationComplete()
	. = ..()
	roundspoke_announce_round_start()

/proc/roundspoke_send_round_end()
	if(!roundspoke_enabled())
		return

	var/stats = GLOB.vanderlin_round_stats
	var/total_population = stats[STATS_TOTAL_POPULATION]
	var/percent_of_males = total_population ? PERCENT(stats[STATS_MALE_POPULATION] / total_population) : 0
	var/percent_of_females = total_population ? PERCENT(stats[STATS_FEMALE_POPULATION] / total_population) : 0
	var/percent_of_other = total_population ? PERCENT(stats[STATS_OTHER_GENDER] / total_population) : 0
	var/literacy_rate = total_population ? round((1 - (stats[STATS_ILLITERATES] / total_population)) * 100) : 0

	var/end_reason = SSticker.get_round_end_reason()
	if(!end_reason)
		end_reason = "[SSmapping.config?.map_name || "Поселение"] пережило ещё одну неделю."

	var/datum/tgs_message_content/message = new("...вот и сказочке конец.")
	var/datum/tgs_chat_embed/structure/embed = new()
	message.embed = embed
	embed.author = roundspoke_make_author("Ксайликс объявляет результаты")
	embed.title = "Партия длилась [gameTimestamp("hh:mm:ss", world.time - SSticker.round_start_time)]."
	embed.description = end_reason
	embed.colour = "#f19a37"
	embed.footer = new /datum/tgs_chat_embed/footer("Раунд [GLOB.rogue_round_id] · [SSmapping.config?.map_name || "Вандерлин"]")

	var/ruler_label = SSmapping.config?.monarch_title || "Правитель"
	var/monarch_patron = roundspoke_format_monarch_patron(stats[STATS_MONARCH_PATRON])

	embed.fields = list(
		new /datum/tgs_chat_embed/field("💀 Смертей", "[stats[STATS_DEATHS]]"),
		new /datum/tgs_chat_embed/field("🩸 Крови пролито", "[round(stats[STATS_BLOOD_SPILT] / 100, 1)]L"),
		new /datum/tgs_chat_embed/field("🏆 Триумфов получено", "[stats[STATS_TRIUMPHS_AWARDED]]"),
		new /datum/tgs_chat_embed/field("🕵️ Триумфов украдено", "[stats[STATS_TRIUMPHS_STOLEN] * -1]"),
		new /datum/tgs_chat_embed/field("💋 Поцелуев", "[stats[STATS_KISSES_MADE]]"),
		new /datum/tgs_chat_embed/field("✝️ Исповедники", "[GLOB.confessors.len]"),
		new /datum/tgs_chat_embed/field("👻 Заблудшие души", "[GLOB.player_list.len]"),
		new /datum/tgs_chat_embed/field("🧔 Мужчины", "[stats[STATS_MALE_POPULATION]] ([percent_of_males]%)"),
		new /datum/tgs_chat_embed/field("👩 Женщины", "[stats[STATS_FEMALE_POPULATION]] ([percent_of_females]%)"),
		new /datum/tgs_chat_embed/field("🏳️‍⚧️ Другие", "[stats[STATS_OTHER_GENDER]] ([percent_of_other]%)"),
		new /datum/tgs_chat_embed/field("💎 Боги", roundspoke_format_gods_summary()),
		new /datum/tgs_chat_embed/field("✨ Воскрешений", "[stats[STATS_ASTRATA_REVIVALS] + stats[STATS_LUX_REVIVALS] + stats[STATS_CPR_REVIVALS]]"),
		new /datum/tgs_chat_embed/field("🙏 Молитв", "[stats[STATS_PRAYERS_MADE]]"),
		new /datum/tgs_chat_embed/field("🌊 Утонуло", "[stats[STATS_PEOPLE_DROWNED]]"),
		new /datum/tgs_chat_embed/field("👜 Карманных краж", "[stats[STATS_ITEMS_PICKPOCKETED]]"),
		new /datum/tgs_chat_embed/field("🍷 Алкоголя выпито", "[stats[STATS_ALCOHOL_CONSUMED]]"),
		new /datum/tgs_chat_embed/field("💊 Наркотиков", "[stats[STATS_DRUGS_SNORTED]]"),
		new /datum/tgs_chat_embed/field("🐟 Рыбы поймано", "[stats[STATS_FISH_CAUGHT]]"),
		new /datum/tgs_chat_embed/field("🌳 Деревьев срублено", "[stats[STATS_TREES_CUT]]"),
		new /datum/tgs_chat_embed/field("🌿 Урожая собрано", "[stats[STATS_PLANTS_HARVESTED]]"),
		new /datum/tgs_chat_embed/field("📖 Грамотность", "[literacy_rate]%"),
		new /datum/tgs_chat_embed/field("👑 Двор", "[ruler_label]: [monarch_patron] | Дворян: [stats[STATS_ALIVE_NOBLES]] | Гарнизон: [stats[STATS_ALIVE_GARRISON]] | Духовенство: [stats[STATS_ALIVE_CLERGY]]"),
		new /datum/tgs_chat_embed/field("🧝 Расы (север)", "Люди: [stats[STATS_ALIVE_NORTHERN_HUMANS]] | Дварфы: [stats[STATS_ALIVE_DWARVES]] | Эльфы: [stats[STATS_ALIVE_SNOW_ELVES]] | Полуэльфы: [stats[STATS_ALIVE_HALF_ELVES]] | Полудроу: [stats[STATS_ALIVE_HALF_DROWS]]"),
		new /datum/tgs_chat_embed/field("🧝 Расы (юг и прочие)", "Тёмные эльфы: [stats[STATS_ALIVE_DARK_ELVES]] | Полуорки: [stats[STATS_ALIVE_HALF_ORCS]] | Тифлинги: [stats[STATS_ALIVE_TIEFLINGS]] | Кобольды: [stats[STATS_ALIVE_KOBOLDS]]"),
		new /datum/tgs_chat_embed/field("🧝 Расы (экзотика)", "Аасимары: [stats[STATS_ALIVE_AASIMAR]] | Ракшари: [stats[STATS_ALIVE_RAKSHARI]] | Тритоны: [stats[STATS_ALIVE_TRITONS]] | Харпии: [stats[STATS_ALIVE_HARPIES]] | Холлоукины: [stats[STATS_ALIVE_HOLLOWKINS]]"),
		new /datum/tgs_chat_embed/field("💼 Уделы", roundspoke_format_jobs_summary())
	)

	roundspoke_send(message)

GLOBAL_LIST_INIT(roundspoke_lore_quotes, list(
	"О-о-о? Что это? Начало игры?",
	"Это для меня? Начало игры?",
	"ИГРА НАЧАЛАСЬ! :)",
	"Давно-давно... началась история, произошедшая в славном городе Алая Пиковая Вершина.",
	"Уэ. Новый раунд или что-то вроде того.",
	"Я всегда возвращаюсь вместе с новой партией.",
	"Мы начинаем новую партию!",
	"Время для новой истории!",
	"Я должна признаться. Вы мои любимые слушатели.",
	"Тишина, дитя человеческое, у меня есть история для тебя...",
	"Партия начинается. Вы встретились в та...раске...",
	"Нет конца, нет конца, нет конца, нет конца...",
	"Убивать. Насиловать. Предавать.",
	"Пора начинать партию!",
	"Партия начинается. Вы встретились в таверне, мои чуваки.",
	",g Мы начали партию.",
	"Партия начинается, встречаемся в таверне.",
	"Нельзя, запрещено.",
	"Только для Айко.",
	"Айко - лучшая девочька.",
	"Только для крутышей.",
	"Убейся.",
	"11010000 10111100 11010000 10110000 11010001 10000010 11010001 10001100 100000 11010000 10110101 11010000 10110001 11010000 10110000 11010000 10111011",
	"А я всё думал, когда же ты появишься.",
	"Хочу джамбургер.",
	"Сегодня нас атакуют танки, авиация и корабли. А знаете, где ещё есть танки, авиация и корабли? Конечно же, в Гром Войны.",
	"Сегодня нас атакуют мехи, пехтура и шизофрения. А знаете, где ещё есть мехи, пехтура и шизофрения? Конечно же, в Война Лицо.",
	"Ты мне сейчас не поверишь, но там ебать сколько посуды, которая сама себя никак не вымоет.",
	"B чём сила, брат? В ОМах.",
	"В чём сопротивление, брат? В острых козырьках.",
	"В чём измеряют напряжение, брат? В Томасах Шелби.",
	"We can't expect god to do all the work.",
	"Заканчивай свой звонок и поцелуй меня в сладкие уста. Романтики хочется.",
	"Не надо делать мне как лучше, оставьте мне как хорошо.",
	"Я не хотела Вас обидеть, случайно просто повезло.",
	"Поскольку времени немного, я вкратце матом объясню.",
	"Башка сегодня отключилась, не вся, конечно, - есть могу.",
	"Следить стараюсь за фигурой, чуть отвлекусь - она жует.",
	"Шаман за скверную погоду недавно в бубен получил.",
	"Всё вроде с виду в шоколаде, но если внюхаться - то нет.",
	"Обидеть Таню может каждый, не каждый может убежать.",
	"Ищу приличную работу, но чтоб не связана с трудом.",
	"Мои намеренья прекрасны, пойдёмте, тут недалеко.",
	"Я за тебя переживаю - вдруг у тебя всё хорошо.",
	"Держи вот этот подорожник - щас врежу, сразу приложи.",
	"Я понимаю, что Вам нечем, но всё ж попробуйте понять.",
	"Мы были б идеальной парой, конечно, если бы не ты.",
	"Как говорится, всё проходит, но может кое-что застрять.",
	"Кого хочу я осчастливить, тому спасенья уже нет.",
	"А ты готовить-то умеешь? — Я вкусно режу колбасу.",
	"Звони почаще - мне приятно на твой «пропущенный» смотреть.",
	"Зачем учить нас, как работать, вы научитесь как платить.",
	"Характер у меня тяжёлый, всё потому, что золотой.",
	"Чтоб дело мастера боялось, он знает много страшных слов.",
	"Вы мне хотели жизнь испортить? Спасибо, справилась сама.",
	"Её сбил конь средь изб горящих, она нерусскою была…",
	"Когда все крысы убежали, корабль перестал тонуть.",
	"Дела идут пока отлично, поскольку к ним не приступал.",
	"Работаю довольно редко, а недовольно каждый день.",
	"Была такою страшной сказка, что дети вышли покурить.",
	"Когда на планы денег нету, они становятся мечтой.",
	"Женат два раза неудачно - одна ушла, вторая - нет.",
	"Есть всё же разум во Вселенной, раз не выходит на контакт.",
	"Уж вроде ноги на исходе, а юбка всё не началась.",
	"Я попросил бы Вас остаться, но вы ж останетесь, боюсь.",
	"Для женщин нет такой проблемы, которой им бы не создать.",
	"Олегу не везёт настолько, что даже лифт идет в депо.",
	"Мы называем это жизнью, а это просто список дел.",
	"И жили счастливо и долго… он долго, счастливо она.",
	"Не копай противнику яму, сам туда ляжешь.",
	"В БОЙ!!!",
	"Поиграй со мной. ;з",
	"Кто глубоко скорбит - тот истово любил.",
))
