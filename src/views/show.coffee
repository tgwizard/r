div class: 'riddle row-fluid', ->
	div class: 'span4', ->
		h2 -> @riddle.title
		div class: 'content', -> @riddle.content
		if @show_answer
			div class: 'answer', ->
				h3 "Answer"
				div -> @riddle.answer
				p -> a href: @riddle.url, -> "Hide answer"
		else
			p -> a href: @riddle.url_answer, -> "Show answer"
