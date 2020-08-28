#!/usr/bin/env ruby

require './application'

app = Application.new(ARGV.first)
app.run
