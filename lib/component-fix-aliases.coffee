# fix aliases for compiled files (workaround)
fixAliases = (js, exts...) ->
  for ext in exts
    re = new RegExp "require\\.alias\\(\\\"(.*)\\.#{ext}\\\", \\\"(.*)\\.#{ext}\\\"\\);", 'g'
    js = js.replace re, "require.alias(\"$1.js\", \"$2.js\");"
  js


# remove duplicate aliases
rmDups = (js) ->
  aliases = []
  res = ''

  for l in js.split '\n'
    if l.match /require\.alias\(.*\);/
      continue if l in aliases
      aliases.push l

    res += '\n' if res
    res += l

  res


module.exports = (res, exts...) ->
  res.js = rmDups fixAliases res.js, exts...
