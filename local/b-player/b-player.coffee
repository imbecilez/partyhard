angular.module module.exports = 'b-player', [
  require 'player'
]

.run ['$templateCache', ($c) ->
  $c.put module.exports + '/b-player.tmpl', require './b-player.tmpl'
]


.controller 'b-player', ['$log', '$scope', '$rootScope', '$q', 'player', ($l, $scope, $root, $q, player) ->
  $l.debug 'b-player', $scope.tracks, player, player.audio, player.audio.audio

  $scope.player = player
  stopped = true
  $scope.current = 0

  $scope.state = ->
    # 'stopped', 'playing', 'paused'
    if stopped then 'stopped' else if player.playing then 'playing' else 'paused'

  $scope._repeat = false
  $scope.repeat = (val) ->
    if val? then $scope._repeat = val else $scope._repeat

  $scope._shuffle = false
  $scope.shuffle = (val) ->
    if val? then $scope._shuffle = val else $scope._shuffle

  $scope.play = (idx) ->
    if $scope.current == idx and player.playing
      player.playPause()
    else
      player.pause()
      player.load $scope.tracks[idx].url
      player.play()
      $scope.current = idx
    stopped = false

  $scope.pause = ->
    player.playPause()

  $scope.stop = ->
    player.pause()
    stopped = true

  $scope.next = ->
    #TODO: handle repeat
    #TODO: handle shuffle
    $scope.play ($scope.current + 1) % $scope.tracks.length

  $scope.prev = ->
    #TODO: handle repeat
    #TODO: handle shuffle
    $scope.play ($scope.current - 1 + track.length) % $scope.tracks.length

  player.on 'ended', $scope.next
]
