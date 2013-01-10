class UseCases
	constructor: ->
		@categories = []
		@users = []
		@posts = []
		@currentCategory = null
		@currentPosts = []
		@currentPost = null
		@currentUsers = []

	setInitialCategories: (categories) =>
		@categories = categories

	setInitialUsers: (users) =>
		@users = users

	setInitialPosts: (posts) =>
		@posts = posts

	init: =>

	showHomePage: =>

	showBlog: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)
		@currentPosts = @posts.filter (post) -> post.category_id == category_id

	showMembers: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)
		@currentUsers = @users.filter (user) -> user.categories.indexOf(category_id) != -1 