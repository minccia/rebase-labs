class Exam 
  @@attributes = [:registration_number, :patient_name, :patient_email, :patient_birth_date, 
                  :patient_address, :patient_city, :patient_state, :doctor_council_rn,
                  :doctor_council_state, :doctor_name, :doctor_email, :exam_token,
                  :exam_date, :exam_type, :exam_values, :exam_result]
  
  attr_accessor *@@attributes 

  def initialize data
    @registration_number = data["registration_number"]
    @patient_name = data["patient_name"]
    @patient_email = data.fetch("patient_email")
    @patient_birth_date = data.fetch("patient_birth_date")
    @patient_address = data.fetch("patient_address")
    @patient_city = data.fetch("patient_city")
    @patient_state = data.fetch("patient_state")
    @doctor_council_rn = data.fetch("doctor_council_rn")
    @doctor_council_state = data.fetch("doctor_council_state")
    @doctor_name = data.fetch("doctor_name")
    @doctor_email = data.fetch("doctor_email")
    @exam_token = data.fetch("exam_token")
    @exam_date = data.fetch("exam_date")
    @exam_type = data.fetch("exam_type")
    @exam_values = data.fetch("exam_values")
    @exam_result = data.fetch("exam_result")
  end
end