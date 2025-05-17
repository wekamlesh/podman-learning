const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
const GREETING = process.env.GREETING || "Hello World";
const TARGET = process.env.TARGET || "Podman Users";

app.get('/', (req, res) => {
    res.send(`${GREETING} ${TARGET} - Day 2 Image Management`);
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});