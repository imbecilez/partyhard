module.exports = (name) -> (builder) ->
  builder.append "require('#{name}');\n"
