# Creeper

![creeper](http://f.cl.ly/items/0W1F0H2b1e373X3a262z/creeper-poster-cartoon-show.jpg)

CreeperMon (or Creeper for short), is a website/tool for deploying multiple websites to a single instance. Think of it as a [HAM](http://www.urbandictionary.com/define.php?term=H.A.M) fisted [PAAS](https://en.wikipedia.org/wiki/Platform_as_a_service).

## Flow

Or the steps a user goes through.

### New User

 1. Creates a git repository accessible over SSH that will contain configs.
 2. User downloads template files, modifies them, and commits them.
 3. CM looks at the repo and verifies everything is alright.
 4. CM spins up an instance.
 5. CM configures the instance.
 6. CM installs the sites as defined in the config.

### Existing User

Existing User has two flows

#### Just update one site

 1. User comes to site.
 2. User selects a site from a dropdown, clicks update.
 3. CM connects to instance, updates code and restarts site.

#### Update all of the sites

 1. User comes to site.
 2. User clicks button that says update all of the things.
 3. CM spins up an instance.
 4. CM configures the instance.
 5. CM installs the sites as defined in the config.
 6. CM Updates DNS for sites so they point to new server.
 7. CM takes snapshot and deletes old instance.
