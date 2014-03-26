module.exports = (builder) ->
  builder.hook 'before scripts', (pkg, callback) ->
    return callback() if pkg.config.name != 'config'

    pkg.removeFile 'scripts', 'index.js',
    pkg.addFile 'scripts', 'index.js',
      "module.exports = #{JSON.stringify require './client-config'};"

    callback()
