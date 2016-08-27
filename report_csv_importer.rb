require 'csv'
require 'date'
require_relative 'account'
require_relative 'profit_and_loss_report'

class ReportCSVImporter
  private
  def convert_row_to_account(row)
    account = Account.new();
    account.id = row[0].strip
    account.description = row[1].strip
    for i in 2..row.size-2
      account.set_month_income(i-2, row[i])
    end
    return account
  end

  public
  def import(file_name)
    header_parsed = false;
    report = ProfitAndLossReport.new
    CSV.foreach(file_name, converters: :numeric) do |row|
      if row.size > 7 && !row[0].nil?
        if header_parsed
          report.add_account(convert_row_to_account(row))
        end
      else
        puts "Parsing the header fucker."
        header_parsed = true
      end
    end
    return report
  end
end
