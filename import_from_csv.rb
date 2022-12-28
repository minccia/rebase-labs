require "#{Dir.pwd}/lib/csv_data_service"
require "#{Dir.pwd}/lib/query_service"

HOST = 'postgres'
DBNAME = 'postgres'
USER = 'postgres'

query_service = QueryService.new(host: HOST, dbname: DBNAME, user: USER)

query_service.drop_table 
query_service.create_table 

csv_data = CSVDataService.parse_csv('./data.csv')

query_service.import_from_csv(csv_data)
query_service.close_connection
puts 'Já botei tudo no banco meu queridão 😎'