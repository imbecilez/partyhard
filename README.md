# partyhard

## Environment setup

Just run `make` to set everything up.

## Configuration

There are 2 ways to override settings:

1. `config.local.coffee` file.

2. Environment variables (e.g. `OPT=val command`).
   Nested options are delimited by `__`
   (e.g. `OPT__NESTED` env var is equivalent to js `OPT.NESTED`).

Available options can be found in `config.coffee`

## Running

Just run `make srv` to fire up the dev server.

## Building

Run `make build` to build all the assets into `build` directory.
Assets then can be served statically (with fallback to `index.html`).

## Layout

* `index.jade` -- html file given to the browsers (app entry point)
* `local` -- local components
* `styl` -- stylus stylesheets
* `bin` -- executables
* `build` -- built client-side assets
* `lib` -- server-side code
* `config.coffee` -- configuration file
* `config.local.coffee` -- local configuration overrides (optional)

## Makefile

* `make[ env]` (default target) -- set up the environment
* `make build` -- build client-side assets
* `make srv` -- run the dev server (on port 3000 by default)
* `make clean` -- clean up the built assets
* `make clean_all` -- clean up everything (assets, node modules, components)

Dependencies are being set up and tracked automatically.
See the `Makefile` for details.
