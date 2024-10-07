require 'rspec'

require_relative '../services/actions_generator'
require_relative '../car'
require_relative '../rental'
require_relative '../option'

RSpec.describe ActionsGenerator do
  let(:car) { Car.new(id: 1, price_per_day: 2000, price_per_km: 10) }
  let(:options) { [Option.new(id: 1, rental_id: 1, type: 'gps')] }
  let(:rental) { Rental.new(id: 1, car: car, distance: 100, options: options, start_date: '2015-12-8', end_date: '2015-12-8') }

  describe '#generate' do
    it 'should generate actions' do
      actions_generator_service = ActionsGenerator.new(rental: rental)
      expect(actions_generator_service.generate).to eq([
        {amount: 3500, type: "debit", who: "driver"},
        {amount: 2600, type: "credit", who: "owner"},
        {amount: 450, type: "credit", who: "insurance"},
        {amount: 100, type: "credit", who: "assistance"},
        {amount: 350, type: "credit", who: "drivy"}
      ])
    end
  end

  describe '#driver_debit' do
    it 'should calculate the driver debit' do
      car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
      options = [Option.new(id: 1, rental_id: 1, type: 'gps')]
      rental = Rental.new(
        id: 1,
        car: car,
        distance: 100,
        options: options,
        start_date: '2015-12-8',
        end_date: '2015-12-8'
      )
      actions_generator_service = ActionsGenerator.new(rental: rental)
      expect(actions_generator_service.driver_debit).to eq(3500)
    end
  end

  describe '#action' do
    it 'should generate an action' do
      actions_generator_service = ActionsGenerator.new(rental: rental)
      expect(actions_generator_service.action('driver', 'debit', 3500)).to eq({:amount=>3500, :type=>"debit", :who=>"driver"})
    end
  end
end
