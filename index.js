// File: backend/index.js
const express = require("express");
const cors = require("cors");
require("dotenv").config();

const routes = require("./routes");

const app = express();
const PORT = process.env.PORT || 4001;
const NODE_ENV = process.env.NODE_ENV || "development";

// Middleware
app.use(cors());
// CORS configuration untuk production
app.use(
  cors({
    origin: process.env.NODE_ENV === "production" ? ["http://31.97.109.215", "http://localhost:3000"] : "http://localhost:3000",
    credentials: true,
  })
);

app.use(express.json());

// Routes
app.use("/api/v1", routes);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
