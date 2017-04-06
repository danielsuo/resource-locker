## Resource Locker

[![Build Status](https://travis-ci.org/dmcouncil/resource-locker.svg?branch=master)](https://travis-ci.org/dmcouncil/resource-locker)
[![Code Climate](https://codeclimate.com/repos/58505598fb4faa0dd8001946/badges/8b0fe770fb4e9f563143/gpa.svg)](https://codeclimate.com/repos/58505598fb4faa0dd8001946/feed)

Resource Locker is a relatively simple Sinatra app for coordinating the use of shared resources. It doesn't actually lock the resources, of course (unless you write code to do so); instead it tracks when users have "claimed" the resource and for how long, and so other users hoping to use it will know, on asking, if the resource is in use and who is using it.

It is designed to function as a Slack app, i.e. it expects POST requests to its one endpoint and parses the 'text' parameter of the request for additional request data.

When this is set up as a Slack integration with an appropriate instance as the endpoint, the command syntax in Slack works like this:

    /lock [resource [duration]]

`/lock` by itself returns a list of lockable resources.

`/lock resource_name` with a resource name but no duration returns the status of that resource - either "not locked" or "locked for another _n_ minutes".

Finally, `/lock resource_name 30` attempts to lock that resource for 30 minutes. The length of the requested lock is in integer minutes (so e.g. five hours is 300). If the resource is not already locked, the return message will post to the entire channel, describing what was locked, by whom, and for how long.

The user "holding" the lock can release it using `/lock resource_name 0`.

If the resource was already locked, the member requesting the lock will see the status of the resource (i.e. "locked by bruce for another 5 minutes") and no message will be shown to the whole channel.

### Deploying from OS X
```bash
# Install Heroku CLI
brew install heroku

# Log in to Heroku
heroku login

# Create new app
heroku create $APP_NAME

# Add postgres
heroku addons:create heroku-postgresql:hobby-dev -a $APP_NAME

# Add git remote
heroku git:remote -a $APP_NAME

# Deploy application
git push heroku master
```

- Set up app on Slack ([here](http://li-group-locker.herokuapp.com/))
- Install app to your team
- Copy the resource token
- heroku config:set SLACK_REQUEST_TOKEN=$TOKEN -a $APP_NAME

### Developing on OS X
```bash
# Clone repository
git clone https://github.com/danielsuo/resource-locker
cd resource-locker

# Install postgres
brew install postgresql

# Install bundler and install dependencies (may need sudo)
gem install bundler
bundle install

# Run locally
ruby lock.rb -p 3000
```

### TODO

Things that will make single-site usage easier:

* [x] Allow users to release locks
* [x] Move Slack token to ENV variable (Figaro?)
* [x] Cap the length of lock allowed (again, possibly an env variable)
* [x] Provide for resource setup: how do we add/update/remove resources?
* [x] [Test main application](http://www.sinatrarb.com/testing.html)
* [x] [Get CI working](https://travis-ci.org/dmcouncil/resource-locker)
* [ ] More flexible authorization, so non-Slack clients can use it as an API

Things needed for wider Slack use:

* [ ] Multi-tenancy: scoping resources by team
* [ ] Better authentication/authorization

Other ideas (feature creep):

* [x] Now that we're testing, add and configure Guard?
* [ ] "Subscribe" to locked resources (see #3)
* [ ] Remind lock owners of expiring locks and send cut-and-paste command to extend or re-lock (see #4)

### Colophon

Resource Locker was built by [Parker Morse](/pjmorse) at [District Management Group](https://dmgroupK12.com).
