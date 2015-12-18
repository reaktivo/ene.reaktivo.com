record = require("../lib/record")()
nconf = require "nconf"
REDIS_HOST = nconf.get "PRIVATE_LOG_PATH"

module.exports = (app) ->

  app.get "/", (req, res, next) ->
    res.render "index", title: "ENE"

  app.post "/3cd83684b697696febe55ea1fb42aa596e6aa657", (req, res, next) ->
    record.add req.body.log, (err) ->
      res.send err or "OK"

  app.get "/last", (req, res, next) ->
    record.getLast (err, row) ->
      console.log row
      res.send err or row