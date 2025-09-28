// File: backend/models/Event.js
const pool = require("../config/database");
const QRCode = require("qrcode");
const crypto = require("crypto");

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

  // Generate QR Code untuk event
  static async generateEventQRCode(eventId) {
    try {
      // Generate secret unik untuk QR code
      const qrSecret = crypto.randomBytes(32).toString("hex");
      const qrData = JSON.stringify({
        event_id: eventId,
        secret: qrSecret,
        timestamp: Date.now(),
        type: "event_attendance",
      });

      // Generate QR code image
      const qrCodeImage = await QRCode.toDataURL(qrData);

      // Simpan ke database
      const [result] = await pool.execute("UPDATE events SET qr_code = ?, qr_secret = ? WHERE id = ?", [
        qrCodeImage,
        qrSecret,
        eventId,
      ]);

      return {
        qr_code: qrCodeImage,
        qr_secret: qrSecret,
        qr_data: qrData,
      };
    } catch (error) {
      throw new Error("Failed to generate QR code: " + error.message);
    }
  }

  // Verify QR code
  static async verifyQRCode(qrData, eventId) {
    try {
      const parsedData = JSON.parse(qrData);

      const [events] = await pool.execute("SELECT qr_secret FROM events WHERE id = ?", [eventId]);

      if (events.length === 0) {
        return { valid: false, error: "Event not found" };
      }

      const event = events[0];

      // Check if QR code is valid and not expired (optional: add expiry check)
      const isValid =
        parsedData.secret === event.qr_secret &&
        parsedData.event_id == eventId &&
        parsedData.type === "event_attendance";

      return {
        valid: isValid,
        error: isValid ? null : "Invalid QR code",
      };
    } catch (error) {
      return { valid: false, error: "Invalid QR data format" };
    }
  }
}

module.exports = Event;
