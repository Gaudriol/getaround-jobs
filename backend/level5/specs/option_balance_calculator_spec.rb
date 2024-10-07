require_relative '../services/options_balance_calculator'

describe OptionsBalanceCalculator do
  describe '#calculate' do
    it 'should calculate the correct balance for the options' do
      options = ['gps', 'baby_seat']
      duration = 3
      options_balance_calculator_service = OptionsBalanceCalculator.new(options: options, duration: duration)
      expect(options_balance_calculator_service.calculate).to eq(1100)

      options = ['additional_insurance']
      duration = 3
      options_balance_calculator_service = OptionsBalanceCalculator.new(options: options, duration: duration)
      expect(options_balance_calculator_service.calculate).to eq(1000)
    end
  end
end
