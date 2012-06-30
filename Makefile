#
# Inspired by the Bootstrap build script
#
BUILDDIR = build
APPDIR = app/app
CSSDIR = app/css
SERVERDIR = server

APPSRC_ = app.js
APPSRC = ${addprefix ${APPDIR}/, ${APPSRC_}}

LESSSRC_ = style.css
LESSSRC = ${addprefix ${CSSDIR}/, ${LESSSRC_}}

SERVERSRC_ = server.js
SERVERSRC_ = ${addprefix ${SERVERDIR}/, ${SERVERSRC_}}

DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

WATCHINTERVAL = 2

all: preparation app/bootstrap app less server

preparation:
	@mkdir -p $(APPDIR)
	@mkdir -p $(CSSDIR)
	@mkdir -p $(SERVERDIR)

app/app/%.js: src/app/%.coffee
	coffee -o ${APPDIR} -c $<

server/%.js: src/server/%.coffee
	coffee -o ${APPDIR} -c $<

app/css/%.css: src/less/%.less
	recess --compile $< > $@

app/bootstrap:
	@make -C lib/bootstrap --no-print-directory

app: $(APPSRC)

server: $(SERVERSRC)

less: $(LESSSRC)

clean:
	@echo "Cleaning app..."
	rm -rf app/app
	rm -rf app/css
	@echo "Clean complete"

clean-all: clean
	@make clean -s -C lib/bootstrap

#watch:
#	nodejs watchmake.js src/ src/less/

watch:
	@echo "Performing make every ${WATCHINTERVAL}s"
	bash -c 'while [ 0 ]; do make --no-print-directory; sleep ${WATCHINTERVAL}; done'
	#watch make --no-print-directory

install_deps:
	npm install
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
