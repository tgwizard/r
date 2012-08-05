riddles_content = require './riddles_content'
PagedownConverter = require('pagedown/Markdown.Converter').Converter

riddles = riddles_content.riddles

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
