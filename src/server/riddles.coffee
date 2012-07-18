PagedownConverter = require('pagedown/Markdown.Converter').Converter

riddles =
	'three-switches':
		title: "Three switches"
		content:
			"""
			There is a square room, empty but for an old-fashioned ligth bulb. One
			side of the room has a door, leading in. Outside the room there are three
			switches, one of them (you don't know which) lights the light bulb inside
			the room. All three switches are in their off setting to begin with, and
			the light bulb is dark. You can turn on or off the switches how many
			times you want, but you acnnot see if they affect the light bulb from the
			outside. You are allowed to enter the room once to see if the light bulb
			is shining.

			How do you determine which of the switches control the light bulb?
			"""
		hints: [
			"""
			A more practical, down-to-earth approach might be useful.
			"""
		]
		answer:
			"""
			Bah!
			"""
		difficulty: 2
		about: ""
	'blue-eyes':
		title: "Blue eyes"
		content:
			"""
			Blue eyes on a far-away island...
			"""
		answer:
			"""
			Beh!
			"""
		difficulty: 4
		about:
			"""
			There are several variations of this puzzle, where the blue eyes version
			has been popularized by Randall Munroe on
			[xkcd.com/blue_eyes.html](http://xkcd.com/blue_eyes.html).
			"""

	'devils-gate':
		title: "The devil's gate"
		content:
			"""
			In line at the devil's gate, black and white hats...
			"""
		answer:
			"""
			Buh!
			"""

# markdown -> html conversion
mdConv = new PagedownConverter

convertMarkdown2Html = (obj, fields...) ->
	obj.html = {}
	for f in fields
		if obj[f]
			obj.html[f] = mdConv.makeHtml obj[f]
		else
			obj.html[f] = ""

# patch the riddle objects with interesting info
for slug, riddle of riddles
	riddle.slug = slug
	riddle.url = "/riddle/#{slug}"
	riddle.url_answer = "#{riddle.url}/answer"
	riddle.difficulty_text = ->
		switch @difficulty
			when 1 then "Easy"
			when 2 then "Somewhat easy"
			when 3 then "Medium"
			when 4 then "Hard"
			when 5 then "Very hard"
			else "Unknown"
	convertMarkdown2Html riddle, 'content', 'answer', 'about'

# and represent the riddles as a list as well
riddles.list = (riddles[key] for key of riddles)

# functionality for searching riddles
# TODO: cleanup
riddles.search = (q) ->
	result = []
	words = q.split()
	words = (w.toLowerCase() for w in words)
	used = (false for riddle in riddles)

	# word in title first
	merge_results result, words, used, (riddle, word) ->
		riddle.title.toLowerCase().indexOf(word) != -1

	# then word in content
	merge_results result, words, used, (riddle, word) ->
		riddle.content.toLowerCase().indexOf(word) != -1

	result

merge_results = (result, words, used, generator) ->
	temp = search_accept words, used, generator
	Array::push.apply result, temp

search_accept = (words, used, crit) ->
	result = []
	for riddle, i in riddles.list
		if used[i]
			continue
		for word in words
			if crit riddle, word
				used[i] = true
				result.push riddle
	result

module.exports = riddles
