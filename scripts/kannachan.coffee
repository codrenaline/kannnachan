random = (n) -> Math.floor(Math.random() * n)

module.exports = (robot) ->
  robot.hear /(かんな|カンナ|橋本環奈|橋本|環奈)/i, (res) ->
    res.send 'なあに？'

  robot.hear /^\@kannachan\s(おはよう|おはよ|おはようございます。)$/, (res) ->
    res_messages = ['おはよ。', '朝ごはんちゃんと食べた？', '今日も頑張ろうね']
    res.send res_messages[random(3)]
