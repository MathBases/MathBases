serve:
	bundle exec jekyll serve --trace $(extra)

bootstrap:
	gem install bundler
	bundle install

all: _site

_site:
	bundle exec jekyll build --trace $(extra)

build: _site

clean:
	rm -r _site

print-%:
	@echo '$*=$($*)'

.PHONY: all serve bootstrap build clean


