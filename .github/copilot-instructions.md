# MathBases

MathBases is a Jekyll-based static website that catalogs mathematical databases. It uses Ruby, bundler, and Jekyll with various plugins to generate a website from Markdown files and YAML frontmatter. The site features collections of databases, articles, conferences, ideas, and topics related to mathematical databases.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

- Bootstrap and build the repository:
  - Ensure Ruby is installed (version 3.2+ works well)
  - `gem install bundler --user-install`
  - `export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"`
  - `export GEM_HOME=$HOME/.gem`
  - `bundle install` -- takes 80 seconds to complete. NEVER CANCEL. Set timeout to 3+ minutes.
- Build the static site:
  - `make build` or `bundle exec jekyll build --trace --config _config.yml,_config.local.yml` -- takes 7 seconds to complete. NEVER CANCEL. Set timeout to 30+ seconds.
- Run the development server:
  - `make serve` or `bundle exec jekyll serve --trace --config _config.yml,_config.local.yml`
  - Site runs on http://127.0.0.1:4000
  - Server starts in about 5 seconds

## Validation

- ALWAYS manually validate changes by running the development server and testing affected pages.
- Test database entries by visiting http://127.0.0.1:4000/d/[database-id] where database-id matches the `id` field in the YAML frontmatter.
- Validate YAML frontmatter syntax: `python3 -c "import yaml; yaml.safe_load(open('_databases/filename.md').read().split('---')[1])"`
- The Jekyll doctor command has known issues with the current configuration - do not rely on `jekyll doctor`.
- Always test that new database entries appear in the main site navigation and search.
- Note: Database URLs use the lowercase `id` field from YAML frontmatter, not the filename.

### Complete Validation Scenario

After making changes to database entries or site content:

1. Set environment variables:
   ```bash
   export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
   export GEM_HOME=$HOME/.gem
   ```
2. Validate YAML syntax: `python3 -c "import yaml; yaml.safe_load(open('_databases/your-file.md').read().split('---')[1])"`
3. Build the site: `make build`
4. Start development server: `make serve`
5. Test the specific database page: Visit http://127.0.0.1:4000/d/[database-id]
6. Verify the database appears in the site's main listing
7. Check that all links and metadata display correctly

## Common Tasks

The following are outputs from frequently run commands. Reference them instead of viewing, searching, or running bash commands to save time.

### Repository Structure
```
.
├── README.md              # Setup and contribution instructions  
├── Makefile              # Build commands: bootstrap, serve, build
├── Gemfile               # Ruby dependencies
├── _config.yml           # Main Jekyll configuration
├── _config.local.yml     # Local development configuration
├── _data/                # YAML files for navigation, badges, tags
├── _databases/           # Mathematical database entries (*.md files)
├── _articles/            # Expository articles about database creation
├── _conferences/         # Conference announcements
├── _ideas/               # Database ideas from the community
├── _topics/              # Short articles about math areas
├── _includes/            # Jekyll template partials
├── _layouts/             # Jekyll page templates
├── assets/               # CSS and other static assets
├── template.md           # Template for new database entries
└── contributing.md       # Contribution guidelines
```

### Key Files to Know

- **_databases/**: Each `.md` file represents one mathematical database with YAML frontmatter containing metadata (id, title, location, area, tags, badges, etc.) and Markdown content describing the database.
- **template.md**: Complete template showing all available fields for database entries.
- **_data/areas.yml**: Valid mathematical areas for the `area` field.
- **_data/tags.yml**: Valid tags for the `tags` field.
- **_data/badges.yml**: Valid badges for the `badges` field.

### Environment Setup Commands
```bash
# Install bundler (required once per system)
gem install bundler --user-install

# Set environment variables (required each session)
export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"
export GEM_HOME=$HOME/.gem

# Install dependencies (required once per repository)
bundle install
```

### Development Workflow

1. Always set the required environment variables before running any Jekyll commands
2. Use `make serve` for development - site updates automatically on file changes
3. Database entries use the `id` field for URLs, not the filename
4. Test new entries by visiting http://127.0.0.1:4000/d/[id]
5. Validate YAML syntax before committing changes
6. Check that new entries appear in site navigation

### Common Gotchas

- **File vs ID mismatch**: Database filenames can differ from the `id` field in YAML frontmatter. URLs use the `id` field.
- **Environment variables**: Jekyll commands will fail without proper PATH and GEM_HOME setup.
- **YAML syntax**: Invalid YAML in frontmatter will cause build failures. Always validate syntax.
- **Area/Tag validation**: Use only values from `_data/areas.yml` and `_data/tags.yml`.
- **Bootstrap permissions**: The Makefile's `make bootstrap` command requires sudo. Use the manual gem install approach instead.

### Timing Expectations

- **Bundle install**: ~80 seconds (first time), ~1 second (subsequent) - NEVER CANCEL, set timeout to 3+ minutes
- **Jekyll build**: ~6 seconds - NEVER CANCEL, set timeout to 30+ seconds  
- **Jekyll serve startup**: ~5 seconds - NEVER CANCEL, set timeout to 30+ seconds
- **Site regeneration during development**: ~1-2 seconds per change

### YAML Frontmatter Reference

Every database entry requires these fields in YAML frontmatter:
- `id`: Unique identifier (becomes the URL slug)
- `location`: Website or primary access URL
- `title`: Display name of the database
- `area`: List of mathematical areas (must match `_data/areas.yml`)

Optional but recommended fields:
- `license`: Data usage license
- `short_description`: One sentence description
- `authors`: List with name/email/homepage
- `tags`: List of tags (must match `_data/tags.yml`)
- `badges`: List of badges (must match `_data/badges.yml`)

### No Testing Infrastructure

This project does not have automated tests. Validation is done through:
1. Jekyll build success
2. Manual testing in development server
3. YAML syntax validation
4. Visual inspection of generated pages