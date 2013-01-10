class Gui
	constructor: ->

	clearAll: =>
		$("#blog").html("")
		$("#members").html("")

	showDropdownMenu: (categories) =>
		source = $("#dropdown-buttons-menu-template").html()
		template = Handlebars.compile(source)
		data = { buttons: [
							{ name: "Blog"		, links: [] },
							{ name: "Galeria"	, links: [] },
							{ name: "Ludzie", links: [] }
						]}
		###blog###
		for category in categories
			data.buttons[0].links.push({
									category: category.name,
									function_name: "useCase.showBlog("+category.id+")"
								})
		###galeria###
		for category in categories
			data.buttons[1].links.push({
									category: category.name,
									function_name: ""
								})
		###czlonkowie###
		for category in categories
			data.buttons[2].links.push({
									category: category.name,
									function_name: "useCase.showMembers("+category.id+")"
								})

		html = template(data)
		$("#dropdown-buttons-menu").html(html)

	showHomePage: =>
		source = $("#home-page-template").html()
		template = Handlebars.compile(source)
		data = {}
		html = template(data)
		$("#home-page").html(html)

	showBlog: (category, posts) =>
		source = $("#blog-template").html()
		template = Handlebars.compile(source)
		data = { 
					category: category.name
					posts: []
				}
		for post in posts
			data.posts.push({
								title: post.title,
								content: post.content
							})

		html = template(data)
		$("#blog").html(html)

	showMembers: (category, users) =>
		source = $("#members-template").html()
		template = Handlebars.compile(source)
		data = { 
					category: category.name
					members: []
				}
		for user in users
			data.members.push({
								firstName: user.firstName,
								secondName: user.secondName,
								description: user.description
							})

		html = template(data)
		$("#members").html(html)
