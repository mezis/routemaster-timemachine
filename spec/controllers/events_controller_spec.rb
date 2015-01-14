require 'rails_helper'

RSpec.describe EventsController do

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
end
