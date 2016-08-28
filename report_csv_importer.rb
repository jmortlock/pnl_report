require 'csv'
require 'date'
require_relative 'money'
require_relative 'account'
require_relative 'profit_and_loss_report'

# CSV Importer class
class ReportCSVImporter
  attr_accessor :exchange_rate

  def initialize
    @exchange_rate = 1
    @first_month = 0
    @header_parsed = false
    fixed_rate(0)
  end

  private

  def fixed_rate(rate)
    @exchange_rates = []
    11.times { @exchange_rates << rate }
  end

  def get_exchange_rate(month)
    raise "Month #{month} out of bounds [0,11]" unless month >= 0 && month <= 11
    @exchange_rates[month]
  end

  # We want to map the columns in the report to a normal
  # month index range (0-11)
  def normalise_month(row_index)
    month_index = row_index + @first_month
    month_index -= 12 if month_index >= 12
    month_index
  end

  # Convert the row data into an account record.
  def convert_row_to_account(row)
    account = Account.new id: row[0].strip, description: row[1].strip
    for i in 2..row.size - 2
      amount = row[i].delete('$,').to_f unless row[i].nil?
      month = normalise_month(i - 2)
      income = Money.new(amount, get_exchange_rate(month))
      account.set_month_income(0, month, income)
    end
    account
  end

  # Parse the header row,basically just need the first month.
  # first month lives in column 2.
  def parse_header(row)
    @first_month = 0 # January.
    row.each do |col|
      next unless col.nil?
      index = Date::MONTHNAMES.index(col.strip)
      unless index.nil?
        @first_month = index
        break
      end
    end
    @header_parsed = true
  end

  def row_valid?(row)
    row.size > 7 && !row[0].nil?
  end

  def parse_row(report, row)
    if row_valid?(row)
      if !@header_parsed
        parse_header(row)
      else
        report.add_account(convert_row_to_account(row))
      end
    end
  end

  public

  def exchange_rates(rates)
    if rates.class == Array
      @exchange_rates = rates
    else
      fixed_rate(rates)
    end
  end

  def import(file_name)
    @header_parsed = false
    @first_month = 0
    report = ProfitAndLossReport.new
    CSV.foreach(file_name, converters: :numeric) do |row|
      parse_row(report, row)
    end
    report
  end
end
