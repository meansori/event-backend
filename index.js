// File: backend/index.js
const express = require("express");
const cors = require("cors");
require("dotenv").config();

const routes = require("./routes");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use("/api/v1", routes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
