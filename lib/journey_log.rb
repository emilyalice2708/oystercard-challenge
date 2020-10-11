class JourneyLog
    attr_reader :journey_log
    def initialize(journey_class = Journey, journey_log = [])
        @journey_class = journey_class
        @journey_log = journey_log
    end

    def start(entry_station)
        @current_journey = @journey_class.new(entry_station)
        @journey_log << @current_journey
    end

    def finish(exit_station)
        current_journey
        @journey_log << @current_journey.end(exit_station)
        @current_journey = nil
    end

    def journeys
        @journey_log.dup
    end

    private

    def current_journey
        @current_journey ||= @journey_class.new
    end
end