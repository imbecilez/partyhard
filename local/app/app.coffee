CFG = require 'config'


angular.module module.exports = 'app', [
  require 'angular-ui-router'
  require 'vk-api'
  require 'p-main'
]

.config ['vk-api.config', (cfg) ->
  cfg.id = CFG.VK_ID
  cfg.callback = CFG.VK_CALLBACK
]

.config ['$stateProvider', ($stateProvider) ->
  $stateProvider
  .state 'main',
    url: ''
    templateUrl: 'p-main/p-main.tmpl'
    resolve:
      tracks: ['$log', 'vk-api.call', ($l, api) ->
        api 'audio.get'
      ]
    controller: ['$scope', 'tracks', ($scope, tracks) ->
      $scope.tracks = tracks
    ]
]

.run ['$rootScope', '$window', ($root, $w) ->
  $root.$on '$stateChangeError', (e, _toS, _toP, _fromS, _fromP, err) ->
    throw err

  $root.$on '$stateChangeSuccess', ->
    $w.scroll 0, 0
]
