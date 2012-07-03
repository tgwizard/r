div class: 'riddle row-fluid', ->
	div class: 'span4', ->
		h2 "Search results for #{@q}"
		if @riddles.length == 0
			p "No riddles found"
		ul ->
			for riddle in @riddles
				li ->
					a href: riddle.url, -> riddle.title
