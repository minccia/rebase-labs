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

post '/api/v1/import_csv' do 
  request_body = request.body.read.force_encoding("UTF-8")

  Tempfile.create(['uploaded', '.csv'], "#{Dir.pwd}/") do |f| 
    f << request_body 
    f.rewind 
    csv_data = CSVDataService.parse_csv(f.path).to_json 
    ImportCSVJob.perform_async(csv_data)
  end

  'Já botei tudo no banco meu queridão 😎'
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)