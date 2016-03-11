require 'journey'

describe Journey do

  minimum_fare = Journey::MINIMUM_FARE
  penalty_fare = Journey::PENALTY_FARE

  subject(:journey) { described_class.new }

  let (:entry_station)  { double :station }
  let (:exit_station)   { double :station }

  describe '#initialize' do

    it 'initialised with entry station' do
      expect(journey.entry_station).to be_nil

    end

    it 'initialized with exit station' do
      expect(journey.exit_station).to be_nil
    end

    it 'initialized with a @complete = false' do
      expect(journey.complete).to be(false)
    end

  end

  describe '#start' do

    it 'sets the value of entry station' do
      journey.start(entry_station)
      expect(journey.entry_station).to eq(entry_station)
    end
  end

  describe '#end' do

    it 'sets the value of exit station' do
      journey.end(exit_station)
      expect(journey.exit_station).to eq(exit_station)
    end
  end

  describe '#fare' do

    it 'returns minimum fare when a valid journey' do
      journey.start(entry_station)
      journey.end(exit_station)
      expect(journey.fare).to eq(minimum_fare)
    end

    it 'returns penalty fare when a journey is not valid' do
      journey.start(entry_station)
      expect(journey.fare).to eq(penalty_fare)
    end
  end

  describe '#reset_stations' do
    it 'resets entry_station and exit_station to nil' do
    journey.start(entry_station)
    journey.reset_stations
    expect(journey.entry_station).to eq nil
  end
end


end
