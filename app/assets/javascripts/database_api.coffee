class DatabaseApi
	constructor: ->
		@json_data = null
		@categories = []
		@users = []
		@posts = []

	flush: =>
		@json_data = null
		@categories = []
		@users = []
		@posts = []


	saveJsonData: (json_data) ->
		@json_data = json_data

	getCategories: =>
		@categories.add( new Category(
										"Mechanicy",
										"Zespol mechanikow zajmujacych sie mechanika",
										1
									))
		@categories.add( new Category(
										"Elektronicy",
										"Zespol elektronikow zajmujacych sie elektronika",
										2
									))
		@categories.add( new Category(
										"Zarzad",
										"Najwiecej gadaja a najmniej robia",
										3
									))
		@categories

	getUsers: =>
		@users.add( new User(
								"Jedrek",
								"Siemienski",
								"Absolwent polibudy bla bla",
								[2, 3], 1
							))
		@users.add( new User(
								"Michal",
								"Banasiak",
								"Artysta programista i mechanik pierwszej wody",
								[1, 3], 2
							))
		@users.add( new User(
								"Mechanik",
								"Nowak",
								"Super mechanior",
								[1], 3
							))
		@users.add( new User(
								"Elektronik",
								"Kowalski",
								"Elektronik jak ta lala",
								[2], 4
							))
		@users.add( new User(
								"Prezes",
								"Zarzadu",
								"Imie mowi samo za siebie",
								[3], 
								5
							))
		@users

	getPosts: =>
		@posts.add( new Post(
								"Zaczynamy!",
								"Dzisiaj zaczelismy prace nad mechanika",
								1, 2, 1
							))
		@posts.add( new Post(
								"Zaczynamy!",
								"Dzisiaj zaczelismy prace nad elektronika",
								2, 1, 2
							))
		@posts.add( new Post(
								"Zaczynamy!",
								"Zagonilismy frajernie do pracy!",
								3, 5, 3
							))
		@posts.add( new Post(
								"Idzie spoko!",
								"Juz mamy wszystkie katowniki",
								1, 2, 4
							))

		@posts


### database api 
	getCategories: =>
		$.ajax({
			url: '/getCategories.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@categories = []
		for item in @json_data
			@categories.add( new Category(
											item.name,
											item.description,
											item.id
										))
		@categories

	getUsers: =>
		$.ajax({
			url: '/getUsers.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@users = []
		for item in @json_data
			@users.add( new User(
									item.firstName,
									item.secondName,
									item.description,
									item.categories,
									item.id
								))
		@users

	getPosts: =>
		$.ajax({
			url: '/getPostss.json',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})
		@posts = []
		for item in @json_data
			@posts.add( new Post(
									item.title,
									item.content,
									item.category_id,
									item.autor_id,
									item.id
								))
		@posts
###