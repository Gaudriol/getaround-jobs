require 'rspec'
require_relative '../rental'
require_relative '../car'

START_DATE = '2015-07-3'
END_DATE = '2015-07-14'

RSpec.describe Rental do
  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }
  let(:rental) { Rental.new(id: 1, car: car, start_date: START_DATE, end_date: END_DATE, distance: 100) }

  describe '#initialize' do
    it 'sets the correct attributes' do
      expect(rental.id).to eq(1)
      expect(rental.car).to eq(car)
      expect(rental.start_date).to eq(Date.parse(START_DATE))
      expect(rental.end_date).to eq(Date.parse(END_DATE))
      expect(rental.distance).to eq(100)
    end

    it 'should raise an error if the start date is after the end date' do
      expect { Rental.new(id: 1, car: car, start_date: END_DATE, end_date: START_DATE, distance: 100) }.to raise_error('Start date is after end date')
    end
  end

  describe '#get_duration' do
    it 'should calculate the correct duration' do
      expect(rental.duration).to eq(12)
    end
  end
end
