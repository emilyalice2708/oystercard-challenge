# frozen_string_literal: true

require_relative "./lib/oystercard.rb"

p my_oyster_card = Oystercard.new
p "this is balance"
p my_oyster_card.balance
p my_oyster_card.top_up(20)

p "Trip 1"
p my_oyster_card.touch_in("victoria station")
p my_oyster_card.touch_out("leicester square")
p my_oyster_card.balance
p 19

p "Trip 2"
p my_oyster_card.touch_in("tulse hill")
p my_oyster_card.balance
p 19
p my_oyster_card.in_journey?
p true

p "Trip 3"
p my_oyster_card.touch_in("victoria station")
p my_oyster_card.balance
p 13
p my_oyster_card.touch_out("leicester square")
p my_oyster_card.balance
p 12

p "Trip 4"
p my_oyster_card.touch_out("liverpool street")
p my_oyster_card.balance
p 6

p my_oyster_card.journey_history.length
p 4
p my_oyster_card.in_journey?
p false

# p my_oyster_card.touch_out("kings cross")
# p my_oyster_card.journey_history
#   # Returns three journies
# p victoria_station = Station.new
