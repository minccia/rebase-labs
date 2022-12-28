require 'spec_helper'

describe QueryService do 
  context '#table_exists?' do 
    it 'Retorna true se a tabela existir no banco de dados' do 
      query_service = QueryService.new(host: 'test-postgres', dbname: 'postgres', user: 'postgres')

      query_service.create_table 

      expect(query_service.table_exists?).to be_truthy
    end

    it 'Retorna false se a tabela não existir no banco de dados' do 
      query_service = QueryService.new(host: 'test-postgres', dbname: 'postgres', user: 'postgres')

      expect(query_service.table_exists?).to be_falsy
    end
  end

  context '#drop_table' do 
    it 'Derruba a tabela do banco de dados com sucesso' do 
    query_service = QueryService.new(host: 'test-postgres', dbname: 'postgres', user: 'postgres')

    query_service.create_table 
    query_service.drop_table 

    expect(query_service.table_exists?).to be_falsy
    end
  end

  context '#all' do 
    it 'Devolve todos os registros da tabela de exams do banco de dados' do 
      query_service = QueryService.new(host: 'test-postgres', dbname: 'postgres', user: 'postgres')
      exam_data = JSON.parse File.read("#{Dir.pwd}/spec/support/exam.json")

      query_service.create_table 
      query_service.insert_exam(exam_data)
      result = query_service.all 

      expect(result.first.registration_number).to eq "048.123.189-19"
      expect(result.first.patient_name).to eq "Ana Júlia"
      expect(result.first.patient_email).to eq "anajulia@gmail.com"
      expect(result.first.patient_birth_date).to eq "2022-09-20"
      expect(result.first.patient_address).to eq "Rua das flores, 59"
      expect(result.first.patient_city).to eq "Fortaleza"
      expect(result.first.patient_state).to eq "Ceará"
      expect(result.first.doctor_council_rn).to eq "00122910"
      expect(result.first.doctor_council_state).to eq "CE"      
      expect(result.first.doctor_name).to eq "Dra. Ana Julia do Multiverso" 
      expect(result.first.doctor_email).to eq "anajuliadomultiverso@gmail.com" 
      expect(result.first.exam_token).to eq "09209120"
      expect(result.first.exam_date).to eq "2022-09-21"
      expect(result.first.exam_type).to eq "exame do pézinho"
      expect(result.first.exam_values).to eq "100-200"
      expect(result.first.exam_result).to eq "132"
    end
  end

  context '#insert_exam' do 
    it 'Insere um exame no banco de dados com sucesso' do 
      query_service = QueryService.new(host: 'test-postgres', dbname: 'postgres', user: 'postgres')
      exam_data = JSON.parse File.read("#{Dir.pwd}/spec/support/exam.json")

      query_service.create_table
      result = query_service.insert_exam(exam_data)
      
      expect(result.registration_number).to eq "048.123.189-19"
      expect(result.patient_name).to eq "Ana Júlia"
      expect(result.patient_email).to eq "anajulia@gmail.com"
      expect(result.patient_birth_date).to eq "2022-09-20"
      expect(result.patient_address).to eq "Rua das flores, 59"
      expect(result.patient_city).to eq "Fortaleza"
      expect(result.patient_state).to eq "Ceará"
      expect(result.doctor_council_rn).to eq "00122910"
      expect(result.doctor_council_state).to eq "CE"      
      expect(result.doctor_name).to eq "Dra. Ana Julia do Multiverso" 
      expect(result.doctor_email).to eq "anajuliadomultiverso@gmail.com" 
      expect(result.exam_token).to eq "09209120"
      expect(result.exam_date).to eq "2022-09-21"
      expect(result.exam_type).to eq "exame do pézinho"
      expect(result.exam_values).to eq "100-200"
      expect(result.exam_result).to eq "132"
    end
  end

  context '#import_from_csv' do 
    it 'Recebe dados a partir de um arquivo CSV e os insere como registros no banco de dados' do 
      query_service = QueryService.new(host: 'test-postgres', dbname: 'postgres', user: 'postgres')
      csv_data = CSVDataService.parse_csv("#{Dir.pwd}/spec/support/exams.csv")

      query_service.create_table
      result = query_service.import_from_csv(csv_data)

      expect(result.first.registration_number).to eq "048.973.170-88"
      expect(result.first.patient_name).to eq "Emilly Batista Neto"
      expect(result.first.patient_email).to eq "gerald.crona@ebert-quigley.com"
      expect(result.first.patient_birth_date).to eq "2001-03-11"
      expect(result.first.patient_address).to eq "165 Rua Rafaela"
      expect(result.first.patient_city).to eq "Ituverava"
      expect(result.first.patient_state).to eq "Alagoas"
      expect(result.first.doctor_council_rn).to eq "B000BJ20J4"
      expect(result.first.doctor_council_state).to eq "PI"      
      expect(result.first.doctor_name).to eq "Maria Luiza Pires" 
      expect(result.first.doctor_email).to eq "denna@wisozk.biz" 
      expect(result.first.exam_token).to eq "IQCZ17"
      expect(result.first.exam_date).to eq "2021-08-05"
      expect(result.first.exam_type).to eq "hemácias"
      expect(result.first.exam_values).to eq "45-52"
      expect(result.first.exam_result).to eq "97"
      expect(result[1].registration_number).to eq "048.108.026-04"
      expect(result[1].patient_name).to eq "Juliana dos Reis Filho"
      expect(result[1].patient_email).to eq "mariana_crist@kutch-torp.com"
      expect(result[1].patient_birth_date).to eq "1995-07-03"
      expect(result[1].patient_address).to eq "527 Rodovia Júlio"
      expect(result[1].patient_city).to eq "Lagoa da Canoa"
      expect(result[1].patient_state).to eq "Paraíba"
      expect(result[1].doctor_council_rn).to eq "B0002IQM66"
      expect(result[1].doctor_council_state).to eq "SC"
      expect(result[1].doctor_name).to eq "Maria Helena Ramalho"
      expect(result[1].doctor_email).to eq "rayford@kemmer-kunze.info"
      expect(result[1].exam_token).to eq "0W9I67"
      expect(result[1].exam_date).to eq "2021-07-09"
      expect(result[1].exam_type).to eq "hemácias"
      expect(result[1].exam_values).to eq "45-52"
      expect(result[1].exam_result).to eq "28"
    end
  end
end