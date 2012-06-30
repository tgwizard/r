var fs = require('fs');
var exec = require('child_process').exec;

var paths = process.argv.splice(2);
console.log("Watching " + paths.join(', ') + " for changes to .coffee and .less files");

var endsWith = function(str, end) {
	if (str.length < end.length)
		return false;
	if (str.substr(-end.length, end.length) == end)
		return true;
	return false;
}

var makeWatchFunction = function(path) {
	return function(event, filename) {
		// only process changes
		if (event != 'change')
			return;
		// skip backup files
		if (filename[0] == '.' || filename[-1] == '~')
			return;
		// and numerical filenames
		if (!endsWith(filename, '.coffee') && !endsWith(filename, '.less'))
			return;

		console.log("Something changed in " + path + filename);
		console.log("Executing make...");
		exec("make --no-print-directory", function(err, stdout, stderr) {
			console.log(stdout + stderr);
		});
	};
};

paths.forEach(function(path) {
	fs.watch(path, makeWatchFunction(path));
});
