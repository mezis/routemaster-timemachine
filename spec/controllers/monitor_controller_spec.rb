require 'rails_helper'

RSpec.describe MonitorController do

  describe 'health' do

    it 'renders false by default' do
      get :health
      expect(response.body).to eql('false')
    end

    context 'when enough events to cover the threshold' do

      let(:test_threshold) { 5 }

      around do |example|
        threshold = ENV['MONITOR_EVENTS_THRESHOLD']
        ENV['MONITOR_EVENTS_THRESHOLD'] = test_threshold.to_s
        example.run
        ENV['MONITOR_EVENTS_THRESHOLD'] = threshold.to_s
      end

      before do
        test_threshold.times { Event.create }
      end

      it 'renders true if events created exceed the acceptable threshold' do
        get :health
        expect(response.body).to eql('true')
      end

    end

  end
end
