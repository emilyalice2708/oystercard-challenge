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

  it "returns a far of 1" do
    expect(journey.fare).to eq 1
  end
end
