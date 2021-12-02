#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.on("-d", "--day DAY", "Run day") do |day|
    day = "%02d" % day
    options[:day] = day
  end
end.parse!

require_relative "./days/day_#{options[:day]}.rb"

input_path = File.expand_path("#{__dir__}/../input/days/day_#{options[:day]}.txt")
input = File.read(input_path)
result = Day.new.call(input)

puts result


