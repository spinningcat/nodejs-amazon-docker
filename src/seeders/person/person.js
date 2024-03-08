const { Client } = require('pg');
const fs = require('fs');

// Configure the PostgreSQL client
const client = new Client({
  user: 'postgres',
  host: '16.170.149.181',
  database: 'watch-data',
  password: 'watch-data',
  port: 5532,
});

// Connect to the PostgreSQL database
client.connect();

// SQL query
const query = `
  SELECT json_agg(json_build_object('id', id, 'detection_time', detection_time, 'confidence', confidence, 'label', label, 'camera_id', camera_id)) AS json_data
  FROM "Person"
`;

// Execute the query
client.query(query, (err, res) => {
  if (err) {
    console.error('Error executing query', err);
    client.end();
    return;
  }

  // Fetch the JSON result
  const result = res.rows[0].json_data;
  console.log(result);

  // Write the JSON data to a file
  fs.writeFile('output.json', JSON.stringify(result, null, 2), (err) => {
    if (err) {
      console.error('Error writing to file', err);
      client.end();
      return;
    }
    console.log('JSON data written to output.json');
    client.end();
  });
});