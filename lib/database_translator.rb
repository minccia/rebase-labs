class DatabaseTranslator
  def self.pt_to_en(params)
    incoming_vars = [
      "cpf", "nome paciente", "email paciente", "data nascimento paciente",
      "endereço/rua paciente", "cidade paciente", "estado patiente", "crm médico",
      "crm médico estado", "nome médico", "email médico", "token resultado exame",
      "data exame", "tipo exame", "limites tipo exame", "resultado tipo exame"
    ]

    Exam.new({})
      .instance_variables
      .each_with_object({})
      .with_index do |(var, hash), index|
        hash.send :store, var.to_s.delete('@'), params[incoming_vars[index]]
    end
  end
end