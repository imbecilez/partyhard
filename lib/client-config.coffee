EXPOSE = [
  'MINIFY'
  'VK_ID'
  'VK_CALLBACK'
]


cfg = {}

cfg[k] = v for k, v of require('./config') when k in EXPOSE

module.exports = cfg
