require 'sidekiq'
require "#{Dir.pwd}/lib/query_service"

class ImportCSVJob 
  include Sidekiq::Job

  def perform(csv_data)
    query_service = QueryService.new(host: 'postgres', dbname: 'postgres', user: 'postgres')

    query_service.import_from_csv(JSON.parse(csv_data))
    query_service.close_connection
  end
end