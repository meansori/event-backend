// File: backend/routes/index.js
const express = require("express");
const authRoutes = require("./authRoutes");
const eventRoutes = require("./eventRoutes");
const attendanceRoutes = require("./attendanceRoutes");

const router = express.Router();
// Health check
router.use("/health", (req, res) => {
  res.json({ message: "Server is running!" });
});

router.use("/auth", authRoutes);
router.use("/events", eventRoutes);
router.use("/attendance", attendanceRoutes);

module.exports = router;
