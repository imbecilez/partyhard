debug = require('debug') 'partyhard:srv'
express = require 'express'
temp = require 'temp'
builder = require './builder'
{APP_DIR, PORT} = require './config'


temp.track()
buildDir = temp.mkdirSync()


build = builder
  dir: APP_DIR
  out: buildDir

buildMiddleware = (req, res, next) -> build next

app = express()
app.set 'view engine', 'jade'
app.set 'views', APP_DIR

app.use express.logger 'dev'

app.use express.static buildDir

app.all 'auth_callback', (req, res) -> res.send ''

app.all '*', buildMiddleware, (req, res) ->
  res.render 'index', require './client-config'

app.use express.errorHandler()


app.listen PORT, ->
  console.log "running dev server on http://localhost:#{PORT}"
