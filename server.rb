require 'sinatra'
require 'rack/handler/puma'
require 'json'
require 'sidekiq'
require "#{Dir.pwd}/lib/query_service"
require "#{Dir.pwd}/lib/csv_data_service"
require "#{Dir.pwd}/jobs/import_csv_job"


set :public_folder, 'public'

get '/api/v1/exams' do 
  content_type :json
  
  conn = QueryService.new(host: 'postgres', dbname: 'postgres', user: 'postgres')
  exams = conn.all 
  
  exams.map do |exam|
    exam.as_hash
  end
  .to_json
end

get '/tests' do
  send_file File.join(settings.public_folder, 'views/index.html')
end

post '/import' do 
  request_body = request.body.read.force_encoding("UTF-8")

  File.write('./tmp/uploaded.csv', csv)
  csv_data = CSVDataService.parse_csv('./tmp/uploaded.csv').to_json
  File.delete('./tmp/uploaded.csv')
  ImportCSVJob.perform_async(csv_data)

  'Já botei tudo no banco meu queridão 😎'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)