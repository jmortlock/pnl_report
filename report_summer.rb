require_relative 'profit_and_loss_report'
#
# Adds the income for each report to one another.
#
class ReportSummer
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

  def build_report(report)
    report.accounts.each do |report_account|
      account = add_account(report_account)
      (0..11).each do |i|
        income = account.get_month_income(0, i)
        income += report_account.get_month_income(0, i)
        account.set_month_income(0, i, income)
      end
      @accounts << account
    end
  end

  def sum(reports)
    result = ProfitAndLossReport.new
    reports.each do |report|
      build_report(report)
    end

    @accounts.each do |account|
      result.add_account(account)
    end
    result
  end
end
