# Creepermon

![creeper](http://f.cl.ly/items/0W1F0H2b1e373X3a262z/creeper-poster-cartoon-show.jpg)

Creepermon is an app for monitoring websites in a really stupid way. It doesn't do alerting. It just curls your websites and creates graphs.

## Architecture

Creepermon takes a yaml file that defines a list. Each item in the list is a url and html xpath. We log each scrape to [Keen.io](https://keen.io/) and build a nice dashboard to show you all of your sites.

Each scrape collects:

 - Status code
 - Scrape time
 - Value to xpath target

The value of the xpath target is turned into an integer before storage.

## Installation

Clone, change `sites.yml`, push to heroku.

Set Heroku config:

```sh
heroku config:set KEEN_PROJECT_ID=aaaaaaaaaaaaaaaaaaaaaaaa KEEN_READ_KEY=eeeeeeeeeeeeeeeeeeeeeeee KEEN_WRITE_KEY=ffffffffffffffffffffffff
heroku config:set LANG=en_US.UTF-8
heroku config:set RACK_ENV=production
```

Add the [Heroku Scheduler](https://scheduler.heroku.com/)

```sh
heroku addons:create scheduler:standard
```

Then add `rake cron` to run every ten minutes

![sched](http://cl.natw.me/gGkM/d)
