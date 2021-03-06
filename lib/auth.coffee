module.exports = {}
Crypt=require('./crypt')
module.exports.validate_json_array_of_string = (json)->
  json.match(/^\[[ ]*"[a-z0-9]+"[ ]*(,[ ]*"[a-z0-9]*"[ ]*)*\]$/ig) != null


module.exports.auth = (token, iv, secret, listen)->
  try
    json = Crypt.decrypt(token,secret, iv)
    if module.exports.validate_json_array_of_string(json)
      channels = JSON.parse(json)
    else
      throw Error("JSON IS NOT VALID")
  catch error
    console.log "Auth Error: #{error}"
    return
  for i in channels
    listen(i)
