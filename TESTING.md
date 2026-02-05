# Testing Documentation

MathBases now includes automated validation tests to ensure data quality and consistency across all database entries.

## Overview

The testing system validates:
- ✅ YAML frontmatter syntax and structure
- ✅ Required fields (id, location, title, area)
- ✅ Field format validation (IDs, URLs, arrays)
- ✅ Reference data consistency (areas, tags, badges)
- ✅ Jekyll build success
- ⚠️  Content presence and quality (warnings)

## Running Tests

### Quick Start
```bash
./run_tests.sh
```

### Using Rake
```bash
# Run all tests
rake test

# Run only YAML validation (faster)
rake test_yaml

# Run only Jekyll build test
rake test_build

# Set up test environment
rake setup
```

### Direct Ruby Execution
```bash
# Set up environment
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export GEM_HOME=$HOME/.gem

# Run all tests
ruby test_validation.rb
```

## Test Categories

### Errors (Must Fix)
These will cause test failure and should be addressed:
- Missing required fields (id, location, title, area)
- Invalid YAML syntax
- Malformed field formats
- Invalid references to areas not in `_data/areas.yml`

### Warnings (Recommended to Address)
These don't cause test failure but indicate potential issues:
- Missing markdown content descriptions
- Filename/ID mismatches
- Uncommon tags or badges
- Non-standard location formats

## Validation Rules

### Required Fields
Every database entry must have:
- `id`: Unique identifier (lowercase, alphanumeric, hyphens only)
- `location`: URL or standard identifier where the database can be accessed
- `title`: Human-readable name of the database
- `area`: List of mathematical areas (must match values in `_data/areas.yml`)

### Field Formats
- **ID**: Must be URL-safe (lowercase letters, numbers, hyphens)
- **Location**: Should be a URL (http/https) or standard identifier
- **Area**: Must be an array of valid areas from `_data/areas.yml`
- **Authors**: Must be an array of objects with 'name' field
- **Tags/Badges**: Arrays of strings (validated against existing usage)

### Content Guidelines
- Markdown content after YAML frontmatter is recommended for descriptions
- Filenames should match the ID field (e.g., `my-database.md` for `id: my-database`)

## Common Issues and Fixes

### Missing Required Fields
```yaml
---
id: my-database          # REQUIRED
location: https://...    # REQUIRED  
title: My Database       # REQUIRED
area:                   # REQUIRED (array)
  - number theory
---
```

### Invalid Area
Check `_data/areas.yml` for valid values:
```yaml
area:
  - number theory        # ✅ Valid
  - algebra             # ❌ Invalid - use 'rings and algebras'
```

### YAML Syntax Errors
Common issues:
```yaml
# ❌ Wrong indentation
area:
- number theory

# ✅ Correct indentation  
area:
  - number theory

# ❌ Missing quotes for special characters
title: Database: Numbers & More

# ✅ Proper quoting
title: "Database: Numbers & More"
```

## Integration with CI/CD

The tests can be integrated into GitHub Actions or other CI systems:

```yaml
# Example GitHub Action step
- name: Run validation tests
  run: |
    export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
    export GEM_HOME=$HOME/.gem
    ruby test_validation.rb
```

## Adding New Validation Rules

To add new validation rules, edit `test_validation.rb`:

1. Add validation logic to appropriate method (e.g., `validate_field_formats`)
2. Use `@errors << "message"` for critical issues
3. Use `@warnings << "message"` for recommendations
4. Test your changes with existing database entries

## Troubleshooting

### Bundle Install Issues
```bash
gem install bundler --user-install
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export GEM_HOME=$HOME/.gem
bundle install
```

### Jekyll Build Failures
Check that all required fields are present and YAML is valid before investigating Jekyll-specific issues.

### False Positives
If the validator reports an issue that seems incorrect:
1. Manually verify the YAML syntax with `python3 -c "import yaml; yaml.safe_load(open('_databases/file.md').read().split('---')[1])"`
2. Check if the issue affects the actual site generation
3. Consider if the validation rule needs adjustment