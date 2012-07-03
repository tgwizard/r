doctype 5
html ->
	head ->
		meta charset: 'utf-8'
		if @title
			title "#{@title} - Riddle me this"
		else
			title "Riddle me this"
		link rel: 'stylesheet', href: '/static/bootstrap/css/bootstrap.css'
		link rel: 'stylesheet', href: '/static/css/style.css'
		link rel: 'stylesheet', href: '/static/bootstrap/css/bootstrap-responsive.css'
	body ->
		div class: 'navbar navbar-fixed-top', ->
			div class: 'navbar-inner', ->
				div class: 'container-fluid', ->
					a class: 'btn btn-navbar', 'data-toggle': 'collapse', 'data-target': '.nav-collapse', ->
						span class: 'icon-bar'
						span class: 'icon-bar'
						span class: 'icon-bar'
					a class: 'brand', href: '/', -> 'Riddle me this'
					div class: 'nav-collapse', ->
						ul class: 'nav', ->
							li class: 'active', -> a href: '/', -> 'All riddles'
							li -> a href: '/about', -> 'About'
						form class: 'navbar-search pull-left', action: '/search/', method: 'get', ->
							input class: 'search-query span2', type: 'text', placeholder: 'Search', id: 'q', name: 'q', value: @q
		div class: 'container-fluid', ->
			div  ->
				@body
			hr ''
			footer ->
				p -> 'By Adam Renberg.'
		script src: '/static/js/vendor/jquery-1.7.2.js'
		script src: '/static/bootstrap/js/bootstrap.min.js'
		script src: '/static/js/vendor/json2.js'
		script src: '/static/js/vendor/underscore.js'
		script src: '/static/js/vendor/backbone.js'
		#script src: '/static/app/app.js'
