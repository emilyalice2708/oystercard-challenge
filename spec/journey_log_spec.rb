require 'journey_log'

describe JourneyLog do
    let(:journey) { double :journey }
    let(:station) { double :station }
    let(:array) { double :array }
    let(:journey_class_double) { double :journey_class_double, new: journey}
    subject { described_class.new(journey_class_double) }
    
    it { is_expected.to respond_to(:start).with(1).argument }

    it { is_expected.to respond_to(:finish).with(1).argument }

    describe '#start' do
        it 'starts a journey' do
            expect(journey_class_double).to receive(:new).with(station)
            subject.start(station)
        end

        it 'records finished, but incomplete journeys' do
            subject.start(station)
            subject.start(station)
            expect(subject.journey_log).to eq([journey])
        end
    end

    describe '#finish' do
        it 'ends a journey' do
            expect(journey).to receive(:end).with(station)
            subject.finish(station)
        end
        it 'records a journey' do
            allow(journey).to receive(:end).and_return(journey)
            subject.finish(station)
            expect(subject.journey_log).to include(journey)
        end
    end

    describe '#journeys' do
        it 'returns duplicate' do
            test_journey = JourneyLog.new(journey_class_double, array)
            allow(array).to receive(:dup)
            expect(array).to receive(:dup)
            test_journey.journeys
        end
        
        it 'returns an array' do
            expect(subject.journeys).to be_a(Array)
        end
    end

end