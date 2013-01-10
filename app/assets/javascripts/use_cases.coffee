class UseCases
	constructor: ->
		@categories = []
		@users = []
		@posts = []
		@images = []
		@currentCategory = null
		@currentPosts = []
		@currentPost = null
		@currentUsers = []
		@currentImages = []

	setInitialCategories: (categories) =>
		@categories = categories

	setInitialUsers: (users) =>
		@users = users

	setInitialPosts: (posts) =>
		@posts = posts

	setInitialImages: (images) =>
		@images = images

	init: =>

	showHomePage: =>

	showBlog: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)
		@currentPosts = @posts.filter (post) -> post.category_id == category_id

	showGallery: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)
		@currentImages = @images.filter (image) -> image.category_id == category_id

	showMembers: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)
		@currentUsers = @users.filter (user) -> user.categories.indexOf(category_id) != -1 