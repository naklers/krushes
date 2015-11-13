# From http://stackoverflow.com/questions/7754896/import-csv-data-in-a-rails-app-with-activeadmin
require 'csv'
class CsvDb
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      lines = CSV.parse(csv_file)
      header = lines.shift
      lines.each do |line|
        attributes = Hash[header.zip line]
        target_model = model_name.classify.constantize
        target_model.create(attributes)
      end
    end
  end
end
