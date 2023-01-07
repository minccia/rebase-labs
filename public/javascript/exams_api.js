const examsAPIUrl = 'http://localhost:3000/api/v1/exams';
const fragment = new DocumentFragment();

function createTableData(textContent) {
  const tableData = document.createElement('td')
  tableData.textContent = `${textContent}`
  return tableData
};

fetch(examsAPIUrl)
  .then((response) => response.json())
  .then((data) => {
    data.forEach(function(object) {
      const tableRow = document.createElement('tr');

      const registrationNumber = createTableData(object.registration_number);
      const name = createTableData(object.patient_name);
      const responsibleDoctor = createTableData(object.doctor_name);
      const examType = createTableData(object.exam_type);
      const examValues = createTableData(object.exam_values);
      const examResult = createTableData(object.exam_result);
      
      tableRow.appendChild(registrationNumber);
      tableRow.appendChild(name);
      tableRow.appendChild(responsibleDoctor);
      tableRow.appendChild(examType);
      tableRow.appendChild(examValues);
      tableRow.appendChild(examResult);
      fragment.appendChild(tableRow);
    })
  }).then(() => {
    document.querySelector('#table-body').appendChild(fragment);
  }).catch(function(error) {
      console.log(error)
  }
);