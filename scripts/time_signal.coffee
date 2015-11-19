cron = require('cron').CronJob

schedule = require('../schedule.json')

module.exports = (robot) ->
  robot.respond /(スケジュール見せて)/i, (msg) ->
    s_list = ''
    for i, s of schedule
      s_list += "#{s.cron} #{s.room} #{s.message} \n"
    msg.send "はーい\`\`\`#{s_list}\`\`\`"

  for i, s of schedule
    new cron s.cron , () =>
      robot.send {room: s.room}, s.message
    , null, true, "Asia/Tokyo"
