BROWSER_PATH="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

combine:
	cat spec/lib/es6-map-shim.js smap.js > smap-shim.js

deploy: combine phantom
	npm publish

browser:
	open spec/SpecRunner.html

phantom:
	/usr/bin/env DISPLAY=:1 phantomjs spec/lib/run-jasmine.js spec/SpecRunner.html

jstd:
	/usr/bin/env DISPLAY=:1 java -jar spec/JsTestDriver-1.3.5.jar --config spec/jsTestDriver.conf --browser ${BROWSER_PATH} --port 4224 --tests 'all' --testOutput './target'

build: components smap
	@component build --dev

components: component.json
	@component install --dev

clean:
	rm -fr build components template.js

.PHONY: clean
