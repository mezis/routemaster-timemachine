require 'rails_helper'

RSpec.describe Replay do

  let(:url)   { 'http://foo.example.com/topics/1' }
  let(:type)  { 'update'  }
  let(:topic) { 'topic' }
  let(:t)     { 10.minutes.ago.to_i }
  let(:event) { instance_double("Event", url: url, type: type, topic: topic, t: t) }

  describe '#replay' do

    context 'when doing a single replay' do
      subject { described_class.new(event) }

      it 'sends a routemaster event' do
        expect_any_instance_of(Routemaster::Client).to receive(:updated).with('topics', url, t)
        subject.replay
      end
    end

    context 'when doing a collection replay' do
      subject { described_class.new([event, event]) }

      it 'sends a routemaster event' do
        expect_any_instance_of(Routemaster::Client).to receive(:updated).with('topics', url, t).twice
        subject.replay
      end
    end

  end
end
