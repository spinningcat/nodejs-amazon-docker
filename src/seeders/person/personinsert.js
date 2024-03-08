const { Client } = require('pg');
const fs = require('fs');

// Configure the PostgreSQL client
const client = new Client({
  user: 'postgres',
  host: 'localhost',
  database: 'camproject',
  password: '1234',
  port: 5432,
});

// Connect to the PostgreSQL database
client.connect();

// Read JSON data from file
const jsonData = JSON.parse(fs.readFileSync('output.json', 'utf-8'));

// Define function to insert JSON object
async function insertData(data) {
    try {
      // SQL query to insert JSON data into the table
      const query = `
        INSERT INTO "Person" (detection_time, confidence, label, camera_id)
        VALUES ($1, $2, $3, $4)
      `;
      // Extract necessary fields from the JSON object
      const { detection_time, confidence, label, camera_id } = data;
      // Execute the query
      await client.query(query, [detection_time, confidence, label, camera_id]);
      console.log('JSON data inserted successfully');
    } catch (err) {
      console.error('Error inserting JSON data', err);
    }
  }

// Loop through each JSON object and insert into the table sequentially
async function insertAllData() {
  for (const data of jsonData) {
    await insertData(data);
  }
  // Close the database connection after all data has been inserted
  client.end();
}

// Call the function to start inserting data
insertAllData();