require "oystercard"

describe Oystercard do
  let(:journey) { double :journey, start: true, end: true}
  let(:card) {Oystercard.new(Oystercard::INITIAL_BALANCE, Oystercard::BALANCE_LIMIT, journey)}

  it "should have a balance of zero" do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "should increase balance by 20" do
    subject.top_up(20)
    expect(subject.balance).to eq 20
  end

  it "should not exceed the balance of #{Oystercard::BALANCE_LIMIT}" do
    maximum_limit = Oystercard::BALANCE_LIMIT
    subject.top_up(maximum_limit)
    expect { subject.top_up(1) }.to raise_error("Maximum balance is £#{subject.maximum_limit}.")
  end

  it 'initializes with a default in_use state of "false"' do
    expect(subject).to_not be_in_journey
  end

  it "starts with an empty journey history" do
    expect(subject.journey_history).to be_empty
  end

  describe "#deduct" do
    let(:station) { double :entry_station }
    it "deducts a fare from a balance" do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  describe "#touch_in" do
    let(:station) { double :entry_station }
    

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'changes card_use_status to "true" when called' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "raises error if insufficient funds on the card" do
      error_message = "Error: Unsufficient funds available. Minimum £#{Oystercard::MINIMUM_FARE} needed..."
      expect { subject.touch_in(station) }.to raise_error(error_message)
    end 

    it 'starts a journey' do
      card.top_up(10)
      expect(journey).to receive(:start)
      card.touch_in(station)
    end
  end

  describe "#touch_out" do
    let(:station) { double :station }
    let(:station2) { double :station }

    it { is_expected.to respond_to(:touch_out) }

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'changes card_use_status back to "false" when called' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).to_not be_in_journey
    end

    it "changes the current station to nil" do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey.entry_station).to eq(nil)
    end

    it "ends a journey" do
      card.top_up(10)
      expect(journey).to receive(:end).with(station2)
      card.touch_out(station2)
    end

    it "stores the journey in the journey history" do
      card.top_up(10)
      card.touch_in(station)
      card.touch_out(station2)
      expect(card.journey_history).to include(journey)
    end

    it "only stores one extra journey" do
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(station2) }.to change { subject.journey_history.length }.by(1)
    end
  end

  describe "#in_journey?" do
    let(:station) { double :entry_station }
    it { is_expected.to respond_to(:in_journey?) }
    it 'displays card_use_status as "false" on initialization' do
      expect(subject).to_not be_in_journey
    end
    it 'displays card_use_status as "true" after touch_in' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it 'displays card_use_status as "false" after touch_out' do
      subject.touch_out(station)
      expect(subject).to_not be_in_journey
    end
  end
end
