// File: backend/controllers/attendanceController.js
const Participant = require("../models/Participant");
const Attendance = require("../models/Attendance");

const attendanceController = {
  // Add new participant (independent of event)
  async addParticipant(req, res) {
    try {
      const { name, email, phone, institution } = req.body;

      const participantId = await Participant.create({
        admin_id: req.admin.id,
        name,
        email,
        phone,
        institution,
      });

      const participant = await Participant.findById(participantId);
      res.status(201).json({ message: "Participant added successfully", participant });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Add existing participant to event
  async addParticipantToEvent(req, res) {
    try {
      const { event_id, participant_id } = req.body;

      const registrationId = await Participant.addToEvent(event_id, participant_id);

      res.status(201).json({
        message: "Participant added to event successfully",
        registration_id: registrationId,
      });
    } catch (error) {
      if (error.code === "ER_DUP_ENTRY") {
        return res.status(400).json({ error: "Participant already registered for this event" });
      }
      res.status(500).json({ error: error.message });
    }
  },

  // Record attendance for a participant
  async recordAttendance(req, res) {
    try {
      const { event_id, participant_id, status, notes } = req.body;

      await Attendance.recordAttendance({
        event_id: parseInt(event_id),
        participant_id: parseInt(participant_id),
        status,
        notes,
      });

      res.json({ message: "Attendance recorded successfully" });
    } catch (error) {
      if (error.message.includes("not registered")) {
        return res.status(400).json({ error: error.message });
      }
      res.status(500).json({ error: error.message });
    }
  },

  // Record bulk attendance
  async recordBulkAttendance(req, res) {
    try {
      const { event_id, attendance_records } = req.body;

      const result = await Attendance.recordBulkAttendance(parseInt(event_id), attendance_records);

      res.json({ message: "Bulk attendance recorded successfully", result });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Get participants for an event
  async getEventParticipants(req, res) {
    try {
      const { event_id } = req.params;
      const participants = await Participant.findByEvent(parseInt(event_id));

      res.json({ participants });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Get all participants for admin
  async getParticipants(req, res) {
    try {
      const participants = await Participant.findByAdmin(req.admin.id);
      res.json({ participants });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Search participants
  async searchParticipants(req, res) {
    try {
      const { search } = req.query;
      const participants = await Participant.search(req.admin.id, search);
      res.json({ participants });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Get attendance report
  async getAttendanceReport(req, res) {
    try {
      const { event_id } = req.params;
      const attendance = await Attendance.getEventAttendance(parseInt(event_id));
      const stats = await Attendance.getAttendanceStats(parseInt(event_id));

      res.json({ attendance, stats });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = attendanceController;
