require_relative 'report_csv_importer'
require_relative 'report_csv_writer'
require_relative 'report_comparator'
require_relative 'report_summer'

importer = ReportCSVImporter.new
reports = Array.new

reports << importer.import("test.csv")

#second report has a new exchange rate.
importer.exchange_rate = 0.5
reports << importer.import("test.csv")

#comparator = ReportComparator.new
#report = comparator.compare(reports)

summer = ReportSummer.new
report = summer.sum(reports)

#report.render

exporter = ReportCSVWriter.new
exporter.write_to_file('out.csv', report)

puts "The end"
