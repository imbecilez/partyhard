flat = require 'flat'


FLAT_OPTS =
  safe: true
  delimiter: '__'

flatten = (o) -> flat.flatten o, FLAT_OPTS
unflatten = (o) -> flat.unflatten o, FLAT_OPTS

filterKeys = (keys) -> (o) ->
  filtered = {}
  filtered[k] = v for k, v of o when k in keys
  filtered

merge = (objs) ->
  merged = {}
  merged[k] = v for k, v of o for o in objs
  merged

str2bool = (str) ->
  lower = str.toLowerCase()
  return true if lower in ['true', 'on', 'yes', '1']
  return false if lower in ['false', 'off', 'no', '0']
  throw new Error "Invalid boolean value '#{str}'"

# try to cast str val (from env, for example) to the type that key has in defaults
castValues = (defaults) ->
  cast = (k) ->
    switch typeof defaults[k]
      when 'boolean' then str2bool
      when 'number' then Number
      else (x) -> x
      #TODO: parse arrays?

  (overrides) ->
    obj = {}
    obj[k] = cast(k) v for k, v of overrides
    obj


defaults = require '../config'

flatDefaults = flatten defaults
castValuesBound = castValues flatDefaults
filterKeysBound = filterKeys Object.keys flatDefaults

locals =
  try require('../config.local') or {}
  catch e then {}


# the final config object is a combination of...
module.exports = unflatten merge [
  # defaults from `config`
  flatDefaults
  # filtered overrides from `config.local`
  filterKeysBound flatten locals
  # filtered overrides from env being cast to types from `config`
  #TODO: use prefix for env?
  castValuesBound filterKeysBound flatten process.env #
]
