# r

A website of riddles

## Clone and code

Clone the repository from github and initialize all submodules:

	git clone --recursive git@github.com:tgwizard/r.git

If you forget the --recursive flag, you can do:

	git submodule init
	git submodule update


Install [node.js](http://nodejs.org/) and [npm](http://npmjs.org/):

	sudo apt-get install nodejs npm

(on Debian/Ubuntu).

Install global dependencies ([coffee-script](http://coffeescript.org/),
[recess](https://github.com/twitter/recess),
[uglify-js](https://github.com/mishoo/UglifyJS/)):

	make install_global_deps

Install local dependencies, and make symbolic links (to some
dependencies included in the repository):

	make install_deps


Build everything, and start the server:

	make start_server

(Stop it with Ctrl-C).

Later, to update to the latest version:

	git pull
	git submodule update

Known to work on Ubuntu 12.04.

The site is built mainly on [node](http://node.js),
[coffee-script](http://coffeescript.org), [express](http://expressjs.org),
and [coffeefilter](https://github.com/tgwizard/coffeefilter). Reading the
documentation for those should help to better understand the code here.