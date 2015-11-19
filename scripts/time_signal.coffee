cron = require('cron').CronJob

schedule = require('../schedule.json')

module.exports = (robot) ->
  for i, s of schedule
    new cron s.cron , () =>
      robot.send {room: "general"}, s.message
    , null, true, "Asia/Tokyo"
