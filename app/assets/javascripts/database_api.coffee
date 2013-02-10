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
		$.ajax({
			url: '/api/posts/all',
			async: false,
			dataType: 'json',
			success: (data, status) => @saveJsonData(data)
		})

		for post in @json_data
		    @posts.add(new Post(post.title,post.content,post.category_id,post.author_id,post.id))
		
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
