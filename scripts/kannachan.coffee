random = (n) -> Math.floor(Math.random() * n)

module.exports = (robot) ->
  robot.hear /(かんな|カンナ|橋本環奈|橋本|環奈)/i, (res) ->
    res.send 'なあに？'

  robot.hear /^\@kannachan\s(おはよう|おはよ|おはようございます。)$/, (res) ->
    res_messages = ['おはよ。', '朝ごはんちゃんと食べた？', '今日も頑張ろうね']
    res.send res_messages[random(3)]

  robot.hear /^(\@kannachan)\s([0-9]*)\s([\+\-\*\/])\s([0-9]*)$/, (res) ->
    if res.match[3] == '+'
      result = parseInt(res.match[2], 10) + parseInt(res.match[4], 10)
    else if res.match[3] == '-'
      result = parseInt(res.match[2], 10) - parseInt(res.match[4], 10)
    else if res.match[3] == '*'
      result = parseInt(res.match[2], 10) * parseInt(res.match[4], 10)
    else
      if parseInt(res.match[4], 10) == 0
        result = '0で割ることはできないよ。ちゃんと勉強しないと嫌いになっちゃうぞ。'
      else
        result = parseInt(res.match[2], 10) / parseInt(res.match[4], 10)

    res.send result
