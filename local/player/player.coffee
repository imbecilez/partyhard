A5 = require 'audio5'


angular.module module.exports = 'player', []


.factory 'Player', ['$rootScope', ($root) ->
  constructor = ->
    @_player = new A5
      swf_path: '/nl0-audio5js/swf/audio5js.swf'
      throw_errors: false
      format_time: false

    @track = null
    @playlist = null

    @_reset = =>
      @duration = null
      @position = 0
      @loadPercent = 0
      @playing = false

    @_reset()

    @_player.on 'play', => @$apply =>
      @playing = true

    @_player.on 'pause', => @$apply =>
      @playing = false

    @_player.on 'ended', => @$apply =>
      @playing = false
      @next()

    @_player.on 'timeupdate', (pos, dur) => @$apply =>
      @position = pos
      @duration = dur

    @_player.on 'progress', (prc) => @$apply =>
      @loadPercent = prc

    @_player.on 'error', (e) => @$apply =>
      throw e

    @next = =>
      if t = @playlist?.next().track
        @load t
        @play()
      @

    @prev = =>
      if t = @playlist?.prev().track
        @load t
        @play()
      @

    @load = (track) =>
      @_reset()
      if track?.url
        @track = track
        @_player.load track.url
      @

    @play = =>
      @_player.play()
      @

    @pause = =>
      @_player.pause()
      @

    #@stop = =>
      #@_player.pause()
      #@

    @playPause = =>
      @_player.playPause()
      @

    @vol = (vol) =>
      if vol?
        @_player.volume vol
        @
      else @_player.volume()

    @seek = =>
      @_player.seek arguments...
      @

    @

  Player = ->
    constructor.apply $root.$new true
]


.factory 'Playlist', ->
  class Playlist
    constructor: (tracks) ->
      @_tracks = tracks?[..] ? []
      @_idx = null
      @_current = null
      @_repeat = false

    shuffle: =>
      #TODO: shuffle @_tracks
      @

    repeat: (val) =>
      if val?
        @_repeat = val
        @
      else @_repeat

    select: (idx) =>
      @_idx =
        if 0 <= idx < @_tracks.length
          idx
        else if @_repeat
          (idx + @_tracks.length) % @_tracks.length
        else null

      @_current = if @_idx? then @_tracks[@_idx] else null
      @

    next: => @select if @_idx? then @_idx + 1 else 0
    prev: => @select if @_idx? then @_idx - 1 else 0

    add: (track, idx) =>
      idx ?= @_tracks.length
      @_idx += (@_idx? and @_idx > idx)
      @_tracks.splice idx, 0, track
      @

    rm: (idx) =>
      @_tracks.splice idx, 1
      if @_idx == idx
        @_idx = @_current = null
      @

    tracks: (tracks) =>
      if tracks?
        @_tracks = tracks
        @_idx = @_current = null
        @
      else @_tracks

    current: => @_current
    idx: => @_idx


.factory 'player', ['Player', 'Playlist', (Player, Playlist) ->
  Player()
]
