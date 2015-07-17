random = (n) -> Math.floor(Math.random() * n)

module.exports = (robot) ->
  robot.hear /(かんな|カンナ|橋本環奈|橋本|環奈)/i, (msg) ->
    fetchImage msg
    msg.send 'なあに？'

  robot.hear /^\@kannachan\:\s(おはよう|おはよ|おはようございます。)$/, (msg) ->
    msg_messages = ['おはよ。', '朝ごはんちゃんと食べた？今日も頑張ろうね']
    msg.send msg_messages[random(2)]

  robot.hear /^\@kannachan\:\s([0-9]*)\s([\+\-\*\/])\s([0-9]*)$/, (msg) ->
    if msg.match[2] == '+'
      result = "#{parseInt(msg.match[1], 10) + parseInt(msg.match[3], 10)}"
    else if msg.match[2] == '-'
      result = "#{parseInt(msg.match[1], 10) - parseInt(msg.match[3], 10)}"
    else if msg.match[2] == '*'
      result = "#{parseInt(msg.match[1], 10) * parseInt(msg.match[3], 10)}"
    else
      if parseInt(msg.match[3], 10) == 0
        result = '0で割ることはできないよ。ちゃんと勉強しないと嫌いになっちゃうぞ。'
      else
        result = "#{parseInt(msg.match[1], 10) / parseInt(msg.match[3], 10)}"

    msg.send result

  robot.hear /^\@kannachan\:\s(可愛い|かわいい|綺麗|美しい)/, (msg) ->
    msg_messages = ['ありがとう', 'ありがと', '嬉しい']
    msg.send msg_messages[random(3)]
    msg.send is_embarrassed_images[random(is_embarrassed_images.length)]

fetchImage = (msg) ->
  query = '橋本環奈'
  q = v: '1.0', rsz: '8', q: query, safe: 'active'
  msg.http('https://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      if err
        msg.send "Encountered an error :( #{err}"
      if res.statusCode isnt 200
        msg.send "Bad HTTP response :( #{res.statusCode}"
      else
        images = JSON.parse(body)
        images = images.responseData?.results
        if images?.length > 0
          image = msg.random images
          msg.send image.unescapedUrl
        else
          msg.send "Nothing Image"

is_embarrassed_images = [
  'https://pbs.twimg.com/media/BtwnLScCYAAvdav.jpg'
]

