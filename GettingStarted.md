# Linux

1. Install Ruby

2. Bootstrap

> gem install --user-install
> export GEM_HOME=$HOME/.gem
> export GEM_PATH=$HOME/.gem
> bundle install

# Mac

1. Install Ruby:
 - on a Mac, you can use Homebrew with

  brew install ruby
  echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
  source ~/.zshrc

of you can follow https://www.moncefbelyamani.com/the-definitive-guide-to-installing-ruby-gems-on-a-mac/

2. Clone this repo

3. Run `make bootstrap` (this only needs to be done once on your system)

4. Run `make serve` to run locally
