#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
libpath = Pathname.new(File.dirname(__FILE__)).join('..', 'lib').to_s
$LOAD_PATH.unshift libpath

require 'elevator'

@events = {
  1 => [[:add_destination, 5]],
  3 => [[:add_destination, 7]],
  6 => [[:add_destination, 2]]
}

e = Elevator.new

time = 0
until e.direction.nil? && @events.keys.max <= time
  print "t:#{time}  "
  @events[time]&.each do |event|
    e.public_send(*event)
  end
  e.step
  puts e.inspect
  time += 1
end
