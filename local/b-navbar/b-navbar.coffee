angular.module module.exports = 'b-navbar', []

.run ['$templateCache', ($tc) ->
  $tc.put module.exports + '/b-navbar.tmpl', require './b-navbar.tmpl'
]

.controller 'b-navbar', ['$log', '$scope', ($l, $scope) ->
  $l.debug 'b-navbar'
]
