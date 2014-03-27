cfg =
  BUILD_DIR: __dirname + '/build'
  APP_DIR: __dirname
  PORT: 3000
  MINIFY: false

  ROOT_URL: 'http://dev.partyhard.heroku.com:3000'

  VK_ID: null


cfg.VK_CALLBACK = cfg.ROOT_URL + '/auth_callback'


module.exports = cfg
