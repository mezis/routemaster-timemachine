require 'rails_helper'

RSpec.describe EventSearch do

  let(:options) { {} }

  subject { described_class.new(options) }

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
