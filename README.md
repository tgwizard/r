# r

A website of riddles

## Clone and code

Clone the repository from github and initialize all submodules:

	git clone --recursive git@github.com:tgwizard/r.git

Install all dependencies (via npm), and make symbolic links:

	make install_deps

Build everything, and start the server:

	make start_server

Later, to update to the latest version:

	git pull
	git submodule update

Known to work on Ubuntu 12.04.
