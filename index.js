const express = require('express');
const app = express();
const PORT = 3000;

// Sample data
const students = [
  { name: "John Doe", program: "Software Engineering" },
  { name: "Jane Smith", program: "Software Engineering" },
  { name: "Michael Otieno", program: "Software Engineering" },
  { name: "Anna Paul", program: "Software Engineering" },
  { name: "Chris Njoroge", program: "Software Engineering" },
  { name: "Linda Kim", program: "Software Engineering" },
  { name: "James Mushi", program: "Software Engineering" },
  { name: "Amina Said", program: "Software Engineering" },
  { name: "Kelvin Mwangi", program: "Software Engineering" },
  { name: "Fatma Salim", program: "Software Engineering" }
];

const subjects = {
  "Year 1": ["Introduction to Programming", "Mathematics I", "Computer Fundamentals"],
  "Year 2": ["Data Structures", "Databases", "Object-Oriented Programming"],
  "Year 3": ["Software Engineering Principles", "Operating Systems", "Web Development"],
  "Year 4": ["Project Management", "Mobile App Development", "Final Year Project"]
};

// Routes
app.get('/students', (req, res) => {
  res.json(students);
});

app.get('/subjects', (req, res) => {
  res.json(subjects);
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
