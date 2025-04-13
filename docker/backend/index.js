const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const app = express();

// Allow CORS
app.use(cors());
app.use(express.json());

// Use env vars for DB config
const db = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
    port: 3306,
});

// Connect to MySQL
db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL:', err.message);
        return;
    }
    console.log('✅ Connected to MySQL');
});

// POST /save-score
app.post('/save-score', (req, res) => {
    const { name, difficulty, score } = req.body;
    if (name.length !== 3 || difficulty < 1 || difficulty > 3) {
        return res.status(400).json({ message: "Invalid input" });
    }
    const calculatedScore = difficulty * score;
    db.query(`INSERT INTO scores (name, difficulty, score) VALUES (?, ?, ?)`,
        [name, difficulty, calculatedScore],
        (err) => {
            if (err) {
                return res.status(500).json({ message: "Error saving score" });
            }
            res.status(200).json({ message: "Score saved successfully!" });
        });
});

// GET /top-scores
app.get('/top-scores', (req, res) => {
    db.query(`SELECT name, difficulty, score FROM scores ORDER BY score DESC LIMIT 10`, (err, results) => {
        if (err) {
            return res.status(500).json({ message: "Error retrieving scores" });
        }
        res.status(200).json(results);
    });
});

// Server start
const port = process.env.PORT || 5000;
app.listen(port, () => {
    console.log(`🚀 Server running on http://localhost:${port}`);
});

