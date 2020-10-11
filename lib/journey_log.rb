require_relative 'journey'

class JourneyLog
    attr_reader :journey_log, :current_journey
    def initialize(journey_class = Journey, journey_log = [], current_journey = nil)
        @journey_class = journey_class
        @journey_log = journey_log
        @current_journey = nil
    end

    def start(entry_station)
        if  @current_journey.nil?
            @current_journey = @journey_class.new(entry_station)
        else
            @current_journey.end(nil)
            @journey_log << @current_journey
            @current_journey = @journey_class.new(entry_station)
        end
    end

    def end(exit_station)
        current_journey
        @current_journey.end(exit_station)
        @journey_log << @current_journey
        @current_journey = nil
    end

    def last_journey
        @journey_log.last
    end

    def journeys
        @journey_log.dup
    end

    private

    def current_journey
        @current_journey ||= @journey_class.new
    end
end