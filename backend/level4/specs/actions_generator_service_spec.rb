require 'rspec'

require_relative '../actions_generator_service'
require_relative '../car'
require_relative '../rental'

RSpec.describe ActionsGeneratorService do
  describe '#generate' do
    context 'when given valid input' do
      it 'should generate valid actions' do
        expected_actions = [
          {
            "who": "driver",
            "type": "debit",
            "amount": 27800
          },
          {
            "who": "owner",
            "type": "credit",
            "amount": 19460
          },
          {
            "who": "insurance",
            "type": "credit",
            "amount": 4170
          },
          {
            "who": "assistance",
            "type": "credit",
            "amount": 1200
          },
          {
            "who": "drivy",
            "type": "credit",
            "amount": 2970
          }
        ]
        car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
        rental = Rental.new(
          id: 1,
          car: car,
          start_date: '2015-07-3',
          end_date: '2015-07-14',
          distance: 1000
        )
        expect(ActionsGeneratorService.new(rental: rental).generate).to eq(expected_actions)
      end
    end
  end
end
