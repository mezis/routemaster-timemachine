require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe EventsController do
  include ActiveJob::TestHelper

  describe 'index' do
    it 'requires login' do
      get :index
      expect(response).to_not be_successful
    end

    it 'returns 401' do
      get :index
      expect(response.code).to eql('401')
    end

    context 'when authenticated' do
      before { http_login }

      it 'makes the request successful' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'replay_events' do
    before do
      http_login
    end

    it 'schedules a job based in the params' do
      expect(ReplayJob).to receive(:perform_later)
      .with(topic: ['photos'])
      .and_call_original

      expect {
        get :replay_events, event_search: { topic: ['photos'] }
      }.to change { enqueued_jobs.count { |j| j[:job] == ReplayJob } }.by(1)
    end
  end
end
