BOOTSTRAP_LESS = ./less/bootstrap.less
BOOTSTRAP_RESPONSIVE = ./docs/assets/css/bootstrap-responsive.css
BOOTSTRAP_RESPONSIVE_LESS = ./less/responsive.less
BINDIR = ../../app/bootstrap
BUILDDIR = ../../build/bootstrap
DATE=$(shell date +%I:%M%p)
CHECK=\033[32m✔\033[39m
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

#
# BUILD SIMPLE BOOTSTRAP DIRECTORY
# recess & uglifyjs are required
#

all:
	@echo ${HR}
	@echo "Building bootstrap..."
	mkdir -p ${BUILDDIR}
	mkdir -p ${BUILDDIR}/js
	mkdir -p ${BINDIR}/img
	mkdir -p ${BINDIR}/css
	mkdir -p ${BINDIR}/js
	cp img/* ${BINDIR}/img/
	recess --compile ${BOOTSTRAP_LESS} > ${BINDIR}/css/bootstrap.css
	recess --compress ${BOOTSTRAP_LESS} > ${BINDIR}/css/bootstrap.min.css
	recess --compile ${BOOTSTRAP_RESPONSIVE_LESS} > ${BINDIR}/css/bootstrap-responsive.css
	recess --compress ${BOOTSTRAP_RESPONSIVE_LESS} > ${BINDIR}/css/bootstrap-responsive.min.css
	cat js/bootstrap-transition.js js/bootstrap-alert.js js/bootstrap-button.js js/bootstrap-carousel.js js/bootstrap-collapse.js js/bootstrap-dropdown.js js/bootstrap-modal.js js/bootstrap-tooltip.js js/bootstrap-popover.js js/bootstrap-scrollspy.js js/bootstrap-tab.js js/bootstrap-typeahead.js > ${BUILDDIR}/js/bootstrap.js
	uglifyjs -nc ${BUILDDIR}/js/bootstrap.js > ${BUILDDIR}/js/bootstrap.min.tmp.js
	echo "/*!\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > ${BUILDDIR}/js/copyright.js
	cat ${BUILDDIR}/js/copyright.js ${BUILDDIR}/js/bootstrap.min.tmp.js > ${BINDIR}/js/bootstrap.min.js
	@echo "Done ${CHECK}"
	@echo ${HR}

clean:
	@echo "Cleaning bootstrap..."
	rm -rf ${BINDIR} ${BUILDDIR}

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
