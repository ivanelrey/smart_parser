#!/usr/bin/env ruby

require './application'

app = Application.new
app.run(ARGV.first)
