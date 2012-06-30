#
# Inspired by the Bootstrap build script
#
BUILDDIR = build
APPDIR = app/app

SRC_ = app.js
SRC = ${addprefix ${APPDIR}/, ${SRC_}}

DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#


all: app/bootstrap app

app/app/%.js: src/%.coffee
	coffee -o ${APPDIR} -c $<

app/bootstrap:
	@make -C lib/bootstrap --no-print-directory

app: $(SRC)

clean:
	@echo "Cleaning app..."
	rm -rf app/app
	@echo "Clean complete"

clean_all: clean
	@make clean -s -C lib/bootstrap

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

#
# WATCH LESS FILES
#
watch:
	echo "Watching less files..."; \
	watchr -e "watch('less/.*\.less') { system 'make' }"


.PHONY: docs watch gh-pages
