require 'sinatra'

class ApiV1Controller < Sinatra::Base 
  get '/api/v1/exams' do 
    content_type :json
    
    conn = QueryService.new(host: 'postgres', dbname: 'postgres', user: 'postgres')
    exams = conn.all 
    
    exams.map do |exam|
      exam.as_hash
    end
    .to_json
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
end