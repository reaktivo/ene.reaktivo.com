record = require('../lib/record')()

module.exports = (app) ->

  app.get '/', (req, res, next) ->
    res.send 'Hello'

  app.post '/3cd83684b697696febe55ea1fb42aa596e6aa657', (req, res, next) ->
    record.add req.body.log, (err) ->
      res.send err or 'OK'

  app.get '/last', (req, res, next) ->
    record.getLast (err, row) ->
      res.send err or row