module.exports = (robot) ->
  robot.hear /(かんな|カンナ|橋本環奈|橋本|環奈)/i, (res) ->
    res.send 'なあに？'
