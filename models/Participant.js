// File: backend/models/Participant.js
const pool = require("../config/database");

class Participant {
  // Create participant (now independent of event)
  static async create(participantData) {
    const { admin_id, name, email, phone, institution } = participantData;
    const [result] = await pool.execute(
      `INSERT INTO participants (admin_id, name, email, phone, institution) 
             VALUES (?, ?, ?, ?, ?)`,
      [admin_id, name, email, phone, institution]
    );
    return result.insertId;
  }

  // Add participant to event
  static async addToEvent(eventId, participantId) {
    const [result] = await pool.execute(
      `INSERT INTO event_participants (event_id, participant_id) 
             VALUES (?, ?)`,
      [eventId, participantId]
    );
    return result.insertId;
  }

  // Get participants by event
  static async findByEvent(eventId) {
    const [rows] = await pool.query(
      `SELECT p.*, ep.registered_at, a.status as attendance_status, a.attendance_time 
             FROM participants p
             JOIN event_participants ep ON p.id = ep.participant_id
             LEFT JOIN attendance a ON p.id = a.participant_id AND a.event_id = ?
             WHERE ep.event_id = ?`,
      [eventId, eventId]
    );
    return rows;
  }
  static async findParticipant(participant_data) {
    const [rows] = await pool.execute(
      `SELECT *
             FROM participants 
             WHERE email = ?`,
      [participant_data]
    );
    return rows;
  }

  // Get participants by admin
  static async findByAdmin(adminId) {
    const [rows] = await pool.execute(`SELECT * FROM participants WHERE admin_id = ?`, [adminId]);
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute("SELECT * FROM participants WHERE id = ?", [id]);
    return rows[0];
  }

  // Search participants by name or email
  static async search(adminId, searchTerm) {
    const [rows] = await pool.execute(
      `SELECT * FROM participants 
             WHERE admin_id = ? AND (name LIKE ? OR email LIKE ?)`,
      [adminId, `%${searchTerm}%`, `%${searchTerm}%`]
    );
    return rows;
  }
}

module.exports = Participant;
