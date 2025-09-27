// File: backend/routes/attendanceRoutes.js
const express = require("express");
const attendanceController = require("../controllers/attendanceController");
const authMiddleware = require("../middleware/authMiddleware");

const router = express.Router();

router.use(authMiddleware);

// Participant management
router.post("/participants", attendanceController.addParticipant);
router.get("/participants", attendanceController.getParticipants);
router.get("/participants/search", attendanceController.searchParticipants);

// Event participation
router.post("/events/participants", attendanceController.addParticipantToEvent);
router.get("/events/:event_id/participants", attendanceController.getEventParticipants);

// Attendance recording
router.post("/record", attendanceController.recordAttendance);
router.post("/record/bulk", attendanceController.recordBulkAttendance);

// Reports
router.get("/report/:event_id", attendanceController.getAttendanceReport);

module.exports = router;
