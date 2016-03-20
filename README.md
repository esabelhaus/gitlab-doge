gitlab-doge
=====

[![Build Status](https://travis-ci.org/esabelhaus/gitlab-doge.svg?branch=master)](http://travis-ci.org/esabelhaus/gitlab-doge?branch=master)
[![Dependency Status](https://gemnasium.com/esabelhaus/gitlab-doge.svg)](https://gemnasium.com/esabelhaus/gitlab-doge)
[![Code Climate](https://codeclimate.com/github/esabelhaus/gitlab-doge.png)](https://codeclimate.com/github/esabelhaus/gitlab-doge)

This project is originally a fork of [Hound](https://github.com/thoughtbot/hound) by thoughtbot, and once more
from [larrylv/hound-gitlab](https://github.com/larrylv/hound-gitlab).

gitlab-doge reviews GitLab merge requests (and soon pushes) for style guide violations. [View the style
guide &rarr;](https://github.com/thoughtbot/guides/tree/master/style)

## Configure gitLab-doge on Your Local Development Environment

1. After cloning the repository, run the setup script `./bin/setup`
2. Log into your Gitlab account and go to the [Account Page](https://gitlab.com/profile/account).
3. Copy the `Private token` to HOUND_GITLAB_TOKEN in `.env`, and then fetch your userid
   with that token for HOUND_GITLAB_USERID in .env file.

   3.a This can be performed through your browser by simply browsing to http(s)://gitlab.example.com/api/v3/users?search=[your user name]

   3.b Note the setup script copies `.sample.env` to `.env` for you, if the file does not exist.
4. Edit the following in the .env file:
```
	DATABASE_USERNAME
	DATABASE_PASSWORD
	GITLAB_URL [base gitlab url, no trailing slash]
	GITLAB_ENDPOINT
	HOST
	WEB_CONCURRENCY [I recommend 1 for development]
```
5. Be certain that you have a redis server running locally at port 6379
6. Run `foreman start`. Foreman will start the web server and sidekiq

  6.a keep in mind, sidekiq will quit gracefully, so if you need to terminate the process just run a `kill -9` on whatever pid  is in tmp/pids/sidekiq.pid

Testing
-----------

1. Set up your `development` environment as per above.
2. Run `rake` to execute the full test suite.

***
The tests need to me rewritten, YMMV for now
***

Contributing
------------

First, thank you for contributing!

Here a few guidelines to follow:

1. Write tests
2. Make sure the entire test suite passes locally and on Travis CI
3. Open a pull request on GitHub
4. [Squash your commits](https://github.com/thoughtbot/guides/tree/master/protocol/git#write-a-feature) after receiving feedback

There a couple areas we would like to concentrate on.

1. Add support for JavaScript
2. Add support for CSS and Sass
3. Write [style guides](app/models/style_guide) that don't currently exist and
   would enforce the
   [thoughtbot style guide](https://github.com/thoughtbot/guides).
