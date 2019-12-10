require 'rails_helper'

describe Client do
  describe 'full_description' do
    it 'must return name with document' do
      client = Client.create(name: 'Alex Santos', document:'395.069.980-51', email: 'alex@alex.com')

      expect(client.full_description).to eq 'Alex Santos - 395.069.980-51'
    end
  end
end