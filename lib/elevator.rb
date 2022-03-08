# frozen_string_literal: true

class Elevator
  def initialize(starting_floor = 0)
    @current_direction = nil
    @current_floor = starting_floor
    @destinations = []
  end

  def add_destination(floor)
    @destinations << floor
    @destinations.uniq!
  end

  def destinations
    @destinations.dup
  end

  def direction
    @current_direction.dup
  end

  def floor
    @current_floor.dup
  end

  # Attempt to respect the direction we're currently moving; if we aren't moving, try UP first
  def step
    if @current_direction == :down
      if lower_destinations.any?
        move_down
      elsif higher_destinations.any?
        move_up
      else
        @current_direction = nil
      end
    else
      if higher_destinations.any?
        move_up
      elsif lower_destinations.any?
        move_down
      else
        @current_direction = nil
      end
    end

    # If we arrive at a destination, open the doors -- elided from the problem
    @destinations.reject! { |f| f == @current_floor }
  end

  private

  def higher_destinations
    @destinations.select { |d| d > @current_floor }
  end

  def lower_destinations
    @destinations.select { |d| d < @current_floor }
  end

  def move_up
    @current_floor += 1
    @current_direction = :up
  end

  def move_down
    @current_direction = :down
    @current_floor -= 1
  end
end
