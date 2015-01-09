require 'rails_helper'

RSpec.describe EventSearch do

  let(:options) { {} }

  subject { described_class.new(options) }

  describe 'ordering' do
    let!(:event_1) { Event.create(t: ( Time.now - 2.minutes.ago ).to_f) }
    let!(:event_2) { Event.create(t: Time.now.to_f ) }

    it 'orders events by t on default' do
      expect(subject.search.map(&:id)).to eql([event_2.id, event_1.id])
    end
  end
end
