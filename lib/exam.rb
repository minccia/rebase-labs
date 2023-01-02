class Exam 
  @@attributes = [:registration_number, :patient_name, :patient_email, :patient_birth_date, 
                  :patient_address, :patient_city, :patient_state, :doctor_council_rn,
                  :doctor_council_state, :doctor_name, :doctor_email, :exam_token,
                  :exam_date, :exam_type, :exam_values, :exam_result]
  
  attr_accessor *@@attributes 

  def initialize data
    @@attributes.each do |attr|
      instance_variable_set "@#{attr.to_s}", data[attr.to_s]
    end
  end
  
  def as_json
    instance_variables.each.with_object({}) do |var, hash|
      hash.send :store, var.to_s.delete("@"), instance_variable_get(var)
    end
    .to_json
  end
end