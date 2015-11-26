nconf = require 'nconf'
REDIS_HOST = nconf.get 'REDIS_HOST'
REDIS_PORT = nconf.get 'REDIS_PORT'
REDIS_AUTH = nconf.get 'REDIS_AUTH'
redis = require('redis').createClient REDIS_PORT, REDIS_HOST
redis.auth REDIS_AUTH


valid = (log) ->
  true

module.exports = (options = {}) ->
  options.key or= "ene:record"

  get = (callback) ->
    redis.lrange options.key, 0, -1, (err, logs) ->
      return callback err if err
      callback err, logs.split(",")

  getLast = (callback) ->
    redis.lindex options.key, 0, callback

  add = (log, callback) ->
    if valid log
      redis.lpush(options.key, log, callback)
    else
      callback? new Error 'Invalid data'

  { get, add, getLast }