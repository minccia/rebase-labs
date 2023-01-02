require 'sinatra'
require 'rack/handler/puma'
require 'csv'
require 'json'
require "#{Dir.pwd}/lib/query_service"

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
end

Rack::Handler::Puma.run(
  Sinatra::Application,
  Port: 3000,
  Host: '0.0.0.0'
)