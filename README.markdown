governor_comments
=================

**[Governor](http://carpeliam.github.com/governor/)** (named after Rod
Blagojevich) is the pluggable blogging platform for Rails, built for people
who want to build their blog into their website, not build their website into
their blog.

**governor_comments** is a plugin for Governor, allowing users and guests to
comment on your blog.

Dependencies
------------

* Governor, version 0.2.0 or higher. In addition, it requires that your User
  class (or whatever classes can be associated with an article) have `name`,
  `email`, and `website` fields.
* ActiveRecord
* Optional: [Rakismet](https://github.com/joshfrench/rakismet/) to integrate
  Akismet spam filtering.

Setting Up
----------

First, install [Governor](http://carpeliam.github.com/governor/). Then, in
your Gemfile, add the following:

    gem 'governor_comments'

Once you've installed the gem into your app, you need to run the generator:

    rails generate governor:create_comments

This will create a Comment class and associated migration. Make sure to add
the `name`, `email`, and `website` fields to your User model if they don't
exist already.

Usage
-----

Now, when you browse to an article, you'll see places to add comments right in
the page. You really don't have to do anything special at this point.

Contributing to governor_comments
---------------------------------
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
---------

Copyright &copy; 2011 Liam Morley. See LICENSE.txt for further details.

