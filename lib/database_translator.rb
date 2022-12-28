class DatabaseTranslator
  def self.pt_to_en(exam)
    {
      "registration_number" => exam["cpf"],
      "patient_name" => exam["nome paciente"],
      "patient_email" => exam["email paciente"],
      "patient_birth_date" => exam["data nascimento paciente"],
      "patient_address" => exam["endereço/rua paciente"],
      "patient_city" => exam["cidade paciente"],
      "patient_state"=> exam["estado patiente"],
      "doctor_council_rn" => exam["crm médico"],
      "doctor_council_state" => exam["crm médico estado"],
      "doctor_name" => exam["nome médico"],
      "doctor_email" => exam["email médico"],
      "exam_token" => exam["token resultado exame"],
      "exam_date" => exam["data exame"],
      "exam_type" => exam["tipo exame"],
      "exam_values" => exam["limites tipo exame"],
      "exam_result" => exam["resultado tipo exame"]
    }
  end
end