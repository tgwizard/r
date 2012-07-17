extend 'layout'

block 'content', ->
	div class: 'riddle row-fluid', ->
		div class: 'span4', ->
			h2 -> 'Riddles'
			p -> @riddles.length
			p -> 'Here are some great riddles and puzzles to challange your mind. Have fun!'
			ul ->
				for riddle in @riddles
					li ->
						a href: riddle.url, -> riddle.title
