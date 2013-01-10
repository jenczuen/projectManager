class Gui
	constructor: ->

	clearAll: =>
		$("#home-page").html("")

	showDropdownMenu: =>
		source = $("#dropdown-buttons-menu-template").html()
		template = Handlebars.compile(source)
		data = { buttons: [
							{ 
								name: "Blog",
								links: [
											"Mechanicy",
											"Elektronicy",
											"Programisci"
										]
							},
							{ 
								name: "Galeria",
								links: [
											"Mechanicy",
											"Elektronicy",
											"Programisci"
										]
							},
							{ 
								name: "Czlonkowie",
								links: [
											"Mechanicy",
											"Elektronicy",
											"Programisci"
										]
							}
						]}
		html = template(data)
		$("#dropdown-buttons-menu").html(html)

	showHomePage: =>
		source = $("#home-page-template").html()
		template = Handlebars.compile(source)
		data = {}
		html = template(data)
		$("#home-page").html(html)
