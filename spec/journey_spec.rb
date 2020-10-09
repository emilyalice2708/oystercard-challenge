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

  describe '#fare' do
    it "returns a fare of 1" do
      expect(journey.fare).to eq 1
    end
    
  end

  describe '#complete' do
    journey.start(entry_station)
    context 'given an entry station' do
      
      it 'returns false when missing exit station' do
        expect(journey).not_to be_complete
      end
    end
  end
end
