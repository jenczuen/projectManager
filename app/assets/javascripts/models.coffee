class Product
	constructor: (@author, @title, @price, @description, @category_id, @id) ->

class BuyerData
	constructor: (@firstName,@secondName,@street,@city) ->

class Category
	constructor: (@name, @id) ->

class OrderItem
	constructor: (@product, @quantity) ->
		@total_price = @product.price * @quantity

	increase: =>
		@quantity = @quantity + 1
		@total_price = @product.price * @quantity

	decrease: =>
		@quantity = @quantity - 1
		@total_price = @product.price * @quantity
