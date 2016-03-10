require_relative 'journey'

class JourneyLog


  def initialize(journey_class=Journey)
    @journey_history = []
    @journey_class = journey_class
  end

  def start(station)
    current_journey
     @journey.entry_st(station)
  end

  def finish(station)
    current_journey
    @journey.exit_st(station)
  end

  def current_journey
    @journey ||= @journey_class.new
  end

  def store_journey
    @journey_history << @journey
    @journey = nil
  end

  def journeys
    @journey_history.dup
  end

end
