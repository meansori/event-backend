// File: backend/models/Event.js
const pool = require("../config/database");

class Event {
  static async create(eventData) {
    const { admin_id, title, description, event_date, event_time, location, max_participants } = eventData;
    const [result] = await pool.execute(
      `INSERT INTO events (admin_id, title, description, event_date, event_time, location, max_participants) 
             VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [admin_id, title, description, event_date, event_time, location, max_participants]
    );
    return result.insertId;
  }

  static async findByAdmin(adminId) {
    const [rows] = await pool.execute(
      `SELECT * FROM events WHERE admin_id = ? ORDER BY event_date DESC, event_time DESC`,
      [adminId]
    );
    return rows;
  }

  static async findById(id) {
    const [rows] = await pool.execute("SELECT * FROM events WHERE id = ?", [id]);
    return rows[0];
  }

  static async update(id, eventData) {
    const { title, description, event_date, event_time, location, max_participants, status } = eventData;
    const [result] = await pool.execute(
      `UPDATE events SET title=?, description=?, event_date=?, event_time=?, location=?, max_participants=?, status=?
             WHERE id=?`,
      [title, description, event_date, event_time, location, max_participants, status, id]
    );
    return result.affectedRows;
  }

  static async delete(id) {
    const [result] = await pool.execute("DELETE FROM events WHERE id = ?", [id]);
    return result.affectedRows;
  }
}

module.exports = Event;
