stylusPlugin = require 'component-stylus-plugin'
nib = require 'nib'
stylus = require 'stylus'


stylusPlugin.includeCSS = true

stylusPlugin.paths.push __dirname + '/../local'

stylusPlugin.plugins.push nib()

stylusPlugin.plugins.push (renderer) ->
  # enable media inlining for images, fonts, etc.
  renderer.define 'url', stylus.url paths: '.'


module.exports = stylusPlugin
