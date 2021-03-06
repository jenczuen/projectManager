class Gui
	constructor: ->

	clearAll: =>
		$("#content").html("")

	showHeader: =>
		source = $("#header-template").html()
		template = Handlebars.compile(source)
		data = {}
		html = template(data)
		$("#header").html(html)

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
									function_name: "useCase.showGallery("+category.id+")"
								})
		###czlonkowie###
		for category in categories
			data.buttons[2].links.push({
									category: category.name,
									function_name: "useCase.showMembers("+category.id+")"
								})

		html = template(data)
		$("#dropdown-buttons-menu").html(html)

	showBlog: (category, posts) =>
		$('#content').append('<div id="blog"></div>')
		source = $("#blog-template").html()
		template = Handlebars.compile(source)
		data = { 
					category: category.name
					function_name: "useCase.showCreatingPostsSection("+category.id+")"
					posts: []
				}
		for post in posts
			data.posts.push({
								title: post.title,
								content: post.content
							})

		html = template(data)
		$("#blog").html(html)

	showGallery: (category, images) =>
		$('#content').append('<div id="gallery"></div>')
		source = $("#gallery-template").html()
		template = Handlebars.compile(source)
		data = { 
					category: category.name
					function_name: "useCase.showAddingImageSection("+category.id+")"
					images: []
				}
		console.log(images)
		for image in images
			data.images.push({
								title: image.title,
								description: image.description,
								url: image.url
							})
		html = template(data)
		$("#gallery").html(html)

	showMembers: (category, users) =>
		$('#content').append('<div id="members"></div>')
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

	showLoginSection: (user) =>
		$('#content').append('<div id="login-section"></div>')
		source = $("#login-section-template").html()
		template = Handlebars.compile(source)
		data = { 
					test: "test"
				}
		html = template(data)
		$("#login-section").html(html)

	showCreatingPostsSection: (category) =>
		$('#content').append('<div id="creating-posts-section"></div>')
		source = $("#creating-posts-section-template").html()
		template = Handlebars.compile(source)
		data = { category: category.name }
		html = template(data)
		$("#creating-posts-section").html(html)

	showAddingImageSection: (category) =>
		$('#content').append('<div id="adding-image-section"></div>')
		source = $("#adding-image-section-template").html()
		template = Handlebars.compile(source)
		data = { category: category.name }
		html = template(data)
		$("#adding-image-section").html(html)

	showRegisterSection: (categories) =>
		$('#content').append('<div id="register-section"></div>')
		source = $("#register-section-template").html()
		template = Handlebars.compile(source)
		data = { categories: []}
		for category in categories
			data.categories.push({
									name: category.name
									id: category.id
								})
		html = template(data)
		$("#register-section").html(html)
