// File: backend/controllers/attendanceController.js
const Participant = require("../models/Participant");
const Attendance = require("../models/Attendance");
const Event = require("../models/Event");

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

  // QR Code Attendance - Step 1: Generate QR untuk event
  async generateEventQR(req, res) {
    try {
      const { event_id } = req.body;

      if (!event_id) {
        return res.status(400).json({
          success: false,
          message: "Event ID is required",
        });
      }

      // Check if user owns the event
      const event = await Event.findById(event_id);
      if (!event || event.admin_id !== req.admin.id) {
        return res.status(404).json({
          success: false,
          message: "Event not found or access denied",
        });
      }

      const qrData = await Event.generateEventQRCode(event_id);

      res.json({
        success: true,
        message: "QR code generated successfully",
        data: qrData,
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: error.message,
      });
    }
  },

  // QR Code Attendance - Step 2: Process QR attendance
  async processQRAttendance(req, res) {
    try {
      const { qr_data, participant_data } = req.body;

      if (!qr_data || !participant_data) {
        return res.status(400).json({
          success: false,
          message: "QR data and participant data are required",
        });
      }

      // Verify QR code
      const parsedQR = JSON.parse(qr_data);
      const qrVerification = await Event.verifyQRCode(qr_data, parsedQR.event_id);

      if (!qrVerification.valid) {
        return res.status(400).json({
          success: false,
          message: qrVerification.error,
        });
      }

      const eventId = parsedQR.event_id;
      // Cari peserta berdasarkan data yang diinput (email/phone/name)
      const participant = await Participant.findParticipant(participant_data.email);
      const participantId = participant[0].id;
      if (!participantId) {
        return res.status(404).json({
          success: false,
          message: "Participant not found for this event",
        });
      }

      // Check if already attended
      const existingAttendance = await Attendance.getDataParticipant(eventId, participantId);

      if (existingAttendance > 0) {
        return res.status(409).json({
          success: false,
          message: "Participant already attended this event",
          data: {
            attendance_time: existingAttendance[0].attendance_time,
            status: existingAttendance[0].status,
          },
        });
      }

      // Record attendance
      const attendanceData = {
        event_id: eventId,
        participant_id: participantId,
        status: "present",
        attendance_method: "qr_code",
        qr_data: qr_data,
        notes: "QR code attendance",
      };

      const attendanceRecord = await Attendance.recordAttendance(attendanceData);

      res.json({
        success: true,
        message: "Attendance recorded successfully via QR code",
        data: {
          attendance_id: attendanceRecord.id,
          participant_name: participant.name,
          event_title: (await Event.findById(eventId)).title,
          attendance_time: attendanceRecord.attendance_time,
          method: "qr_code",
        },
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: error.message,
      });
    }
  },

  // Public QR Attendance API (untuk peserta tanpa login)
  async publicQRAttendance(req, res) {
    try {
      const { qr_data, name, email, phone } = req.body;

      if (!qr_data || !name) {
        return res.status(400).json({
          success: false,
          message: "QR data and name are required",
        });
      }

      // Verify QR code
      const parsedQR = JSON.parse(qr_data);
      const qrVerification = await Event.verifyQRCode(qr_data, parsedQR.event_id);

      if (!qrVerification.valid) {
        return res.status(400).json({
          success: false,
          message: "Invalid QR code",
        });
      }

      const eventId = parsedQR.event_id;
      const event = await Event.findById(eventId);

      if (!event) {
        return res.status(404).json({
          success: false,
          message: "Event not found",
        });
      }

      // Cari peserta berdasarkan kombinasi data
      const participant = await Participant.findParticipant(email);
      const participantId = participant[0].id;
      if (!participantId) {
        return res.status(404).json({
          success: false,
          message: "Participant not registered for this event. Please contact organizer.",
        });
      }

      // Check existing attendance
      const existingAttendance = await Attendance.getDataParticipant(eventId, participantId);

      if (existingAttendance > 0) {
        return res.status(409).json({
          success: false,
          message: "You have already attended this event",
          data: {
            attendance_time: existingAttendance.attendance_time,
          },
        });
      }

      // Record attendance
      const attendanceData = {
        event_id: eventId,
        participant_id: participantId,
        status: "present",
        attendance_method: "qr_code",
        qr_data: qr_data,
      };

      const attendanceRecord = await Attendance.recordAttendance(attendanceData);

      res.json({
        success: true,
        message: "Attendance recorded successfully!",
        data: {
          participant_name: participant.name,
          event_title: event.title,
          attendance_time: attendanceRecord.attendance_time,
        },
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: error.message,
      });
    }
  },

  // Get QR code for event
  async getEventQR(req, res) {
    try {
      const { event_id } = req.params;

      const event = await Event.findById(event_id);
      if (!event || event.admin_id !== req.admin.id) {
        return res.status(404).json({
          success: false,
          message: "Event not found or access denied",
        });
      }

      // Generate QR code jika belum ada
      if (!event.qr_code) {
        const qrData = await Event.generateEventQRCode(event_id);
        event.qr_code = qrData.qr_code;
      }

      res.json({
        success: true,
        data: {
          qr_code: event.qr_code,
          event_id: event.id,
          event_title: event.title,
        },
      });
    } catch (error) {
      res.status(500).json({
        success: false,
        message: error.message,
      });
    }
  },
};

module.exports = attendanceController;
