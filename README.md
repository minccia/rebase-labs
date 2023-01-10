# Rebase Labs

Uma aplicação web para listagem de exames médicos, criada para fins didáticos explorando tecnologias como o framework Sinatra, Docker e Fetch API Javascript

### Requisitos

Para rodar este projeto, é necessário que você possua o Docker instalado na máquina que será utilizada. Caso ainda não possua, você pode seguir as instruções da documentação oficial para fazer a instalação:

[Docker-Desktop](https://www.docker.com/products/docker-desktop/)

![Screenshot from 2023-01-05 14-34-42](https://user-images.githubusercontent.com/85851976/210844376-f4b1f662-4172-4345-8763-39fef184af3b.png)

### Instalação

1. No seu terminal, clone o repositório do projeto com o comando:

       git clone git@github.com:minccia/rebase-labs.git
       
2. Em seguida, rode o seguinte comando para instalar as dependências listadas no Gemfile:

       docker-compose run app 

### Rodando o projeto 

1. Primeiro suba o servidor do banco de dados (POSTGRESQL) com o comando

       bin/postgres
       
2. Em outro terminal, popule o banco de dados com registros através de um arquivo .csv localizado na raiz do projeto com o comando:

       docker-compose run app ruby import_from_csv.rb
       
3. Suba o servidor Redis com o comando:

       bin/redis
       
4. Suba o servidor Sidekiq com o comando: 

       bin/sidekiq
       
3. Suba o servidor sinatra com o comando:

       bin/sinatra 
       
4. Agora você poderá acessar a aplicação através do seu navegador no seguinte endereço:

       http://localhost:3000/

### Suite de testes 

Neste projeto, utilizamos o Rspec como ferramenta de testes automatizados. Para rodar os testes deste projeto:

1. Suba o banco de dados destinado a testes com o comando:

       bin/test-postgres
      
2. Rode os testes automatizados com o comando:

       docker-compose run app rspec

### Endpoints

#### GET /tests 

Este endpoint irá listar todos os exames registrados no banco de dados formatados em uma tabela simples, como na imagem abaixo:

![Screenshot from 2023-01-05 14-23-10](https://user-images.githubusercontent.com/85851976/210842554-227c30fc-ab46-44c6-9fdc-69de9b6c82ff.png)

#### GET /api/v1/exams

Este endpoint irá listar todos os exames do banco de dados em formato JSON, conforme o modelo abaixo:

```json

{ 
  "registration_number": "000.000.000-00", 
  "patient_name": "Fulana Ciclana de Beltrana",
  "patient_email": "fulana@email.com",
  "patient_birth_date": "YYYY-MM-DD",
  "patient_address": "Rua Inexistente, Número 00",
  "patient_city": "Cidade",
  "patient_state": "Estado",
  "doctor_council_rn": "00000000",
  "doctor_council_state": "ST",
  "doctor_name": "Dra. Fulana Ciclana de Beltrana",
  "doctor_email": "drafulana@email.com",
  "exam_token": "00000000",
  "exam_date": "YYYY-MM-DD",
  "exam_type": "Tipo de exame",
  "exam_values": "000-999",
  "exam_result": "00" 
}
```

#### POST /api/v1/import_csv

Por meio deste endpoint é possível enviar um arquivo `.csv` no body da requisição e os seus dados serão importados para o banco de dados do servidor

A primeira linha do documento deve possuir os seguintes cabeçalhos separados por ponto e vírgula:

`cpf;nome paciente;email paciente;data nascimento paciente;endereço/rua paciente;cidade paciente;estado patiente;crm médico;crm médico estado;nome médico;email médico;token resultado exame;data exame;tipo exame;limites tipo exame;resultado tipo exame`

E os dados correspondentes nas linhas seguintes: 

`000.000.000-00;Fulana Ciclana de Beltrana;fulanaciclana@email.com;0000-00-00;000 Rua Ines;AlgumaCidade;AlgumEstado;0000000000;AA;Fulana Ciclana de Beltrana;fulanaciclana@email.com;AAAA00;0000-00-00;TipoExame;00-00;00`

##### Especificações 

- **Todos** os campos são obrigatórios.
- `cpf` deve possuir 14 caracteres, incluindo `.` e `-`
- `nome paciente` deve possuir até 100 caracteres
- `email paciente` deve possuir até 100 caracteres 
- `data nascimento paciente` deve estar no formato `YYYY-MM-DD`
- `endereço/rua paciente` deve possuir até 100 caracteres
- `cidade paciente` deve possuir até 50 caracteres
- `estado patiente` deve possuir até 50 caracteres
- `crm médico` deve possuir até 10 caracteres 
- `crm médico estado` deve possuir 2 caracteres que representem a sigla do estado. Exemplo (Ceará: CE)
- `nome médico` deve possuir até 100 caracteres
- `email médico` deve possuir até 100 caracteres
- `token resultado exame` deve possuir até 10 caracteres
- `data exame` deve estar no formato `YYYY-MM-DD`
- `tipo exame` deve possuir até 50 caracteres
- `limites tipo exame` deve possuir até 10 caracteres
- `resultado tipo exame` deve ser um valor do tipo `INTEGER`
