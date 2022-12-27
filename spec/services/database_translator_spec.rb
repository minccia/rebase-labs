require 'spec_helper'

describe DatabaseTranslator do 
  context '.translate_columns' do 
    it 'Traduz nome das colunas da tabela exams de inglês para português' do 
      exam_hash = { 
        "cpf" => "048.123.189-19",
        "nome paciente" => "Ana Júlia",
        "email paciente" => "anajulia@gmail.com",
        "data nascimento paciente" => "2022-09-20",
        "endereço/rua paciente" => "Rua das flores, 59",
        "cidade paciente" => "Fortaleza",
        "estado patiente" => "Ceará",
        "crm médico" => "00122910",
        "crm médico estado" => "CE",
        "nome médico" => "Dra. Ana Julia do Multiverso",
        "email médico" => "anajuliadomultiverso@gmail.com",
        "token resultado exame" => "09209120",
        "data exame" => "2022-09-21",
        "tipo exame" => "exame do pézinho",
        "limites tipo exame" => "100-200",
        "resultado tipo exame" => "1323" 
      }
  
      result = DatabaseTranslator.translate_columns(exam_hash)
  
      expect(result.keys).to eq [
        "registration_number", "patient_name", "patient_email", "patient_birth_date",
        "patient_address", "patient_city", "patient_state", "doctor_council_rn",
        "doctor_council_state", "doctor_name", "doctor_email", "exam_token", 
        "exam_date", "exam_type", "exam_values", "exam_result"
      ]
    end
  end
end