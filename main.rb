require 'yaml'
require_relative 'report_csv_importer'
require_relative 'report_csv_writer'
require_relative 'report_comparator'
require_relative 'report_summer'

importer = ReportCSVImporter.new
reports = []

# Parse the configuration file.
config = YAML.load_file('config.yml')

input_files = config['input_files']

input_files.each do |file|
  puts "Importing from file '#{file['name']}'"
  rates = file['exchange_rates']
  importer.exchange_rates(rates)
  reports << importer.import(file['name'])
end

budget_file = config['budget_file']
puts "Comparing to budget file '#{budget_file}'"
# comparator = ReportComparator.new
# report = comparator.compare(reports)

summer = ReportSummer.new
report = summer.sum(reports)

# report.render
export_file = config['output']
puts "Writing to file '#{export_file}'"
exporter = ReportCSVWriter.new
exporter.write_to_file(export_file, report)

puts 'The end'
