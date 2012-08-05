extend 'show_base'

block 'riddle_content', ->
	div class: 'content', -> @riddle.html.content
	if @riddle.answer
		p -> a href: @riddle.url_answer, -> "Show answer &raquo;"
