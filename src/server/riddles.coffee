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

for slug, riddle of riddles
	riddle.slug = slug
	riddle.url = "/riddle/#{slug}"
	riddle.url_answer = "#{riddle.url}/answer"

riddles.list = (riddles[key] for key of riddles)

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
