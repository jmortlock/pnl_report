require_relative 'report_csv_importer'
require_relative 'report_csv_writer'
require_relative 'report_comparator'

importer = ReportCSVImporter.new
reports = Array.new

reports << importer.import("test.csv")
#report.render

reports << importer.import("test.csv")
#second_report.render

comparator = ReportComparator.new
report = comparator.compare(reports)

#report.render

exporter = ReportCSVWriter.new
exporter.write_to_file('out.csv', report)

puts "The end"
