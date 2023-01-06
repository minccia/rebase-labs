const api_url = 'http://localhost:3000/api/v1/exams';
const fragment = new DocumentFragment();

function createTableData(textContent) {
  const tableData = document.createElement('td')
  tableData.textContent = `${textContent}`
  return tableData
};

fetch(api_url)
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

const fileInput = document.getElementById('file-input');
const importButton = document.getElementById('submit-button');

async function readCSV(file) {
  return new Promise((resolve, reject) => {
    const reader = new FileReader();
    reader.onload = event => {
      const csv = event.target.result;
      resolve(csv);
    };
    reader.onerror = reject;
    reader.readAsText(file);
  });
};

importButton.addEventListener('click', async () => {
  const file = fileInput.files[0];
  const csv = await readCSV(file);
  const response = await fetch('http://localhost:3000/import', {
    method: 'POST',
    headers: {
      'Content-Type': 'text/csv',
    },
    body: csv,
  });

  if (response.ok) {
    console.log('Success');
  } else {
    console.error('Error');
  }
});