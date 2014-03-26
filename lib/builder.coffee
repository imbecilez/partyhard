async = require 'async'
fs = require 'fs'
mkdirp = require 'mkdirp'
Builder = require 'component-builder'
debug = require('debug') 'partyhard:builder'
{MINIFY} = require './config'


plugins = [
  require('component-jade-static')()
  require 'component-coffee'
  require './component-stylus'
  require './component-config'
  require('./component-autoload') 'app'
]


module.exports = ({out, dir}) ->
  (callback) ->
    debug "building into #{out}"
    mkdirp.sync out

    builder = new Builder dir
    builder.prefixUrls './'
    builder.copyAssetsTo out

    builder.use p for p in plugins

    async.waterfall [
      (callback) ->
        try builder.build callback
        catch e then callback e

      (res, callback) ->
        require('./component-fix-aliases') res, 'coffee', 'jade'
        require('./component-minify') res if MINIFY

        debug "built. saving..."
        async.parallel [
          (callback) ->
            fs.writeFile out + '/index.js', res.require + res.js, callback
          (callback) ->
            fs.writeFile out + '/index.css', res.css, callback
        ], callback
    ], callback
