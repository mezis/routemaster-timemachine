require 'rails_helper'

RSpec.describe ReplayWorker do

  before do
    allow_any_instance_of(Replay).to receive(:replay)
  end

  it 'calls Replay with the expected scope' do
    expect(Replay).to receive(:new)
      .with(EventSearch.new.scope)
      .and_call_original

    described_class.new.perform
  end

  context 'when specific topic' do

    let(:options) do
      { topic: ["photos"] }
    end

    it 'calls replay with the filtered scope' do
      expect(Replay).to receive(:new)
        .with(EventSearch.new(options).scope)
        .and_call_original

      described_class.new.perform(options)
    end
  end
end
