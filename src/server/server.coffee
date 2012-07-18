# third party libraries
express = require 'express'
connect = require 'connect'
coffeefilter = require 'coffeefilter'
PagedownConverter = require('pagedown/Markdown.Converter').Converter

# local modules
errors = require './errors'
riddles = require './riddles'

# setup express
app = express()
server = require('http').createServer app
app.configure ->
	# setup views
	app.set 'view engine', 'coffee'
	app.engine '.coffee', coffeefilter.adapters.express
	app.set 'views', './src/views'
	app.use express.methodOverride()
	app.use connect.bodyParser()
	app.use express.cookieParser()

app.configure 'development', ->
	# static files
	app.use '/static', express.static('./app')
	app.use connect.favicon './assets/favicon.ico'
	# dev error handler
	app.use(express.errorHandler({ showStack: true, dumpExceptions: true }));

app.configure ->
	app.use app.router

# errors
app.use (err, req, res, next) ->
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
app.get '/', (req, res) ->
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

app.get '/riddle/:slug', loadRiddle, (req, res) ->
	res.render 'show'

app.get '/riddle/:slug/answer', loadRiddle, (req, res) ->
	res.render 'show_answer'

app.get '/search', (req, res) ->
	q = req.query.q or ""
	result = riddles.search q
	res.locals.q = q
	res.locals.riddles = result
	res.render 'searchs'

app.get '/about', (req, res) ->
	res.render 'about',

# 404 path, keep last
app.get '/*', (req, res) ->
	errors.throw404 req, req

server.listen(8123);
console.log "Server listening on http://localhost:8123..."
