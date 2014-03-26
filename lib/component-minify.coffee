CleanCSS = require 'clean-css'
uglifyJS = require 'uglify-js'


CLEAN_CSS_OPTS = {}
UGLIFY_JS_OPTS =
  fromString: true


module.exports = (res) ->
  res.css = new CleanCSS(CLEAN_CSS_OPTS).minify res.css if res.css
  res.js = uglifyJS.minify(res.js, UGLIFY_JS_OPTS).code if res.js
  res.require = uglifyJS.minify(res.require, UGLIFY_JS_OPTS).code if res.require
