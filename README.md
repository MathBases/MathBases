# MathBases

To contribute dataset information, fill in `template.md`, rename based on the dataset title, place into `_databases`, and submit via a pull request.

## Directory/file structure

Files in the root directory:

* page not found file: `404.html`,
* configuration files: `Gemfile` (Gem dependencies), `Makefile`, `CNAME`, `.gitignore`, `_config.local.yml`, `_config.yml`,
* content: `board.md`, `create.md`, `index.md`, `info.md`, `policies.md`,
* database entry template: `template.md`,
* deprecated: `DATA.md` (MathDB data in Markdown) and `split_data.py` (a script converting old data to YAML).

### Directories

* `_data`: YAML files for navigation, badges and tags.
* `_databases`: the contents of the MathBases database, one file for each entry.
* `_includes` and `_layouts`: page templates.
* `_topics`: short expository articles about data in various areas of mathematics (currently just for algebraic geometry).
* `_assets`: currently just the css overrides.

## Installing

To generate web pages locally for preview, you need Jekyll, which needs Ruby (along with an extensive array of subordinate Ruby packages). 

### Linux

1. Install Ruby (and possibly ruby-dev)

2. Bootstrap

```
gem install bundler --user-install
export GEM_HOME=$HOME/.gem
bundle install
```

3. Run `make serve` to run locally

### Mac

1. Install Ruby:

  - on a Mac, you can use Homebrew with

    ```
    brew install ruby
    echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
    source ~/.zshrc
    ```

  - of you can follow https://www.moncefbelyamani.com/the-definitive-guide-to-installing-ruby-gems-on-a-mac/

2. Clone this repo

3. Run `make bootstrap` (this only needs to be done once on your system).

To do this locally, you can instead do the following.

```
gem install bundler --user-install
bundle config set --local path '/home/YOURUSERNAME/.local/share/gem'
bundle install
```

or a similar path of your choosing.

4. Run `make serve` to run locally
