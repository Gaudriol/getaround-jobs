require 'rspec'
require_relative '../services/commission_calculator'

RSpec.describe CommissionCalculator do
  describe '#calculate_commission' do
    context 'when given valid input' do
      it 'should calculate the correct commission' do
        expected_commission = {
          insurance_fee: 4170,
          assistance_fee: 1200,
          drivy_fee: 2970
        }
        expect(CommissionCalculator.new(base_price: 27800, duration: 12).calculate).to eq(expected_commission)
      end

      it 'should raise if duration is 0' do
        expect { CommissionCalculator.new(base_price: 1000, duration: 0).calculate }.to raise_error('Duration is not positive')
      end

      it 'should raise if duration is negative' do
        expect { CommissionCalculator.new(base_price: 1000, duration: -1).calculate }.to raise_error('Duration is not positive')
      end
    end

    context 'when given invalid input' do
      it 'should raise fee is negative error' do
        expect { CommissionCalculator.new(base_price: 1000, duration: 100).calculate }.to raise_error('Drivy fee is negative')
      end
    end
  end
end

