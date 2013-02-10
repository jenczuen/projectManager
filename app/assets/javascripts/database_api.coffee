class DatabaseApi
	constructor: ->
		@json_data = null
		@categories = []
		@users = []
		@posts = []
		@images = []

	flush: =>
		@json_data = null
		@categories = []
		@users = []
		@posts = []
		@images = []

	saveJsonData: (json_data) ->
		@json_data = json_data

	getCategories: =>
		$.ajax({
			url: '/api/categories/all',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})

		for category in @json_data
		    @categories.add( new Category(category.name,category.description,category.id))

		@categories

	getUsers: =>
		$.ajax({
			url: '/api/users/all',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})

		for user in @json_data
		    userCategories=[]
		    
		    for category in user.categories
		    	userCategories.add(category.id)
		    
		    @users.add(new User(user.firstName,user.secondName,user.description,userCategories,user.id))

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

	getImages: =>
		@images.add( new Image(
								"Obrazek1",
								"Wesoly opis1",
								"url/do/obrazka", 
								1, 1
							))
		@images.add( new Image(
								"Obrazek2",
								"Wesoly opis2",
								"url/do/obrazka", 
								2, 2
							))
		@images.add( new Image(
								"Obrazek3",
								"Wesoly opis3",
								"url/do/obrazka", 
								3, 3
							))
		@images.add( new Image(
								"Obrazek4",
								"Wesoly opis4",
								"url/do/obrazka", 
								3, 4
							))

		@images


### database api 
	getCategories: =>
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