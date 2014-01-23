var static = require('node-static');

var file = new static.Server('./out-make');

require('http').createServer(function (request, response)
{
	request.addListener('end', function ()
	{
		file.serve(request, response);
	}).resume();
}).listen(8080);
console.log('Serving presentation from ./out-make');
