A5 = require 'audio5'


angular.module module.exports = 'player', []

.factory 'player', ['$rootScope', ($root) ->
  player = new A5
    swf_path: '/nl0-audio5js/swf/audio5js.swf'
    throw_errors: true
    format_time: false

  for e in [
    'canplay'
    'ended'
    'error'
    'loadedmetadata'
    'loadstart'
    'pause'
    'play'
    'progress'
    'ready'
    'seeked'
    'seeking'
    'timeupdate'
  ]
    player.on e, ->
      $root.$digest() unless $root.$$phase

  player
]

