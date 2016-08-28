require 'date'

# Profit and Loss report.
class ProfitAndLossReport
  attr_reader :accounts

  def initialize
    @accounts = []
    @first_month = 0
  end

  private

  def get_month_name(index)
    Date::MONTHNAMES[index + 1]
  end

  public

  # add an account to the report if it dosen't already exist.
  def add_account(account)
    @accounts << account unless @accounts.index { |x| x.id == account.id }
  end

  def render
    @accounts.each do |account|
      puts "Account: #{account.id} and #{account.description}"
      account.income_table.each do |income|
        next if income.nil?
        income.each do |key, value|
          month_name = get_month_name(key)
          puts "Month #{month_name} with value #{value}"
        end
        puts "Total is #{account.total(0)}"
      end
    end
  end
end
