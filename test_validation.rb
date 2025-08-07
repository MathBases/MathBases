#!/usr/bin/env ruby

require 'yaml'
require 'set'

class DatabaseValidator
  def initialize
    @errors = []
    @warnings = []
    load_reference_data
  end

  def load_reference_data
    # Load valid areas
    areas_file = File.join('_data', 'areas.yml')
    if File.exist?(areas_file)
      areas_data = YAML.load_file(areas_file)
      @valid_areas = Set.new(areas_data['areas'] || [])
    else
      @valid_areas = Set.new
    end

    # Load valid tags (collect from actual usage since _data/tags.yml is minimal)
    @valid_tags = Set.new
    
    # Load valid badges (collect from actual usage since _data/badges.yml is minimal)  
    @valid_badges = Set.new

    # Collect tags and badges from existing database files
    collect_existing_tags_and_badges
  end

  def collect_existing_tags_and_badges
    Dir.glob('_databases/*.md').each do |file|
      begin
        content = File.read(file)
        if content =~ /^---\s*\n(.*?)\n---\s*\n/m
          frontmatter = YAML.load($1)
          
          if frontmatter['tags']
            Array(frontmatter['tags']).each { |tag| @valid_tags.add(tag) }
          end
          
          if frontmatter['badges']
            Array(frontmatter['badges']).each { |badge| @valid_badges.add(badge) }
          end
        end
      rescue => e
        # Skip files with YAML errors for now - they'll be caught in validate_file
      end
    end
  end

  def validate_all_databases
    puts "🔍 Validating MathBases database entries..."
    puts

    database_files = Dir.glob('_databases/*.md').sort
    
    database_files.each do |file|
      validate_file(file)
    end

    print_summary(database_files.length)
  end

  def validate_file(file)
    filename = File.basename(file)
    
    begin
      content = File.read(file)
      
      # Check for YAML frontmatter
      unless content =~ /^---\s*\n(.*?)\n---\s*(.*)/m
        @errors << "#{filename}: Missing or malformed YAML frontmatter"
        return
      end

      frontmatter_content = $1
      markdown_content = $2&.strip

      # Parse YAML
      begin
        frontmatter = YAML.load(frontmatter_content)
      rescue Psych::SyntaxError => e
        @errors << "#{filename}: YAML syntax error: #{e.message}"
        return
      end

      # Validate required fields
      validate_required_fields(filename, frontmatter)
      
      # Validate field formats
      validate_field_formats(filename, frontmatter)
      
      # Validate references (areas, tags, badges)
      validate_references(filename, frontmatter)
      
      # Validate content
      validate_content(filename, markdown_content)
      
      # Validate ID matches filename
      validate_id_filename_match(filename, frontmatter)

    rescue => e
      @errors << "#{filename}: Unexpected error: #{e.message}"
    end
  end

  def validate_required_fields(filename, frontmatter)
    required_fields = ['id', 'location', 'title', 'area']
    
    required_fields.each do |field|
      unless frontmatter.key?(field) && !frontmatter[field].to_s.strip.empty?
        @errors << "#{filename}: Missing required field '#{field}'"
      end
    end
  end

  def validate_field_formats(filename, frontmatter)
    # Validate ID format (should be URL-safe)
    if frontmatter['id']
      id = frontmatter['id'].to_s
      unless id =~ /^[a-z0-9\-]+$/
        @errors << "#{filename}: ID '#{id}' contains invalid characters (use lowercase letters, numbers, and hyphens only)"
      end
    end

    # Validate location is a URL or valid identifier
    if frontmatter['location']
      location = frontmatter['location'].to_s
      unless location.start_with?('http') || location.match(/^[A-Z]+[\w\-]*$/) # URL or identifier like ISSN
        @warnings << "#{filename}: Location '#{location}' doesn't appear to be a URL or standard identifier"
      end
    end

    # Validate area is an array
    if frontmatter['area']
      unless frontmatter['area'].is_a?(Array)
        @errors << "#{filename}: Field 'area' must be an array"
      end
    end

    # Validate authors format if present
    if frontmatter['authors']
      unless frontmatter['authors'].is_a?(Array)
        @errors << "#{filename}: Field 'authors' must be an array"
      else
        frontmatter['authors'].each_with_index do |author, idx|
          unless author.is_a?(Hash) && author.key?('name')
            @errors << "#{filename}: Author #{idx + 1} must have a 'name' field"
          end
        end
      end
    end
  end

  def validate_references(filename, frontmatter)
    # Validate areas
    if frontmatter['area'] && frontmatter['area'].is_a?(Array)
      frontmatter['area'].each do |area|
        unless @valid_areas.include?(area)
          @errors << "#{filename}: Invalid area '#{area}' (check _data/areas.yml)"
        end
      end
    end

    # Validate tags (only warn since tags.yml is not comprehensive)
    if frontmatter['tags'] && frontmatter['tags'].is_a?(Array)
      frontmatter['tags'].each do |tag|
        unless @valid_tags.include?(tag)
          @warnings << "#{filename}: Uncommon tag '#{tag}' (consider if it's necessary)"
        end
      end
    end

    # Validate badges (only warn since badges.yml is not comprehensive)
    if frontmatter['badges'] && frontmatter['badges'].is_a?(Array)
      frontmatter['badges'].each do |badge|
        unless @valid_badges.include?(badge)
          @warnings << "#{filename}: Uncommon badge '#{badge}' (consider if it's necessary)"
        end
      end
    end
  end

  def validate_content(filename, content)
    if content.nil? || content.strip.empty?
      @warnings << "#{filename}: No markdown content found (description is recommended)"
    end
  end

  def validate_id_filename_match(filename, frontmatter)
    expected_filename = "#{frontmatter['id']}.md"
    unless filename == expected_filename
      @warnings << "#{filename}: ID '#{frontmatter['id']}' doesn't match filename (expected #{expected_filename})"
    end
  end

  def print_summary(total_files)
    puts
    puts "=" * 50
    puts "VALIDATION SUMMARY"
    puts "=" * 50
    puts "Files checked: #{total_files}"
    puts "Errors: #{@errors.length}"
    puts "Warnings: #{@warnings.length}"
    puts

    if @errors.any?
      puts "❌ ERRORS:"
      @errors.each { |error| puts "  #{error}" }
      puts
    end

    if @warnings.any?
      puts "⚠️  WARNINGS:"
      @warnings.each { |warning| puts "  #{warning}" }
      puts
    end

    if @errors.empty? && @warnings.empty?
      puts "✅ All validations passed!"
    elsif @errors.empty?
      puts "✅ No errors found (only warnings)"
    else
      puts "❌ Validation failed with #{@errors.length} errors"
      exit 1
    end
  end
end

# Add Jekyll build test
def test_jekyll_build
  puts "🏗️  Testing Jekyll build..."
  
  # Set up environment
  ENV['PATH'] = "#{ENV['HOME']}/.local/share/gem/ruby/3.2.0/bin:#{ENV['PATH']}"
  ENV['GEM_HOME'] = "#{ENV['HOME']}/.gem"
  
  # Run Jekyll build
  result = system('bundle exec jekyll build --config _config.yml,_config.local.yml --quiet')
  
  if result
    puts "✅ Jekyll build successful"
  else
    puts "❌ Jekyll build failed"
    exit 1
  end
  puts
end

# Main execution
if __FILE__ == $0
  validator = DatabaseValidator.new
  validator.validate_all_databases
  test_jekyll_build
  puts "🎉 All tests completed successfully!"
end