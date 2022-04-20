run:
	@bundle exec jekyll serve
start: run
build:
	@jekyll build --trace
webrick:
	@bundle add webrick
install: 
	@bundle install
all: install run