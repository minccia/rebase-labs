const importCSVApiUrl = 'http://localhost:3000/api/v1/import_csv'

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
  const response = await fetch(importCSVApiUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'text/csv',
    },
    body: csv,
  });

  if (response.ok)
    console.log('Success');
  else 
    console.error('Error');
});