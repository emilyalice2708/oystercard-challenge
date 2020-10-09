class Journey
  attr_reader :entry_station, :exit_station

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    1
  end

  def in_progress?
    !@entry_station.nil? and @exit_station.nil?
  end
end