module.exports = (robot) ->

  #robot.respond /give timestamp (.*)?/i, (msg) ->
  #  msg.reply msg.match[1]
  #  msg.reply Date.now() + " Timestamp: " + Math.floor(Date.now() / 1000)

  # Give me timestamp
  robot.respond /give timestamp/i, (msg) ->
    date = new Date()
    str = Math.floor(date / 1000)
    msg.reply "#{date} convert timestamp is: #{str}"

  # Give me timestamp by parameter
  robot.respond /convert timestamp (.*)/i, (msg) ->
    param = msg.match[1]
    timestamp = new Date(param*1000)
    msg.reply "Your timestamp #{param} convert date is: #{timestamp}"

  # Convert string to base64
  robot.respond /base64 encode (.*)/i, (msg) ->
    msg.send "Your value convert to base64 to: " + new Buffer(msg.match[1]).toString('base64')

  # Convert base64 to string
  robot.respond /base64 decode (.*)/i, (msg) ->
    msg.send "Your value convert to string to: " + new Buffer(msg.match[1], 'base64').toString('utf8')

  # UTF-8 length by parameter string
  robot.respond /count utf8 (.*)/i, (msg) ->
    param = msg.match[1]
    str = encodeURIComponent("#{param}");
    strlength = str.replace(/%[A-F\d]{2}/g, 'U').length;
    msg.reply "Your string length is: #{strlength} (UTF-8)"

  # String length by parameter
  robot.respond /count length (.*)/i, (msg) ->
    param = msg.match[1]
    strlength = param.length
    msg.reply "Your string length is: #{strlength}"

  # Check is match regex by parameter
  robot.respond /check regex (.*) by (.*)/i, (msg) ->
    regexParam = msg.match[1]
    pairParam = msg.match[2]

    regex = new RegExp("#{regexParam}");
    regexChk = regex.exec("#{pairParam}")
    if regexChk != null
      msg.reply "Your value #{pairParam} is match: #{regexChk}"
    else
      msg.reply "Your value #{pairParam} is not match"

  # Encode string by parameter
  robot.respond /encode uri (.*)/i, (msg) ->
    param = msg.match[1]
    str = encodeURIComponent(param)
    msg.reply "Your value #{param} is encode uri to: #{str}" 

  # Convert json by parameter
  robot.respond /verify json (.*)/i, (msg) ->
    param = msg.match[1]
    try 
      obj = JSON.parse(param)
      msg.reply "Your value can be object." 
    catch e
      msg.reply "Your value can not be object." 

      # obj = JSON.stringify(str)



      




  robot.hear /badger/i, (msg) ->
    msg.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  
  robot.respond /open the pod bay doors/i, (msg) ->
    msg.reply "I'm afraid I can't let you do that."

  robot.hear /I like pie/i, (msg) ->
    msg.emote "makes a freshly baked pie"

  robot.respond /open the (.*) doors/i, (msg) ->
    doorType = msg.match[1]
    if doorType is "pod bay"
      msg.reply "I'm afraid I can't let you do that."
    else
      msg.reply "Opening #{doorType} doors"




  #lulz = ['lol', 'rofl', 'lmao']
  
  #robot.respond /lulz/i, (msg) ->
  #  msg.send msg.random lulz

  # curl -X POST http://localhost:8080/hubot/say -d message=lala -d room='#dev'
  robot.router.post "/hubot/say", (req, res) ->
    body = req.body
    room = body.room
    message = body.message

    robot.logger.info "Message '#{message}' received for room #{room}"

    envelope = robot.brain.userForId 'broadcast'
    envelope.user = {}
    envelope.user.room = envelope.room = room if room
    envelope.user.type = body.type or 'groupchat'

    if message
      robot.send envelope, message

    res.writeHead 200, {'Content-Type': 'text/plain'}
    res.end 'Thanks\n'






  robot.topic (msg) ->
    msg.send "#{msg.message.text}? That's a Paddlin'"

  robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
    room   = req.params.room
    data   = JSON.parse req.body.payload
    secret = data.secret

  robot.router.post "/hubot/gh-commits", (req, res) ->
    robot.emit "commit", {
        user    : {}, #hubot user object
        repo    : 'https://github.com/github/hubot',
        hash  : '2e1951c089bd865839328592ff673d2f08153643'
    }

