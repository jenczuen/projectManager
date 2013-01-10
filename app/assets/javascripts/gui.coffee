class Gui
	constructor: ->

	clearAll: =>
		$("#content").html("")

	showDropdownMenu: (categories) =>
		source = $("#dropdown-buttons-menu-template").html()
		template = Handlebars.compile(source)
		data = { buttons: [
							{ name: "Blog"		, links: [] },
							{ name: "Galeria"	, links: [] },
							{ name: "Czlonkowie", links: [] }
						]}
		for button in data.buttons
			for category in categories
				button.links.push({
									category: category.name,
									function_name: "useCase.showBlog("+category.id+")"
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
