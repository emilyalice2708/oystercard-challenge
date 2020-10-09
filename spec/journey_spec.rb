require "journey"

describe Journey do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  let(:oystercard) { double :oystercard }
  let(:journey) { Journey.new }

  it "store the entry station" do
    journey.start(entry_station)
    expect(journey.entry_station).to eq entry_station
  end

  it "stores the exit station" do
    journey.end(exit_station)
    expect(journey.exit_station).to eq exit_station
  end

  describe "#fare" do
    context "with a complete journey" do
      before do
        allow(journey).to receive(:complete?).and_return(true)
      end
      it "returns a the minimum fare" do
        expect(journey.fare).to eq Journey::MINIMUM_FARE
      end
    end
    context "with an incomplete journey" do
      before do
        allow(journey).to receive(:complete?).and_return(false)
      end
      it "returns the penalty fare" do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end

  describe "#complete" do
    context "given an entry station" do
      before { journey.start(entry_station) }
      it "returns false when missing exit station" do
        expect(journey).not_to be_complete
      end
      context "and given an exit station" do
        before { journey.end(exit_station) }
        it "returns true" do
          expect(journey).to be_complete
        end
      end
    end
    context "not given an entry station" do
      before { journey.start }
      context "and ended without an exit station" do
        before { journey.end }
        it "returns false when not given an exit station" do
          expect(journey).not_to be_complete
        end
      end
      context "but given an exit station" do
        before { journey.end(exit_station) }
        it "returns false" do
          expect(journey).not_to be_complete
        end
      end
    end
  end
end
