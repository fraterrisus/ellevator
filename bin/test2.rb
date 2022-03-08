#!/usr/bin/env ruby
# frozen_string_literal: true

require 'pathname'
libpath = Pathname.new(File.dirname(__FILE__)).join('..', 'lib').to_s
$LOAD_PATH.unshift libpath

require 'controller'

@events = {
  0 => [[:floor_button, { direction: :down, floor: 2 }]],
  1 => [
    [:floor_button, { direction: :down, floor: 9 }],
    [:car_button, { car: 0, floor: 1 }]
  ],
  9 => [
    [:car_button, { car: 1, floor: 0 }]
  ]
}

c = Controller.new(num_cars: 2, max_floors: 10)

time = 0
until c.cars.map(&:direction).all?(&:nil?) && @events.keys.max <= time
  puts "t:#{time}"
  @events[time]&.each do |event|
    puts event.inspect
    c.public_send(*event)
  end
  c.step

  c.cars.each { |car| puts car.inspect }
  puts

  time += 1
  break if time > 100
end
