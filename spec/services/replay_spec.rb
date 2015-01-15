require 'rails_helper'

RSpec.describe Replay do

  let(:url)            { 'http://foo.example.com/topics/1' }
  let(:type)           { 'update'  }
  let(:topic)          { 'topic' }
  let(:t)              { 10.minutes.ago.to_i }
  let(:event)          { Event.create(url: url, type: type, topic: topic, t: t) }
  let(:client)         { instance_double("Routemaster::Client") }
  let(:publisher)      { instance_double("Routemaster::Client") }
  let(:publisher_uuid) { 'foo' }

  describe '#replay' do

    before do
      allow(Routemaster::Client).to receive(:new)
        .with({
          url:  ENV['ROUTEMASTER_URL'],
          uuid: ENV['ROUTEMASTER_CLIENT_UUID'],
          timeout: 1
        })
        .and_return(client)

      allow(Routemaster::Client).to receive(:new)
        .with({
          url:  ENV['ROUTEMASTER_URL'],
          uuid: publisher_uuid,
          timeout: 1
        })
        .and_return(publisher)

      allow(client).to receive(:monitor_topics).and_return([
        Routemaster::Topic.new({
          "name"      => topic.pluralize,
          "publisher" => publisher_uuid,
          "events"    => 100
        })
      ])
    end

    context 'when doing a single replay' do
      subject { described_class.new(Event.where(id: event.id)) }

      it 'sends a routemaster event' do
        expect(publisher).to receive(:updated).with('topics', url, t * 1000)
        subject.replay
      end
    end

    context 'when doing a collection replay' do
      before do
        2.times { Event.create(url: url, type: type, topic: topic, t: t) }
      end

      subject { described_class.new(Event.all) }

      it 'sends a routemaster event' do
        expect(publisher).to receive(:updated).with('topics', url, t * 1000).twice
        subject.replay
      end
    end

  end
end
