module.exports = (robot) ->
  time = require('time')
  cron = require('cron').CronJob
  request = require('request')
  config = require('../slack_collect.json')
  fs = require('fs')
  mkdirp = require('mkdirp')

  channels = [];
  request.post "https://slack.com/api/channels.list?token=#{config.token}" , (error, response, body) =>
    res = JSON.parse(body)
    for i, c of res.channels
      channels["#{c.name}"] = c.id

  members = [];
  request.post "https://slack.com/api/users.list?token=#{config.token}" , (error, response, body) =>
    res = JSON.parse(body)
    for i, m of res.members
      members[m.id] = m.name

  new cron '0 0 0 * * *', () =>
    date = new time.Date()
    date.setDate(date.getDate() - 1)
    oldest = (new time.Date(date.getFullYear(), date.getMonth(), date.getDate(), 0, 0, 'Asia/Tokyo')).getTime() / 1000
    latest = oldest + (24 * 60 * 60) - 1
    for i, m of config.members
      request.post "https://slack.com/api/channels.history?token=#{config.token}&channel=#{channels[m.channel]}&latest=#{latest}&oldest=#{oldest}", (error, response, body) =>
        mkdirp.sync "#{config.log_root}#{m.channel}"
        msg = JSON.parse(body).messages.reverse()
        for i, post of msg
          timestring = new time.Date(post.ts * 1000).toTimeString()
          fs.appendFileSync("#{config.log_root}#{m.channel}/#{date.getFullYear()}-#{date.getMonth()}-#{date.getDate()}.md", "- #{members[post.user]} : #{post.text} : #{timestring} \n")
  , null, true, "Asia/Tokyo"
