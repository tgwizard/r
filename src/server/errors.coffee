class NotFound extends Error
	constructor: (url) ->
		@name = "NotFound #{url}"
		if url
			Error.call @, "Cannot find #{url}"
			@url = url
		else
			Error.call @, "Not found"
		Error.captureStackTrace @, arguments.callee

exports.NotFound = NotFound

exports.throw404 = (req, res) ->
	throw new NotFound req.url

exports.throw500 = (msg) ->
	throw new Error msg
