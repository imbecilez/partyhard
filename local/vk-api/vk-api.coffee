{parse, stringify} = require 'querystring'

angular.module(module.exports = 'vk-api', [
  require 'errors'
])

.constant 'vk-api.config',
  id: null # overload
  callback: null # overload
  auth: 'https://oauth.vk.com/authorize'
  method: 'https://api.vk.com/method'

.factory 'vk-api.ApiError', ['Exception', (Exception) ->
  class ApiError extends Exception
]

.factory 'vk-api.call', ['$q', '$http', '$interval', '$timeout', 'vk-api.config', 'vk-api.ApiError', ($q, $http, $int, $t, cfg, ApiError) ->
  waitWindow = (initLocation, w) ->
    dfd = $q.defer()
    interval = $int ->
      try
        return if w.location.href in [initLocation, 'about:blank']
        $int.cancel interval
        dfd.resolve w.location.hash.substr 1
      catch e
    , 500

    dfd.promise

  authenticate = ->
    params =
      client_id: cfg.id
      scope: 'audio'
      redirect_uri: cfg.callback
      display: 'page'
      response_type: 'token'

    url = "#{cfg.auth}?#{stringify params}"

    tryAuth = ->
      w = open url
      waitWindow url, w
      .then (qs) ->
        w?.close()
        parse qs

    dfd = $q.defer()

    waitAuth = ->
      tryAuth().then (data) ->
        token = data.access_token ? data['/access_token']
        if token?
          dfd.resolve token
        else
          $l.debug 'error getting token', data
          $t waitAuth

    waitAuth()

    dfd.promise

  auth = authenticate()

  (method, args) ->
    auth.then (token) ->
      $http.jsonp "#{cfg.method}/#{method}",
        params: angular.extend {}, args,
          access_token: token
          callback: 'JSON_CALLBACK'
      .then ({data}) ->
        data.response
    , (err) ->
      $q.reject new ApiError err
]
