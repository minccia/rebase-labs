require 'spec_helper'

describe Exam do 
  context '#as_json'do 
    it 'Converte um objeto da classe Exam em um JSON com seus atributos' do 
      params = { 
        "registration_number" => "048.123.189-19",
        "patient_name" => "Ana Júlia",
        "patient_email" => "anajulia@gmail.com",
        "patient_birth_date" => "2022-09-20",
        "patient_address" => "Rua das flores, 59",
        "patient_city" => "Fortaleza",
        "patient_state" => "Ceará",
        "doctor_council_rn" => "00122910",
        "doctor_council_state" => "CE",
        "doctor_name" => "Dra. Ana Julia do Multiverso",
        "doctor_email" => "anajuliadomultiverso@gmail.com",
        "exam_token" => "09209120",
        "exam_date" => "2022-09-21",
        "exam_type" => "exame do pézinho",
        "exam_values" => "100-200",
        "exam_result" => "132" 
      }

      exam = Exam.new(params)
      result = exam.as_json

      expect(result.class).to eq String
      expect(result).to include "registration_number"
      expect(result).to include "048.123.189-19"
      expect(result).to include "patient_name"
      expect(result).to include "Ana Júlia"
      expect(result).to include "patient_email"
      expect(result).to include "anajulia@gmail.com"
    end
  end
end