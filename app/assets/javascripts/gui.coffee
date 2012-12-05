class Gui
	constructor: ->

	clearAll: =>
		$("#home-page").html("")

	showHomePage: =>
		source = $("#home-page-template").html()
		template = Handlebars.compile(source)
		data = {}
		html = template(data)
		$("#home-page").html(html)
