require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class) }
  let(:journey_class) { double :journey_class, new:journey_instance }
  let(:journey_instance) { double :journey_instance, entry_st: entry_station, exit_st: exit_station, fare: nil }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  it {is_expected.to respond_to(:start)}
  it {is_expected.to respond_to(:finish)}
  it {is_expected.to respond_to(:journeys)}
  it {is_expected.to respond_to(:current_journey)}

  describe '#current_journey' do
    it {expect(journey_log.current_journey).to eq journey_instance}
  end

  it 'checks entry station is stored and set' do
    journey_log.start(entry_station)
    journey_log.store_journey
    expect(journey_log.journeys.last.entry_st).to eq(entry_station)
  end

  it 'checks exit station is stored and set' do
    journey_log.finish(exit_station)
    journey_log.store_journey
    expect(journey_log.journeys.last.exit_st).to eq(exit_station)
  end
end
