div class: 'riddle row-fluid', ->
	div class: 'span4', ->
		h2 -> @riddle.title
		div class: 'content', -> @riddle.content_html
		p -> a href: @riddle.url_answer, -> "Show answer &raquo;"
