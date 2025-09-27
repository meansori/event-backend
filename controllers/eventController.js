// File: backend/controllers/eventController.js
const Event = require("../models/Event");
const Participant = require("../models/Participant");
const Attendance = require("../models/Attendance");

const eventController = {
  async createEvent(req, res) {
    try {
      const { title, description, event_date, event_time, location, max_participants } = req.body;

      const eventId = await Event.create({
        admin_id: req.admin.id,
        title,
        description,
        event_date,
        event_time,
        location,
        max_participants,
      });

      const event = await Event.findById(eventId);
      res.status(201).json({ message: "Event created successfully", event });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async getEvents(req, res) {
    try {
      const events = await Event.findByAdmin(req.admin.id);
      res.json({ events });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async updateEvent(req, res) {
    try {
      const { id } = req.params;
      const eventData = req.body;

      const affectedRows = await Event.update(id, eventData);
      if (affectedRows === 0) {
        return res.status(404).json({ error: "Event not found" });
      }

      const event = await Event.findById(id);
      res.json({ message: "Event updated successfully", event });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async deleteEvent(req, res) {
    try {
      const { id } = req.params;

      const affectedRows = await Event.delete(id);
      if (affectedRows === 0) {
        return res.status(404).json({ error: "Event not found" });
      }

      res.json({ message: "Event deleted successfully" });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async getEventDetails(req, res) {
    try {
      const { id } = req.params;
      const event = await Event.findById(id);

      if (!event) {
        return res.status(404).json({ error: "Event not found" });
      }

      const participants = await Participant.findByEvent(id);
      const attendanceStats = await Attendance.getAttendanceStats(id);

      res.json({ event, participants, attendanceStats });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = eventController;
