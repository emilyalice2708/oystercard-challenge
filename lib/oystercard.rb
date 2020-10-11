require_relative "./journey.rb"

class Oystercard
  attr_reader :balance, :maximum_limit, :trip, :journey_history, :journey

  INITIAL_BALANCE = 0
  BALANCE_LIMIT = 90

  def initialize(balance = INITIAL_BALANCE, maximum_limit = BALANCE_LIMIT, journey_class = Journey)
    @balance = balance
    @maximum_limit = maximum_limit
    @journey_history = []
    @journey_class = journey_class
    @journey = journey_class.new
  end

  def top_up(value)
    error_message = "Maximum balance is £#{maximum_limit}."
    raise error_message if (@balance + value) > @maximum_limit

    @balance += value
  end

  def touch_in(station, journey_class = Journey)
    error_message = "Error: Unsufficient funds available. Minimum £#{Journey::MINIMUM_FARE} needed..."

    fail error_message if @balance < journey_class::MINIMUM_FARE

    @journey.start(station)
  end

  def touch_out(station)
    @journey.end(station)
    deduct(@journey.fare)
    @journey_history << @journey
    @journey = @journey_class.new
  end

  def in_journey?
    @journey.in_progress?
  end

  private

  def deduct(amount = 0)
    @balance -= amount
  end
end
