_    = require 'lodash'
http = require 'http'

class RejectYourAs
  constructor: (options={}) ->

  _doCallback: (request, code, callback) =>
    response =
      metadata:
        responseId: request.metadata.responseId
        code: code
        status: http.STATUS_CODES[code]
    callback null, response

  do: (request, callback) =>
    return @_doCallback request, 403, callback if request.metadata?.auth?.as?
    return @_doCallback request, 204, callback

module.exports = RejectYourAs
