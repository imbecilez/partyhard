angular.module module.exports = 'p-main', [
  require 'b-navbar'
  require 'b-player'
]

.run ['$templateCache', ($tc) ->
  $tc.put module.exports + '/p-main.tmpl', require './p-main.tmpl'
]

.controller 'p-main', ['$log', '$scope', ($l, $scope) ->
  $l.debug 'p-main'
]
