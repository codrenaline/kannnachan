module.exports = (robot) ->
  robot.respond /アップデート$/, (msg) ->
    exec = require('child_process').exec
    command = "sh scripts/commands/updating.sh"
    msg.send "じゃあアップデートしてくるから、待っててね。"
    msg.send "http://livedoor.blogimg.jp/vipperdeok-nelers/imgs/2/4/2477a522.jpg"
    exec command, (error, stdout, stderr) ->
      if stderr?
        msg.send stderr

