require 'rspec'
require_relative '../car'

RSpec.describe Car do
  describe '#initialize' do
    it 'creates a new Car instance with id, price_per_day, and price_per_km' do
      car = Car.new(id: 1, price_per_day: 100, price_per_km: 0.5)
      expect(car).to be_a(Car)
      expect(car.id).to eq(1)
      expect(car.price_per_day).to eq(100)
      expect(car.price_per_km).to eq(0.5)
    end
  end
end
