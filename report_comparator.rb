require_relative 'profit_and_loss_report'

# Report Comparator.
class ReportComparator
  def initialize
    @accounts = []
  end

  def add_account(account)
    # First try and see if we already have the account.
    acc = @accounts.select { |x| x.id == account.id }.first
    if acc.nil?
      acc = Account.new(id: account.id, description: account.description)
    end
    acc
  end

  def build_report(report_number, report)
    report.accounts.each do |report_account|
      account = add_account(report_account)
      (0..11).each do |i|
        merged_account.set_month_income(report_number, i, account.get_month_income(0, i))
      end
      @accounts << account
    end
  end

  def compare(reports)
    result = ProfitAndLossReport.new
    index = 0
    reports.each do |report|
      build_report(index, report)
      index += 1
    end

    @accounts.each do |account|
      result.add_account(account)
    end
    result
  end
end
