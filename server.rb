require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'json'
require "#{Dir.pwd}/lib/query_service"

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

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)