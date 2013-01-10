class Category
	constructor: (@name, @description, @id) ->

class User
	constructor: (@firstName, @secondName, @description, @categories, @id) ->

class Post
	constructor: (@title, @content, @category_id, @autor_id, @id) ->