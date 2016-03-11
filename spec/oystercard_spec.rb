require 'oystercard'

describe Oystercard do

  # default_value = Oystercard::DEFAULT_BALANCE
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  minimum_balance = Oystercard::MINIMUM_BALANCE
  max_error = Oystercard::MAXIMUM_BALANCE_ERROR

  let (:journey_class) {double :journey_class, new: journey}
  subject(:card) { described_class.new(journey_class) }
  let (:entry_station)  { double :station }
  let (:exit_station)   { double :station }
  let (:journey)  { double :journey, entry_station: nil, exit_station: nil, start: nil, end: nil, fare: 0, reset_stations: nil }

  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(card.balance).to be_zero
    end
    it 'starts with an empty journey history' do
      expect(card.journeys).to be_empty
    end
  end

  describe '#top_up' do
    it "adds amount to existing balance" do
      expect{ card.top_up(maximum_balance) }.to change{ card.balance }.by (maximum_balance)
    end
    it 'raise an error when trying to exceed balance maximum' do
      expect{ card.top_up(maximum_balance+1) }.to raise_error max_error
    end
  end

  describe '#touch_in' do
    before do
      allow(journey).to receive(:fare).and_return(1)
      card.top_up(maximum_balance)
      card.touch_in(entry_station)
    end
    it 'adds entries to journeys array when touching in twice' do
      allow(journey).to receive(:entry_station) { entry_station }
      expect{ card.touch_in(entry_station) }.to change{card.journeys.length}.by(1)
    end
    it 'raises an error when balance is below minimum' do
      card = described_class.new
      expect{ card.touch_in(entry_station) }.to raise_error Oystercard::MINIMUM_BALANCE_ERROR
    end
  end

  describe '#touch_out' do
    before do
      card.top_up(maximum_balance)
      card.touch_in(entry_station)
    end
    it 'pushes entry/exit hash into journeys array' do
      expect{ card.touch_out(exit_station) }.to change{card.journeys.length}.by(1)
    end
  end
end
