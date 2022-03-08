# frozen_string_literal: true

require 'elevator'

class Controller
  def initialize(num_cars:, max_floors:)
    @cars = []
    num_cars.times { @cars << Elevator.new }
    @max_floors = max_floors
  end

  def car_button(car:, floor:)
    raise 'No such car!' unless car >= 0 && car < @cars.length
    raise 'No such floor!' unless floor >= 0 && floor < @max_floors

    @cars[car].add_destination(floor)
  end

  def cars
    @cars.dup
  end

  def floor_button(direction:, floor:)
    raise 'No such direction!' unless %i[up down].include? direction
    raise 'No such floor!' unless floor >= 0 && floor < @max_floors
    raise 'No cars to direct!' unless @cars.any?

    pick_car(direction, floor).add_destination(floor)
  end

  def step
    @cars.each(&:step)
  end

  private

  # Naive: try to pick a car that is moving towards the call floor and in the same direction as
  # the call.
  def pick_car(direction, floor)
    @cars.min_by { |c| distance_to_floor(c, direction, floor) }
  end

  # Penalize cars that are moving in the wrong direction; we could do a much better job at
  # calculating the 'distance' in this case
  def distance_to_floor(car, direction, floor)
    if car.direction.nil? || (car.direction == direction &&
        (car.direction == :up && car.floor <= floor) ||
        (car.direction == :down && car.floor >= floor))
      (car.floor - floor).abs
    else
      @max_floors * 2
    end
  end
end
