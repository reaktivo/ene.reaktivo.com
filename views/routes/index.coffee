{ findWhere } = require 'underscore'
record = require '../lib/record'

module.exports = (app) ->

  app.post '/', (req, res, next) ->
    record.add req.body, (err) ->
      if err
      	res.status 500
        res.send '/NOT-OK'
      else
        res.send '/OK'

  app.get '/', (req, res, next) ->
    res.send "/HELLO"