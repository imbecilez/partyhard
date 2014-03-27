angular.module module.exports = 'errors', []


.constant 'Exception', do ->
  class Exception extends Error
    constructor: (args...) ->
      super
      @message = args[0]
      @args = args

    toString: ->
      "[Exception: #{@message}]"
