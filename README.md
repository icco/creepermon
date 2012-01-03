# creeper

Creeper has been many things in my mind, but in reality, it's just me playing with the GitHub API.

![creeper](http://f.cl.ly/items/0W1F0H2b1e373X3a262z/creeper-poster-cartoon-show.jpg)

## Feature List

 * Pings websites every five minutes
   * TODO
   * Send out email to user saying "hey! I think your site is down"
 * Provides stats about the logged in user's use of GitHub
   * TODO
 * Be an intermediary for GitHub post-receive hooks.
   * Store a list of things to do when GH sends us a hook?
   * TODO

## Useful links

 * <http://developer.github.com/v3/events/types/#pushevent>
 * <http://creeper.herokuapp.com/>
 * <http://developer.github.com/v3/repos/commits>

## TODO

 * Figure out why there are no dates on some of the commits
 * have a background process verify the commits belong to a user
 * have a background process traverse a commit tree through time
 * make graphs
 * start actually pinging sites
 * force http urls
