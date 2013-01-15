class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)


		Before(@useCase, 'init', => @storage.getCategories())
		Before(@useCase, 'init', => @storage.getUsers())
		Before(@useCase, 'init', => @storage.getPosts())
		Before(@useCase, 'init', => @storage.getImages())
		Before(@useCase, 'init', => @useCase.setInitialCategories(@storage.categories))
		Before(@useCase, 'init', => @useCase.setInitialUsers(@storage.users))
		Before(@useCase, 'init', => @useCase.setInitialPosts(@storage.posts))
		Before(@useCase, 'init', => @useCase.setInitialImages(@storage.images))
		Before(@useCase, 'init', => @storage.flush())


		Before(@useCase, 'showHomePage', => @gui.clearAll())
		After(@useCase, 'showHomePage', => @gui.showHeader())
		After(@useCase, 'showHomePage', => @gui.showDropdownMenu(@useCase.categories))
		After(@useCase, 'showHomePage', => @gui.showLoginSection(@useCase.currentUser))


		Before(@useCase, 'showBlog', => @gui.clearAll())
		After(@useCase, 'showBlog', => @gui.showBlog(@useCase.currentCategory, @useCase.currentPosts))
		After(@useCase, 'showBlog', => @gui.showLoginSection(@useCase.currentUser))


		Before(@useCase, 'showGallery', => @gui.clearAll())
		After(@useCase, 'showGallery', => @gui.showGallery(@useCase.currentCategory, @useCase.currentImages))
		After(@useCase, 'showGallery', => @gui.showLoginSection(@useCase.currentUser))

		
		Before(@useCase, 'showMembers', => @gui.clearAll())
		After(@useCase, 'showMembers', => @gui.showMembers(@useCase.currentCategory, @useCase.currentUsers))
		After(@useCase, 'showMembers', => @gui.showLoginSection(@useCase.currentUser))


		Before(@useCase, 'showCreatingPostsSection', => @gui.clearAll())
		After(@useCase, 'showCreatingPostsSection', => @gui.showCreatingPostsSection(@useCase.currentCategory))
		After(@useCase, 'showCreatingPostsSection', => @gui.showLoginSection(@useCase.currentUser))


		### to czeka na podpiecie do api ###
		After(@useCase, 'createPost', => useCase.posts.push(useCase.currentPosts))
		### end ###
		After(@useCase, 'createPost', => useCase.showBlog(useCase.currentCategory.id))


		Before(@useCase, 'showAddingImageSection', => @gui.clearAll())
		After(@useCase, 'showAddingImageSection', => @gui.showAddingImageSection(@useCase.currentCategory))
		After(@useCase, 'showAddingImageSection', => @gui.showLoginSection(@useCase.currentUser))


		### to czeka na podpiecie do api ###
		After(@useCase, 'addImage', => useCase.images.push(useCase.currentImage))
		### end ###
		After(@useCase, 'addImage', => useCase.showGallery(useCase.currentCategory.id))

		Before(@useCase, 'showRegisterSection', => @gui.clearAll())
		After(@useCase, 'showRegisterSection', => gui.showRegisterSection(useCase.categories))


		### to czeka na podpiecie do api ###
		After(@useCase, 'register', => useCase.users.push(useCase.currentUser))
		### end ###
		After(@useCase, 'register', => useCase.showHomePage())


		LogAll(@useCase)
		LogAll(@gui)