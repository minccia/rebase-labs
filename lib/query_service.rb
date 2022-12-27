require 'pg'

class QueryService
  def initialize(host, dbname, user)
    @conn = PG.connect(host: host, dbname: dbname, 
                       user: user)
  end

  def create_table
    @conn.exec(
      'CREATE TABLE IF NOT EXISTS exams (
      "cpf" VARCHAR(14),
      "nome paciente" VARCHAR(100),
      "email paciente" VARCHAR(100),
      "data nascimento paciente" DATE,
      "endereço/rua paciente" VARCHAR(100),
      "cidade paciente" VARCHAR(50),
      "estado patiente" VARCHAR(50),
      "crm médico" VARCHAR(10),
      "crm médico estado" VARCHAR(50),
      "nome médico" VARCHAR(100),
      "email médico" VARCHAR(100),
      "token resultado exame" VARCHAR(10),
      "data exame" DATE,
      "tipo exame" VARCHAR(50),
      "limites tipo exame" VARCHAR(10),
      "resultado tipo exame" INTEGER
    )'
  )
  end
  
  def insert_exam(exam)
    columns = exam.keys.map { |key| @conn.escape_identifier(key) }.join(', ')
    values = exam.values.map { |value| @conn.escape_literal(value) }.join(', ')
    @conn.exec(%Q{INSERT INTO exams (#{columns}) VALUES (#{values})})
  end
end