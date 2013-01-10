class Gui
	constructor: ->

	clearAll: =>
		$("#home-page").html("")

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
				button.links.push(category.name)

		html = template(data)
		$("#dropdown-buttons-menu").html(html)

	showHomePage: =>
		source = $("#home-page-template").html()
		template = Handlebars.compile(source)
		data = {}
		html = template(data)
		$("#home-page").html(html)
