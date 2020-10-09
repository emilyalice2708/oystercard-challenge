require_relative "./journey.rb"

class Oystercard
  attr_reader :balance, :maximum_limit, :trip, :journey_history, :journey

  INITIAL_BALANCE = 0
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = INITIAL_BALANCE, maximum_limit = BALANCE_LIMIT, journey = Journey.new)
    @balance = balance
    @maximum_limit = maximum_limit
    @journey_history = []
    @journey = journey
  end

  def top_up(value)
    error_message = "Maximum balance is £#{maximum_limit}."
    raise error_message if (@balance + value) > @maximum_limit

    @balance += value
  end

  def touch_in(station, journey_class = Journey)
    error_message = "Error: Unsufficient funds available. Minimum £#{MINIMUM_FARE} needed..."

    fail error_message if @balance < MINIMUM_FARE

    @journey.start(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.end(station)
    @journey_history << @journey
    @journey = Journey.new
  end

  def in_journey?
    @journey.in_progress?
  end

  private

  def deduct(amount = 0)
    @balance -= amount
  end
end
