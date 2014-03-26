angular.module module.exports = 'app', [
  require 'angular-ui-router'
]


.config ['$stateProvider', ($stateProvider) ->
  $stateProvider
  .state 'main',
    url: ''
    template: '<h1>Sup!</h1>'
    controller: ['$log', ($l) ->
      $l.debug 'sup'
    ]
]


.run ['$rootScope', '$window', '$state', ($rootScope, $w, $state) ->
  $rootScope.$on '$stateChangeError', (e, _toS, _toP, _fromS, _fromP, err) ->
    throw err

  $rootScope.$on '$stateChangeSuccess', ->
    $w.scroll 0, 0
]
