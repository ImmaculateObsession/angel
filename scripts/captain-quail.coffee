# Description:
#   The Adventures of Captain Quail, now in you chat!
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot cq - The latest Adventures of Captain Quail
#
# Author:
#   phildini

htmlparser = require "htmlparser"
Select = require("soupselect").select

module.exports = (robot) ->
    robot.respond /cq/i, (msg) ->
        msg.http("http://www.captainquail.com/comic/")
            .get() (err, res, body) ->
                handler = new htmlparser.DefaultHandler()
                parser = new htmlparser.Parser(handler)
                parser.parseComplete(body)

                img = Select handler.dom, "img.comic"
                title = Select handler.dom, "a.content-link"
                link = title[0].attribs
                comic = img[0].attribs

                msg.send link.href
                msg.send comic.alt
