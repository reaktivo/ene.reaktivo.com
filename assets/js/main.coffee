class Main

  body: $('body')
  window: $(window)

  constructor: ->
    setInterval (=> do @update), 2000

  update: ->
    $("#data").load("/last")

  viewport: ->
    if typeof window.innerWidth is 'undefined'
      width: document.documentElement.clientWidth
      height: document.documentElement.clientHeight
    else
      width: window.innerWidth
      height: window.innerHeight

# window.onbeforeunload = -> 'Testing...'
$(document).ready ->
  window.app = new Main