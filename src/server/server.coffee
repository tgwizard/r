# third party libraries
express = require 'express'
connect = require 'connect'
coffeefilter = require 'coffeefilter'
PagedownConverter = require('pagedown/Markdown.Converter').Converter

# local modules
errors = require './errors'
riddles = require './riddles'

# setup express
server = express.createServer()
server.configure ->
	# setup views
	server.set 'view engine', 'coffee'
	server.engine '.coffee', coffeefilter.adapters.express
	server.set 'views', './src/views'
	server.use express.methodOverride()
	server.use connect.bodyParser()
	server.use express.cookieParser()
	# static files
	server.use '/static', express.static('./app')
	server.use connect.favicon './assets/favicon.ico'
	server.use server.router

server.configure 'development', ->
	server.use(express.errorHandler({ showStack: true, dumpExceptions: true }));

# errors
server.use (err, req, res, next) ->
	status = 500
	title = '500 Error - Internal Server Error'
	if err instanceof errors.NotFound
		status = 404
		title = '404 Error - Page Not Found'
	res.render status, status: status, title: title, layout: 'error-layout'


# markdown -> html conversion
mdConv = new PagedownConverter

convertMarkdown2Html = (obj, fields...) ->
	obj.html = {}
	for f in fields
		obj.html[f] = mdConv.makeHtml obj[f]

# routes
server.get '/', (req, res) ->
	res.locals.active_tab = 'index'
	res.locals.riddles = riddles.list
	res.render 'index'

loadRiddle = (req, res, next) ->
	r = riddles[req.params.slug]
	if not r
		errors.throw404 req, res
	convertMarkdown2Html r, 'content', 'answer'
	res.locals.riddle = r
	next()

server.get '/riddle/:slug', loadRiddle, (req, res) ->
	res.render 'show'

server.get '/riddle/:slug/answer', loadRiddle, (req, res) ->
	res.render 'show_answer'

server.get '/search', (req, res) ->
	q = req.query.q or ""
	result = riddles.search q
	res.locals.q = q
	res.locals.riddles = result
	res.render 'search'

server.get '/about', (req, res) ->
	res.render 'about',

# 404 path, keep last
server.get '/*', (req, res) ->
	errors.throw404 req, req

server.listen(8123);
