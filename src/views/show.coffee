extend 'layout'

block 'content', ->
	div class: 'riddle row-fluid', ->
		div class: 'span4', ->
			h2 -> @riddle.title
			div class: 'content', -> @riddle.html.content
			p -> a href: @riddle.url_answer, -> "Show answer &raquo;"

block 'extra', ->
	p "This is the extra block"

