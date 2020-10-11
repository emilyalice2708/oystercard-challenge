require_relative "journey.rb"
require_relative "journey_log"

class Oystercard
  attr_reader :balance, :maximum_limit, :journey_log

  INITIAL_BALANCE = 0
  BALANCE_LIMIT = 90

  def initialize(balance = INITIAL_BALANCE, maximum_limit = BALANCE_LIMIT, journey_log = JourneyLog)
    @balance = balance
    @maximum_limit = maximum_limit
    @journey_log = journey_log.new
  end

  def top_up(value)
    error_message = "Maximum balance is £#{maximum_limit}."
    raise error_message if (@balance + value) > @maximum_limit

    @balance += value
  end

  def touch_in(station, journey_class = Journey)
    error_message = "Error: Unsufficient funds available. Minimum £#{Journey::MINIMUM_FARE} needed..."

    fail error_message if @balance < journey_class::MINIMUM_FARE

    @journey_log.start(station)

    deduct if @journey_log.last_journey && @journey_log.last_journey.exit_station.nil?
    
  end

  def touch_out(station)
    @journey_log.end(station)
    deduct
  end

  def view_journey
    @journey_log.journeys
  end
  
  private

  def deduct(amount = 0)
    @balance -= @journey_log.last_journey.fare
  end

end
