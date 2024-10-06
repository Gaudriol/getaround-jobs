class CommissionCalculatorService
  def initialize(total_price:, duration:)
    @total_price = total_price
    @duration = duration
  end

  def calculate
    commission = @total_price * 0.3
    insurance_fee = commission * 0.5
    assistance_fee = @duration * 100
    drivy_fee = commission - insurance_fee - assistance_fee

    raise 'Drivy fee is negative' if drivy_fee < 0

    {
      insurance_fee: insurance_fee.to_i,
      assistance_fee: assistance_fee.to_i,
      drivy_fee: drivy_fee.to_i
    }
  end
end