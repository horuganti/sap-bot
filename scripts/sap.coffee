# Description:
#   Sap command is ChatOps.
#
# Notes:
#   sap is ssh + capistrano.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.respond /(sap.*)/i, (res) ->
    prefix = res.match[1]
    robot.logger.info "your prefix: #{prefix}"

    @exec = require('child_process').exec

    command = "docker run koudaiii/hello-world #{prefix}"
    res.send "Command: #{command}"
    @exec command, (error, stdout, stderr) ->
      if error?
        robot.logger.error "ERROR: #{error}"
        res.reply error
      if stdout?
        robot.logger.info "STDOUT: #{stdout}"
        res.reply stdout
      if stderr is not null
        robot.logger.error "STDERR: #{stderr}"
        res.reply stderr

  robot.respond /(exec.*)/i, (res) ->
    @exec = require('child_process').exec
    command = res.match[1]
    res.send "Command: #{command}"
    @exec command, (error, stdout, stderr) ->
      if error?
        robot.logger.error "ERROR: #{error}"
        res.reply error
      if stdout?
        robot.logger.info "STDOUT: #{stdout}"
        res.reply stdout
      if stderr is not null
        robot.logger.error "STDERR: #{stderr}"
        res.reply stderr

  robot.error (err, res) ->
    robot.logger.error "DOES NOT COMPUTE"

    if res?
      res.reply "DOES NOT COMPUTE"
