require 'rails_helper'

RSpec.describe Sweeper do

  before do
    Event.create(created_at: 10.days.ago)
    Event.create(created_at: 8.days.ago)
    Event.create(created_at: 4.days.ago)
    Event.create(created_at: 1.days.ago)
  end

  it 'deletes past events' do
    expect { described_class.new.perform }
      .to change { Event.count }.from(4).to(2)
  end
end
