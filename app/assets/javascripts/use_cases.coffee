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
		@currentUser = null
		@currentImages = []
		@currentImage = null

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

	showCreatingPostsSection: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)	

	createPost: (form) =>
		@currentPosts = new Post(
									form.title.value,
									form.content.value,
									@currentCategory.id,
								)

	showAddingImageSection: (category_id) =>
		@currentCategory = @categories.find((category) -> category.id == category_id)

	addImage: (form) =>
		@currentImage = new Image(
									form.title.value,
									form.description.value,
									form.url.value,
									@currentCategory.id,
								)

	showRegisterSection: () =>

	register: (form) =>
		ids = []
		for radio in form.radio
			if(radio.checked and radio.value == "in")
				ids.push(parseInt(radio.name))
		@currentUser = new User(
									form.first_name.value,
									form.second_name.value,
									form.description.value,
									ids
								)
###		
	constructor: (@firstName, @secondName, @description, @categories, @id) ->
###