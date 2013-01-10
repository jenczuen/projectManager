class DatabaseApi
	constructor: ->
		@json_data = null
		@categories = null
		@users = null
		@posts = null

	saveJsonData: (json_data) ->
		@json_data = json_data

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
			url: '/getPosts.json',
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

	flush: =>
		@json_data = null
		@categories = null
		@users = null
		@posts = null
