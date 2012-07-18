extend 'show_base'

block 'riddle_content', ->
	div class: 'content', -> @riddle.html.content
	p -> a href: @riddle.url_answer, -> "Show answer &raquo;"
