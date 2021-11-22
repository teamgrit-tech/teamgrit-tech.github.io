run:
	@bundle exec jekyll serve
start: run
webrick:
	@bundle add webrick
install: 
	@bundle install
all: install run