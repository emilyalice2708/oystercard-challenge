class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def start(station = nil)
    @entry_station = station
  end

  def end(station = nil)
    @exit_station = station
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def in_progress?
    !@entry_station.nil? and @exit_station.nil?
  end

  def complete?
    !entry_station.nil? and !exit_station.nil?
  end
end
