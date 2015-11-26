fs = require 'fs'

dir = "cinedf.mx"

opts =
  host: 'drop.reaktivo.com'
  username: 'root'
  privateKey: '/Users/reaktivo/.ssh/id_rsa'

plan = new (require 'flightplan')

plan.briefing
  debug: no
  destinations:
    production: opts

plan.local (local) ->
  local.git 'push'

plan.remote (remote) ->
  remote.git "clone git@github.com:reaktivo/#{dir}.git", failsafe: yes
  remote.with "cd #{dir}", ->
    remote.git 'pull'
    remote.npm 'install --production'
    remote.exec "pm2 reload #{dir}"

module.exports = plan