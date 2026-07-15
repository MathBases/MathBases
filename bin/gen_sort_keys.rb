#!/usr/bin/env ruby
# frozen_string_literal: true

# Generate _data/sort_keys.yml: a map from each database's id to a sort key
# derived from its title, so the index page can alphabetise past leading
# punctuation and leading articles (issue #75).
#
# The key is the title lowercased, with a leading article ("a"/"an"/"the")
# dropped and non-letter characters removed. An explicit `sort_key:` in a
# database's front matter overrides the computed value.
#
# Run automatically by `make` and by the deploy workflow before `jekyll build`;
# the output is git-ignored and regenerated on every build.

require 'yaml'
require 'date' # so `Date` is defined for YAML.safe_load's permitted_classes

ROOT   = File.expand_path('..', __dir__)
DB_DIR = File.join(ROOT, '_databases')
OUT    = File.join(ROOT, '_data', 'sort_keys.yml')

LEADING_ARTICLE = /\A(?:a|an|the)\s+/

def sort_key(title)
  s = title.to_s.downcase.strip
  s = s.sub(LEADING_ARTICLE, '')       # drop a leading article
  s = s.gsub(/[^[:alpha:]\s]/, ' ')    # drop non-letters (punctuation, digits)
  s.gsub(/\s+/, ' ').strip             # collapse whitespace
end

keys = {}
# Match all files (not just *.md): a few database entries are missing their .md
# extension but Jekyll still treats them as documents.
Dir.glob(File.join(DB_DIR, '*')).sort.each do |path|
  next unless File.file?(path)

  content = File.read(path, encoding: 'utf-8')
  # Closing `---` may sit at EOF with no trailing newline (front-matter-only stubs).
  next unless content =~ /\A---\s*\n(.*?)\n---[ \t]*(?:\r?\n|\z)/m

  begin
    front_matter = YAML.safe_load($1, permitted_classes: [Date, Time], aliases: true) || {}
  rescue StandardError => e
    warn "gen_sort_keys: skipping #{File.basename(path)}: #{e.message}"
    next
  end

  # Key by filename, which is the document's slug in Liquid (`p.slug`) — the
  # front-matter `id` isn't reachable there (Jekyll's own `id` shadows it), and
  # can even differ from the filename (e.g. HOPS.md has id: hops).
  slug = File.basename(path, '.md')
  # Prefer ascii_name (authors set it to transliterate accents for sorting,
  # e.g. "Erdős" -> "Erdos") so accented titles still sort under the right letter.
  base = front_matter['ascii_name'] || front_matter['title']
  keys[slug] = front_matter['sort_key'] || sort_key(base)
end

File.write(OUT, keys.to_yaml)
warn "gen_sort_keys: wrote #{keys.size} sort keys to #{OUT.sub("#{ROOT}/", '')}"
