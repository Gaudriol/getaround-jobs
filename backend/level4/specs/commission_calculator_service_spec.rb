require 'rspec'
require_relative '../commission_calculator_service'

RSpec.describe CommissionCalculatorService do
  describe '#calculate_commission' do
    context 'when given valid input' do
      it 'should calculate the correct commission' do
        expected_commission = {
          insurance_fee: 4170,
          assistance_fee: 1200,
          drivy_fee: 2970
        }
        expect(CommissionCalculatorService.new(total_price: 27800, duration: 12).calculate).to eq(expected_commission)
      end

      it 'should raise if duration is 0' do
        expect { CommissionCalculatorService.new(total_price: 1000, duration: 0).calculate }.to raise_error('Duration is not positive')
      end

      it 'should raise if duration is negative' do
        expect { CommissionCalculatorService.new(total_price: 1000, duration: -1).calculate }.to raise_error('Duration is not positive')
      end
    end

    context 'when given invalid input' do
      it 'should raise fee is negative error' do
        expect { CommissionCalculatorService.new(total_price: 1000, duration: 100).calculate }.to raise_error('Drivy fee is negative')
      end
    end
  end
end

