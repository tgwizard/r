div class: 'riddle row-fluid', ->
	div class: 'span4', ->
		h2 -> @riddle.title
		div class: 'answer', ->
			h3 "Answer"
			div -> @riddle.answer
			p -> a href: @riddle.url, -> "&laquo; Back to riddle"
