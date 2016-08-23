class Account
  attr_accessor :id, :description
  attr_reader :income

  def initialize
    @income = Hash.new
  end

  def set_month_income(month, amount)
    unless amount.nil?
      @income[month] = amount.delete('$,').to_f
    end
  end

  def total
    total = 0
    @income.each do |key,value|
      total += value
    end
    return total
  end
end
