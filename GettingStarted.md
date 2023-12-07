# Linux

1. Install Ruby (and possibly ruby-dev)

2. Bootstrap

```
gem install bundler --user-install
export GEM_HOME=$HOME/.gem
bundle install
```

3. Run `make serve` to run locally

# Mac

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
