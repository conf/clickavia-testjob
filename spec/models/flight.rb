require 'spec_helper'

describe Flight do
  describe '#travel_time' do
    let(:flight) { create :flight }

    it { flight.travel_time.should be }
  end
end