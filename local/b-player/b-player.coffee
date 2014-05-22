angular.module module.exports = 'b-player', [
  require 'player'
]

.run ['$templateCache', ($c) ->
  $c.put module.exports + '/b-player.tmpl', require './b-player.tmpl'
]


.controller 'b-player', ['$log', '$scope', '$rootScope', '$q', 'player', 'Playlist', ($l, $scope, $root, $q, player, Playlist) ->
  $l.debug 'b-player', $scope.tracks, player

  $scope.player = player
  $scope.playlist = player.playlist = new Playlist $scope.tracks
]
