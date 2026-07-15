serve: sortkeys
	bundle exec jekyll serve --trace $(extra) --config _config.yml,_config.local.yml

bootstrap:
	gem install bundler
	bundle install

# Regenerate _data/sort_keys.yml from the database titles (issue #75).
sortkeys:
	ruby bin/gen_sort_keys.rb

all: _site

_site: sortkeys
	bundle exec jekyll build --trace $(extra) --config _config.yml,_config.local.yml

build: _site

clean:
	rm -r _site

print-%:
	@echo '$*=$($*)'

.PHONY: all serve bootstrap build clean sortkeys


