class Journey

  attr_reader :entry_station, :exit_station, :complete

  MINIMUM_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete = false
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
  end

  def fare
    (@entry_station != nil && @exit_station != nil) ? MINIMUM_FARE : PENALTY_FARE
  end


  private

  def journey_complete?
    @complete
  end


end
