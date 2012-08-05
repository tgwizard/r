#
# Inspired by the Bootstrap build script
#
BUILDDIR = build
APPDIR = app/app
CSSDIR = app/css
SERVERDIR = server/server

APPSRC_ = app.js
APPSRC = ${addprefix ${APPDIR}/, ${APPSRC_}}

LESSSRC_ = style.css
LESSSRC = ${addprefix ${CSSDIR}/, ${LESSSRC_}}

SERVERSRC_ = server.js riddles.js riddles_content.js errors.js
SERVERSRC = ${addprefix ${SERVERDIR}/, ${SERVERSRC_}}

DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

WATCHINTERVAL = 2

all: preparation app/bootstrap app less server coffeefilter

preparation:
	@mkdir -p $(APPDIR)
	@mkdir -p $(CSSDIR)
	@mkdir -p $(SERVERDIR)

app/app/%.js: src/app/%.coffee
	coffee -o ${APPDIR} -c $<

server/server/%.js: src/server/%.coffee
	coffee -o ${SERVERDIR} -c $<

app/css/%.css: src/less/%.less
	recess --compile $< > $@

# bootstrap is only rebuilt after a clean
# TODO: make bootstrap rebuild when modified
app/bootstrap:
	@make -C lib/bootstrap --no-print-directory

app: $(APPSRC)

server: $(SERVERSRC)

less: $(LESSSRC)

coffeefilter:
	@make -C lib/coffeefilter --no-print-directory

clean:
	@echo "Cleaning app..."
	rm -rf $(APPDIR)
	rm -rf $(CSSDIR)
	@echo "Cleaning server..."
	rm -rf $(SERVERDIR)


clean-all: clean
	@make clean -s -C lib/bootstrap
	@make clean -s -C lib/coffeefilter

#watch:
#	nodejs watchmake.js src/ src/less/

watch:
	@echo "Performing make every ${WATCHINTERVAL}s"
	bash -c 'while [ 0 ]; do make --no-print-directory; sleep ${WATCHINTERVAL}; done'
	#watch make --no-print-directory

start_server: all
	node server/server/server.js

install_deps:
	mkdir -p node_modules
	npm install
	@echo
	@echo "Installing local libraries..."
	npm install lib/pagedown
	ln -sf ../lib/coffeefilter node_modules/coffeefilter

install_global_deps:
	sudo npm install -g recess
	sudo npm install -g coffee-script
	sudo npm install -g uglify-js

deploy:
	fab deploy

#
# RUN JSHINT & QUNIT TESTS IN PHANTOMJS
#
test:
	jshint js/*.js --config js/.jshintrc
	jshint js/tests/unit/*.js --config js/.jshintrc
	node js/tests/server.js &
	phantomjs js/tests/phantom.js "http://localhost:3000/js/tests"
	kill -9 `cat js/tests/pid.txt`
	rm js/tests/pid.txt

.PHONY: docs watch gh-pages app less server
