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
	server.use server.router

server.configure 'development', ->
	server.use(express.errorHandler({ showStack: true, dumpExceptions: true }));

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
	res.render 'index', locals: {content: 'Testing sending some content...'}

server.get '/riddle/:slug', (req, res) ->
	r = riddles.riddles[req.params.slug]
	if not r
		errors.throw404 req, res
	res.render 'show', riddle: r

# 404 path, keep last
server.get '/*', (req, res) ->
	errors.throw404 req, req

server.listen(8123);
