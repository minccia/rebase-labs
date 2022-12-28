require 'pg'
require_relative 'exam'

class QueryService
  def initialize(host:, dbname:, user:)
    @conn = PG.connect(host: host, dbname: dbname, 
                       user: user)
  end

  def table_exists?
    query = @conn.exec(
      "SELECT EXISTS (
        SELECT FROM 
          pg_tables
        WHERE 
          schemaname = 'public' AND 
          tablename  = 'exams'
      );"
    )
    query.values == [["t"]] ? true : false 
  end

  def create_table
    @conn.exec(
      'CREATE TABLE IF NOT EXISTS exams (
      "registration_number" VARCHAR(14),
      "patient_name" VARCHAR(100),
      "patient_email" VARCHAR(100),
      "patient_birth_date" DATE,
      "patient_address" VARCHAR(100),
      "patient_city" VARCHAR(50),
      "patient_state" VARCHAR(50),
      "doctor_council_rn" VARCHAR(10),
      "doctor_council_state" VARCHAR(2),
      "doctor_name" VARCHAR(100),
      "doctor_email" VARCHAR(100),
      "exam_token" VARCHAR(10),
      "exam_date" DATE,
      "exam_type" VARCHAR(50),
      "exam_values" VARCHAR(10),
      "exam_result" INTEGER
    )'
  )
  end

  def drop_table 
    @conn.exec('DROP TABLE IF EXISTS exams')
  end
  
  def all 
    exams = @conn.exec('SELECT * FROM exams').to_a
  end

  def insert_exam(exam)
    @conn.exec_params(
      "INSERT INTO exams VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10,
      $11, $12, $13, $14, $15, $16)", exam.values.to_a
    )
    Exam.new(exam)
  end

  def import_from_csv(csv_data)
    csv_data.map do |exam|
      insert_exam(exam)
    end
  end
end