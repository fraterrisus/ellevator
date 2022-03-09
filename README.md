# Ellevator

A coding exercise for a job interview.

Code lives in `/lib`, test harnesses in `/bin` for now.

Test harnesses work by building an `@events` hash. Key is time index, value is a list of method
calls to make to the unit under test. Example:
```ruby
@events = {
  1 => [
    [ :car_button, { floor: 2, direction: :down }]
  ]
}
```
This will wait until `t=1` and then send `.car_button(floor :2, direction: :down)` to the controller.
The simulation will run until all events have been sent and all elevator cars have stopped moving.

`bin/test1.rb` is the test harness for the `Elevator` class

`bin/test2.rb` is the test harness for the `Controller` class / entire system.
