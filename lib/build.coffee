jade = require 'jade'
fs = require 'fs'
path = require 'path'
debug = require('debug') 'partyhard:build'
builder = require './builder'
{BUILD_DIR, APP_DIR} = require './config'


build = builder
  dir: APP_DIR
  out: BUILD_DIR

build (err) ->
  throw err if err

  index = jade.renderFile path.join(APP_DIR, 'index.jade'), require './client-config'
  fs.writeFileSync path.join(BUILD_DIR, 'index.html'), index
