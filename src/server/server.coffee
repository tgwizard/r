app = require('express').createServer()

app.get '/', (req, res) ->
	res.send 'hello world\n'

app.listen(8123);
