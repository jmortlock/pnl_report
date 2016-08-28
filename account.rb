require_relative 'money'

# Account class
class Account
  attr_accessor :id, :description

  def initialize(id: 0, description: '')
    @container = []
    @id = id
    @description = description
  end

  #
  # Set the income for a given month.
  #
  def set_month_income(index, month, amount)
    raise "Month #{month} is outside of range" unless month >= 0 && month <= 11
    unless amount.nil?
      income = @container[index]
      # create a new entry for the month if it dosen't exist.
      if income.nil?
        income = {}
        @container[index] = income
      end
      income[month] = amount
    end
  end

  def get_month_income(index, month)
    income_table = @container[index]
    if !income_table.nil? && !income_table[month].nil?
      income_table[month]
    end
    Money.new(0, 0)
  end

  def income_table
    @container
  end

  def income(index)
    @container[index]
  end

  def total(index)
    total = 0
    income = income(index)
    unless income.nil?
      income.each do |_key, value|
        total += value
      end
    end
    total
  end
end
