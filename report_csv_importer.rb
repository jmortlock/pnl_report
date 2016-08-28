require 'csv'
require 'date'
require_relative 'account'
require_relative 'profit_and_loss_report'

class ReportCSVImporter

  def initialize
    @first_month = 0;
    @header_parsed = false;
  end

  private

  # We want to map the columns in the report to a normal
  # month index range (0-11)
  def normalise_month(row_index)
    month_index = row_index + @first_month
    if month_index >= 12
      month_index -= 12
    end
    return month_index
  end

  # Convert the row data into an account record.
  def convert_row_to_account(row)
    account = Account.new
    account.id = row[0].strip
    account.description = row[1].strip
    for i in 2..row.size-2
      amount = row[i].delete('$,').to_f unless row[i].nil?
      account.set_month_income(0, normalise_month(i-2), amount)
    end
    return account
  end

  # Parse the header row,basically just need the first month.
  # first month lives in column 2.
  def parse_header(row)
    @first_month = 0 #January.
    row.each do |col|
      if !col.nil?
        col_name = col.strip
        index = Date::MONTHNAMES.index(col_name)
        if !index.nil?
          @first_month = index
          break
        end
      end
    end
    @header_parsed = true
  end

  def is_row_valid?(row)
    return row.size > 7 && !row[0].nil?
  end

  def parse_row(report, row)
    if is_row_valid?(row)
      if !@header_parsed
        parse_header(row)
      else
        report.add_account(convert_row_to_account(row))
      end
    end
  end

  public
  def import(file_name)
    @header_parsed = false
    @first_month = 0
    report = ProfitAndLossReport.new
    CSV.foreach(file_name, converters: :numeric) do |row|
      parse_row(report, row)
    end
    return report
  end
end
