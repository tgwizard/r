h2 -> @title
if @description
	p -> @description
p ->
	text "The page cannot be found. You can start again from the "
	a href: "/", -> "beginning"
	text "."
