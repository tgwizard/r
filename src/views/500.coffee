h2 -> @title
if @description
	p -> @description
p ->
	text "Oops, something bad has happened. You can start again from the "
	a href: "/", -> "beginning"
	text "."
