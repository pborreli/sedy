.PHONY: test

copy-conf: ## Initialize the configuration files by copying the *''-dist" versions (does not override existing config)
	-cp -n ./config/production-dist.json ./config/production.json

install: copy-conf
	npm install

clean:
	rm -rf build/*

build: clean
	./node_modules/.bin/webpack --progress

run:
	node --require babel-polyfill --require babel-core/register ./src/server.js

run-installer:
	cd installer && make run

deploy: clean
	./node_modules/.bin/webpack -p --progress --optimize-dedupe
	cd build && zip -r sedy.zip *
	aws lambda update-function-code --function-name Sedy --zip-file fileb://build/sedy.zip

test-unit:
	./node_modules/.bin/mocha \
		--compilers js:babel-core/register \
		--require babel-polyfill \
		--require co-mocha \
		--recursive \
			./src/*.spec.js \
			'./src/**/*.spec.js'

test-e2e:
	./node_modules/.bin/mocha \
		--compilers js:babel-core/register \
		--require babel-polyfill \
		--require co-mocha \
		--recursive \
			./e2e/*.spec.js \
			'./e2e/**/*.spec.js'

test: test-unit test-e2e

build-installer:
	cd installer && make build
	rm -rf docs/
	mv installer/build docs/
