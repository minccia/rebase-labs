require 'spec_helper'

describe CSVDataService do 
  context '.parse_csv' do 
    it 'Recebe o caminho de um arquivo CSV e devolve um array de hashes ruby com os dados' do 
      result =  CSVDataService.parse_csv("#{Dir.pwd}/spec/support/exams.csv")
      expected_csv_headers = [
        "cpf", "nome paciente", "email paciente", "data nascimento paciente",
        "endereço/rua paciente", "cidade paciente", "estado patiente", "crm médico",
        "crm médico estado", "nome médico", "email médico", "token resultado exame",
        "data exame", "tipo exame", "limites tipo exame", "resultado tipo exame"
      ]

      expect(result.class).to eq Array 
      expect(result.first.keys).to eq expected_csv_headers
      expect(result.first["cpf"]).to eq '048.973.170-88'
      expect(result.first["nome paciente"]).to eq 'Emilly Batista Neto' 
      expect(result.first["email paciente"]).to eq 'gerald.crona@ebert-quigley.com'
      expect(result.first["data nascimento paciente"]).to eq '2001-03-11'
      expect(result.first["endereço/rua paciente"]).to eq '165 Rua Rafaela'
      expect(result.first["cidade paciente"]).to eq 'Ituverava'
      expect(result.first["estado patiente"]).to eq 'Alagoas'
      expect(result.first["crm médico"]).to eq 'B000BJ20J4'
      expect(result.first["crm médico estado"]).to eq 'PI'
      expect(result.first["nome médico"]).to eq 'Maria Luiza Pires'
      expect(result.first["email médico"]).to eq 'denna@wisozk.biz'
      expect(result.first["token resultado exame"]).to eq 'IQCZ17'
      expect(result.first["data exame"]).to eq '2021-08-05'
      expect(result.first["tipo exame"]).to eq 'hemácias'
      expect(result.first["limites tipo exame"]).to eq '45-52'
      expect(result.first["resultado tipo exame"]).to eq '97'
    end
  end
end