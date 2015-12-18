# Main requires
x = require 'express'
{ join } = require 'path'
io = require 'socket.io'

# Configuration
nconf = require 'nconf'
nconf.env().file(file: join(__dirname, 'config.json'))

# Load middlewares
assets = require 'connect-assets'
bodyParser = require 'body-parser'
logger = require 'morgan'
favicon = require 'serve-favicon'

# Initialize app
app = do x

# Configure app
app.set 'views', join(__dirname, 'views')
app.set 'view engine', 'jade'

# Use middleware
app.use favicon join __dirname, 'public', 'favicon.ico'
app.use logger('combined')
app.use bodyParser.urlencoded(extended: no)
app.use assets(helperContext: app.locals)
app.use x.static(join(__dirname, 'public'))

# Load routes
require("./routes/index")(app)

# Start http server
server = app.listen process.env.PORT or 3000, ->
  console.log "Server listening on port #{server.address().port}"


