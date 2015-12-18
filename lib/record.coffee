nconf = require 'nconf'
REDIS_HOST = nconf.get 'REDIS_HOST'
REDIS_PORT = nconf.get 'REDIS_PORT'
REDIS_AUTH = nconf.get 'REDIS_AUTH'
LOG_KEY = nconf.get "LOG_KEY"
redis = require('redis').createClient REDIS_PORT, REDIS_HOST
redis.auth REDIS_AUTH

valid = (log = "") -> log.split(",").length > 4

parse = (log = "") ->
  log = log.replace(/\\r\\n/, "").split(",")
  console.log "he #{log}"
  date = log.shift()
  sensors = log
  { date, sensors }


module.exports = ->

  get: (callback) ->
    redis.lrange LOG_KEY, 0, -1, (err, logs) ->
      return callback err if err
      callback err, logs.split(",")

  getLast: (callback) ->
    redis.lindex LOG_KEY, 0, (err, log) ->
      callback err, parse(log)

  removeInvalid: (callback) ->
    # redis.lrange LOG_KEY, 0, -1, (err, logs) ->
    #   logs.forEach (log, index) ->
    #     if not valid log
    #       redis.


  add: (log, callback) ->
    if valid log
      redis.lpush(LOG_KEY, log, callback)
    else
      callback? new Error 'Invalid data'
