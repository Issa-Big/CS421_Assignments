const express = require('express');
const mysql = require('mysql');
const app = express();
const PORT = 3000;

// MySQL connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',        // or your mysql user if changed
  password: '123456',        // or your mysql password if set
  database: 'CS421_API'
});

// Connect to MySQL
db.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
    return;
  }
  console.log('Connected to MySQL database.');
});

// Endpoint to get students
app.get('/students', (req, res) => {
  const query = 'SELECT name, program FROM students';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching students:', err);
      res.status(500).send('Server error');
    } else {
      res.json(results);
    }
  });
});

// Endpoint to get subjects
app.get('/subjects', (req, res) => {
  const query = 'SELECT year, subject FROM subjects';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error fetching subjects:', err);
      res.status(500).send('Server error');
    } else {
      // Group subjects by year
      const groupedSubjects = {};

      results.forEach((row) => {
        const yearLabel = `Year ${row.year}`;
        if (!groupedSubjects[yearLabel]) {
          groupedSubjects[yearLabel] = [];
        }
        groupedSubjects[yearLabel].push(row.subject);
      });

      res.json(groupedSubjects);
    }
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
