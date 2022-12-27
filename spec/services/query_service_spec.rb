require 'spec_helper'

describe QueryService do 
  context '#create_table' do 
    it 'Método cria a tabela de exames no banco de dados com sucesso' do 
      query_service = QueryService.new('test-postgres', 'postgres', 'postgres')
      conn = PG.connect(host: 'test-postgres', dbname: 'postgres', user: 'postgres')

      query_service.create_table 
      result = conn.exec(
        "SELECT EXISTS (
          SELECT FROM 
            pg_tables
          WHERE 
            schemaname = 'public' AND 
            tablename  = 'exams'
        );"
      )

      expect(result.values).to eq [["t"]]
    end

    it 'E a tabela não foi criada' do 
      conn = PG.connect(host: 'test-postgres', dbname: 'postgres', user: 'postgres')

      result = conn.exec(
        "SELECT EXISTS (
          SELECT FROM 
            pg_tables
          WHERE 
            schemaname = 'public' AND 
            tablename  = 'exams'
        );"
      )

      expect(result.values).to eq [["f"]]
    end
  end

  context '#insert_exam' do 
    it 'Método insere um exame no banco de dados com sucesso' do 
      query_service = QueryService.new('test-postgres', 'postgres', 'postgres')
      conn = PG.connect(host: 'test-postgres', dbname: 'postgres', user: 'postgres')
      exam_data = { 
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
        "resultado tipo exame" => "132"
      }

      query_service.create_table
      query_service.insert_exam(exam_data)
      result = conn.exec("SELECT * FROM exams")
  
      expect(result.values.first).to eq [
        "048.123.189-19", "Ana Júlia", "anajulia@gmail.com",
        "2022-09-20", "Rua das flores, 59", "Fortaleza", "Ceará", 
        "00122910", "CE", "Dra. Ana Julia do Multiverso", "anajuliadomultiverso@gmail.com",
        "09209120", "2022-09-21", "exame do pézinho", "100-200", "132"
      ]
    end
  end
end