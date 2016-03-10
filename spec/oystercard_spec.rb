require 'oystercard'

describe Oystercard do

  # default_value = Oystercard::DEFAULT_BALANCE
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  minimum_balance = Oystercard::MINIMUM_BALANCE


  let (:journey_class) {double :journey_class, new: journey}
  subject(:card) { described_class.new(journey_class) }
  let (:entry_station)  { double :station }
  let (:exit_station)   { double :station }
  let (:journey)  { double :journey }

  describe '#initialize' do
    it 'starts with a balance of 0' do
      expect(card.balance).to be_zero
    end

    it 'starts with an empty journey history' do
      expect(card.journeys).to be_empty
    end
  end

  describe '#top_up' do
    # it 'adds amount to existing balance' do
    #   prev_balance = card.balance
    #   amount = rand(1..20)
    #   card.top_up(amount)
    #   expect(card.balance).to eq(prev_balance + amount)
    # end
    it "adds amount to existing balance 2.0" do
      amount = rand(1..20)
      expect{ card.top_up(amount) }.to change{ card.balance }.by (amount)
    end

    it 'raise an error when trying to exceed balance maximum' do
      amount = maximum_balance+1
      message = Oystercard::MAXIMUM_BALANCE_ERROR
      expect{ card.top_up(amount) }.to raise_error message
    end
  end

  describe '#touch_in' do

    before do
      allow(journey).to receive(:fare).and_return(1)
      card.top_up(maximum_balance)
      card.touch_in(entry_station)
    end

    it 'charges penalty_fare when touching in twice' do
      allow(journey).to receive(:entry_station).and_return(entry_station)
      expect{ card.touch_in(entry_station) }.to change{ card.balance }.by(-penalty_fare)
    end

    it 'adds entries to journeys array when touching in twice' do
      card.touch_in(entry_station)
      test_journey = { :entry_station => entry_station, :exit_station => nil }
      expect(card.journeys).to include(test_journey)
    end

    it 'sets in_journey to true' do
      expect(card.in_journey?).to eq true
    end

    it 'raises an error when balance is below minimum' do
      card = described_class.new
      expect{ card.touch_in(entry_station) }.to raise_error Oystercard::MINIMUM_BALANCE_ERROR
    end

    it 'should set value of entry_station' do
      expect(card.entry_station).to eq(entry_station)
    end

  end

  describe '#touch_out' do

    before do
      card.top_up(maximum_balance)
      card.touch_in(entry_station)
    end

    it 'charges maximum fare when entry_station is unknown' do
      card = described_class.new
      card.top_up(maximum_balance)
      expect{ card.touch_out(exit_station) }.to change{ card.balance }.by(-penalty_fare)
    end


    it 'changes in_journey status to false' do
      card.touch_out(exit_station)
      expect(card.in_journey?).to eq false
    end

    it 'charges minimum fare' do
      expect{card.touch_out(exit_station) }.to change{ card.balance}.by(-minimum_fare)
    end

    it 'resets entry_station to nil' do
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

    it 'pushes entry/exit hash into journeys array' do
      card.touch_out(exit_station)
      test_journey = { :entry_station => entry_station, :exit_station => exit_station }
      expect(card.journeys).to include(test_journey)
    end

  end

end
