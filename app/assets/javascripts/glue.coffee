class Glue
	constructor: (@useCase, @gui, @storage)->
		AutoBind(@gui, @useCase)

		Before(@useCase, 'init', => @storage.getCategories())
		Before(@useCase, 'init', => @storage.getUsers())
		Before(@useCase, 'init', => @storage.getPosts())

		Before(@useCase, 'showHomePage', => @gui.clearAll())
		After(@useCase, 'showHomePage', => @gui.showDropdownMenu())		
#		After(@useCase, 'showHomePage', => @gui.showHomePage())		

		LogAll(@useCase)
		LogAll(@gui)
