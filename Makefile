serve:
	bundle exec jekyll serve --trace $(extra) --config _config.yml,_config.local.yml

bootstrap:
	gem install bundler
	bundle install

all: _site

_site:
	bundle exec jekyll build --trace $(extra) --config _config.yml,_config.local.yml

build: _site

clean:
	rm -r _site

print-%:
	@echo '$*=$($*)'

.PHONY: all serve bootstrap build clean


