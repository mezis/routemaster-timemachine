require 'rails_helper'

RSpec.describe EventSearch do

  let(:options) { {} }

  subject { described_class.new(options) }

  context 'when options has strings as keys' do

    let(:options) do
      {
        "topic" => ['photos', 'properties']
      }
    end

    it 'captures the right topics' do
      expect(subject.topic).to eql(options["topic"])
    end

  end

  describe 'ordering' do
    let!(:event_1) { Event.create(t: 2.minutes.ago.to_f) }
    let!(:event_2) { Event.create(t: 1.minutes.ago.to_f) }

    it 'orders events by t on default' do
      expect(subject.search.map(&:id)).to eql([event_2.id, event_1.id])
    end
  end

  describe 'filtering' do

    context 'on t' do
      let!(:event_1) { Event.create(t: 20.minutes.ago.to_f) }
      let!(:event_2) { Event.create(t: Time.now.to_f) }
      let(:options) do
        {
          t: [
            I18n.l(30.minutes.ago),
            I18n.l(10.minutes.ago)
          ]
        }
      end

      it 'returns filtered t results' do
        expect(subject.search.map(&:id)).to eql [event_1.id]
      end
    end

    context 'on topic' do
      let!(:event_1) { Event.create(topic: 'photos') }
      let!(:event_2) { Event.create(topic: 'properties') }
      let!(:event_3) { Event.create(topic: 'rates') }
      let(:options) do
        {
          topic: ['photos', 'properties']
        }
      end

      it 'returns filtered topic results' do
        expect(subject.search.map(&:id).sort).to eql [event_1.id, event_2.id]
      end
    end

    context 'on type' do
      let!(:event_1) { Event.create(type: 'update') }
      let!(:event_2) { Event.create(type: 'create') }
      let!(:event_3) { Event.create(type: 'delete') }
      let!(:event_4) { Event.create(type: 'noop') }
      let(:options) do
        {
          type: ['update', 'delete']
        }
      end

      it 'returns filtered type results' do
        expect(subject.search.map(&:id).sort).to eql [event_1.id, event_3.id]
      end
    end
  end

  describe 'pagination' do
    let!(:event_1) { Event.create(t: 2.minutes.ago.to_f) }
    let!(:event_2) { Event.create(t: 1.minutes.ago.to_f) }
    let!(:event_3) { Event.create(t: Time.now.to_f ) }

    let(:options) do
      {
        page: 2,
        per_page: 1,
        order: [t: :desc]
      }
    end

    it 'accepts pagination params' do
      expect(subject.search.map(&:id)).to eql([event_2.id])
    end
  end
end
