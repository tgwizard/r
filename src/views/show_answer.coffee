extend 'show_base'

block 'riddle_content', ->
	h3 "Answer"
	div -> @riddle.html.answer
	p -> a href: @riddle.url, -> "&laquo; Back to riddle"
