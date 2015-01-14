require 'rails_helper'

RSpec.describe Event, :type => :model do

  subject do
    described_class.new({
      topic: 'properties',
      type:  'updated',
      url:   'https://foo.dev/properties/1',
      t:     1420568264126
   })
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'creates the resource' do
    expect{ subject.save }.to change(Event, :count).from(0).to(1)
  end


end
