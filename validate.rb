#!/usr/bin/env ruby
# frozen_string_literal: true

# Validates every entry in the _databases collection.
#
# Note: tags (_data/tags.yml) and badges (_data/badges.yml) are intentionally
# NOT validated here. Those files are currently placeholder stubs with no real
# data, so there is no source of truth to check entries against yet.

require 'yaml'
require 'set'
require 'date'

class DatabaseEntryValidator
  FRONTMATTER_RE = /\A---\s*\n(.*?)\n---\s*(\n.*)?\z/m
  ID_RE = /\A[a-z0-9-]+\z/
  REQUIRED_FIELDS = %w[id location title area].freeze

  def initialize(databases_dir: '_databases', areas_file: '_data/areas.yml')
    @databases_dir = databases_dir
    @areas = Set.new(YAML.load_file(areas_file)['areas'])
    @errors = []
    @warnings = []
    @ids_to_files = Hash.new { |h, k| h[k] = [] }
    @files_checked = 0
  end

  def run
    Dir.glob(File.join(@databases_dir, '*')).sort.each do |f|
      next if File.directory?(f)

      @files_checked += 1
      validate_file(f)
    end

    check_duplicate_ids
    report
  end

  private

  def blank?(value)
    return true if value.nil?
    return value.strip.empty? if value.is_a?(String)
    return value.empty? if value.is_a?(Array)

    false
  end

  def validate_file(path)
    filename = File.basename(path)

    unless filename.end_with?('.md')
      @errors << "#{filename}: must use a .md extension"
    end

    content = File.read(path)

    match = content.match(FRONTMATTER_RE)
    unless match
      @errors << "#{filename}: missing YAML frontmatter (--- fences)"
      return
    end

    frontmatter_text = match[1]

    begin
      fm = YAML.safe_load(frontmatter_text, permitted_classes: [Date, Time], aliases: false)
    rescue Psych::Exception => e
      @errors << "#{filename}: YAML error: #{e.message}"
      return
    end

    unless fm.is_a?(Hash)
      @errors << "#{filename}: frontmatter is not a YAML mapping"
      return
    end

    check_duplicate_keys(filename, frontmatter_text)
    check_required_fields(filename, fm)
    check_id(filename, fm)
    check_area(filename, fm)
    check_authors(filename, fm)
    check_id_matches_filename(filename, fm)

    id = fm['id']
    @ids_to_files[id] << filename unless blank?(id)
  end

  def check_duplicate_keys(filename, frontmatter_text)
    root = Psych.parse(frontmatter_text).root
    return unless root.is_a?(Psych::Nodes::Mapping)

    keys = root.children.each_slice(2).map { |k, _v| k.value if k.respond_to?(:value) }.compact
    keys.tally.each do |key, count|
      @errors << "#{filename}: duplicate key '#{key}' in frontmatter" if count > 1
    end
  end

  def check_required_fields(filename, fm)
    REQUIRED_FIELDS.each do |field|
      @errors << "#{filename}: missing required field '#{field}'" if blank?(fm[field])
    end
  end

  def check_id(filename, fm)
    id = fm['id']
    return if blank?(id)

    @errors << "#{filename}: invalid id '#{id}' (use lowercase letters, digits, hyphens)" unless id.to_s.match?(ID_RE)
  end

  def check_area(filename, fm)
    area = fm['area']
    return if blank?(area)

    unless area.is_a?(Array)
      @errors << "#{filename}: 'area' must be a list"
      return
    end

    area.each do |a|
      @errors << "#{filename}: invalid area '#{a}'" unless @areas.include?(a)
    end
  end

  def check_authors(filename, fm)
    return unless fm.key?('authors')

    authors = fm['authors']
    unless authors.is_a?(Array)
      @errors << "#{filename}: 'authors' must be a list"
      return
    end

    authors.each_with_index do |author, i|
      unless author.is_a?(Hash) && author.key?('name')
        @errors << "#{filename}: author #{i + 1} must be a mapping with a 'name'"
      end
    end
  end

  def check_id_matches_filename(filename, fm)
    id = fm['id']
    return if blank?(id)

    expected = "#{id}.md"
    @warnings << "#{filename}: id '#{id}' does not match filename (expected #{expected})" unless filename == expected
  end

  def check_duplicate_ids
    @ids_to_files.each do |id, files|
      next unless files.size > 1

      @errors << "duplicate id '#{id}' used by #{files.join(', ')}"
    end
  end

  def report
    puts "Checked #{@files_checked} file(s) in #{@databases_dir}/"
    puts

    unless @errors.empty?
      puts "Errors (#{@errors.size}):"
      @errors.each { |e| puts "  - #{e}" }
      puts
    end

    unless @warnings.empty?
      puts "Warnings (#{@warnings.size}):"
      @warnings.each { |w| puts "  - #{w}" }
      puts
    end

    if @errors.empty?
      puts 'All database entries are valid.'
    end

    @errors.empty?
  end
end

if $PROGRAM_NAME == __FILE__
  ok = DatabaseEntryValidator.new.run
  exit(ok ? 0 : 1)
end
