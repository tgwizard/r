# setup express
express = require 'express'
connect = require 'connect'
server = express.createServer()
server.configure ->
	# setup views
	server.set 'view engine', 'coffee'
	server.register '.coffee', require('coffeekup').adapters.express
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
errors = require './errors'
server.error (err, req, res, next) ->
	status = 500
	title = '500 Error - Internal Server Error'
	if err instanceof errors.NotFound
		status = 404
		title = '404 Error - Page Not Found'
	res.render status, status: status, title: title, layout: 'error-layout'

riddles = require('./riddles')


# routes
server.get '/', (req, res) ->
	res.render 'index', active_tab: 'index', riddles: riddles.list

loadRiddle = (req, res, next) ->
	r = riddles[req.params.slug]
	if not r
		errors.throw404 req, res
	req.riddle = r
	res.local 'riddle', r
	next()

server.get '/riddle/:slug', loadRiddle, (req, res) ->
	res.render 'show'

server.get '/riddle/:slug/answer', loadRiddle, (req, res) ->
	res.render 'show_answer'

server.get '/search', (req, res) ->
	q = req.query.q or ""
	result = riddles.search q
	res.render 'search', q: q, riddles: result

server.get '/about', (req, res) ->
	res.render 'about', active_tab: 'about'

# 404 path, keep last
server.get '/*', (req, res) ->
	errors.throw404 req, req

server.listen(8123);
