require 'rspec'

require_relative '../car'
require_relative '../price_calculator_service'

RSpec.describe PriceCalculatorService do
  describe '#calculate' do
    context 'when given valid input' do
      it 'should calculate the correct price' do
        expected_price = 27800
        car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
        expect(PriceCalculatorService.new(car: car, distance: 1000, duration: 12).calculate).to eq(expected_price)
      end
    end
  end
end

