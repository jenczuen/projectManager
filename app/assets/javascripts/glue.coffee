class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)

		Before(@useCase, 'init', => @storage.getCategories())
		Before(@useCase, 'init', => @storage.getUsers())
		Before(@useCase, 'init', => @storage.getPosts())
		Before(@useCase, 'init', => @useCase.setInitialCategories(@storage.categories))
		Before(@useCase, 'init', => @useCase.setInitialUsers(@storage.users))
		Before(@useCase, 'init', => @useCase.setInitialPosts(@storage.posts))
		Before(@useCase, 'init', => @storage.flush())

		Before(@useCase, 'showHomePage', => @gui.clearAll())
		After(@useCase, 'showHomePage', => @gui.showDropdownMenu(@useCase.categories))

		Before(@useCase, 'showBlog', => @gui.clearAll())
		After(@useCase, 'showBlog', => @gui.showBlog(@useCase.currentCategory, @useCase.currentPosts))

		Before(@useCase, 'showMembers', => @gui.clearAll())
		After(@useCase, 'showMembers', => @gui.showMembers(@useCase.currentCategory, @useCase.currentUsers))

		LogAll(@useCase)
		LogAll(@gui)
