extend 'layout'

block 'content', ->
	div class: 'riddle row-fluid', ->
		div class: 'span4', ->
			h2 -> @riddle.title
			block 'riddle_content'
		div class: 'span3', ->
			p "Difficulty: <b>#{@riddle.difficulty_text()}</b>"
			if @riddle.about
				p @riddle.html.about

			p "Created on #{date @riddle.date_created}."
			if @riddle.date_modified > @riddle.date_created
				p "Last modified on #{date @riddle.date_modified}"

			p "TODO: like"
			p "TODO: share"

