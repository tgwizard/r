div class: 'riddle row-fluid', ->
	div class: 'span4', ->
		h2 "About riddle me this"
		p ->
			text "Riddle me this is a site blah blah"

		p ->
			text "If you know of good riddle, or improvements to ones already here,
					or any suggestion at all really, please email me at "
			a href: "mailto:tgwizard@gmail.com?subject=Riddle", -> "tgwizard@gmail.com"
			text "."

		p ->
			text "The site is built using Twitter's "
			a href: "http://twitter.github.com/bootstrap/", -> "Bootstrap"
			text ", "
			a href: "http://nodejs.org/", -> "Node.js"
			text " and a lot of third party libraries."
			text "The code can be found on "
			a href: "#", -> "github.com/tgwizard/riddlemethis"
			text "."
