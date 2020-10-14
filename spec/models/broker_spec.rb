require 'rails_helper'

RSpec.describe Broker, type: :model do
  describe 'creation' do
    it 'can t be created without Siren' do
      broker = Broker.create(name: "testbroker")
      expect(broker).not_to be_valid
    end

    it 'can t be created with a Siren s size different than 9' do
      broker = Broker.create(name: "testbroker", siren:1234567)
      expect(broker).not_to be_valid
    end

    it 'can t create two broker with the same Siren' do
      broker1 = Broker.create(name: "testbroker", siren:123456789)
      broker2 = Broker.create(name: "testbroker", siren:123456789)
      expect(broker2).not_to be_valid
    end

    it 'can be created' do
      broker = Broker.create(name: "testbroker", siren:123456789)
      expect(broker).to be_valid
    end
  end
end
