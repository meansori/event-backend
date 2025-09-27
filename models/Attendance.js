// File: backend/models/Attendance.js
const pool = require("../config/database");

class Attendance {
  static async recordAttendance(attendanceData) {
    const { event_id, participant_id, status, notes } = attendanceData;

    // First, check if participant is registered for the event
    const [check] = await pool.execute("SELECT * FROM event_participants WHERE event_id = ? AND participant_id = ?", [
      event_id,
      participant_id,
    ]);

    if (check.length === 0) {
      throw new Error("Participant is not registered for this event");
    }

    const [result] = await pool.execute(
      `INSERT INTO attendance (event_id, participant_id, status, notes) 
             VALUES (?, ?, ?, ?) 
             ON DUPLICATE KEY UPDATE status=?, notes=?, attendance_time=CURRENT_TIMESTAMP`,
      [event_id, participant_id, status, notes, status, notes]
    );
    return result;
  }

  static async getEventAttendance(eventId) {
    const [rows] = await pool.execute(
      `SELECT p.id, p.name, p.email, p.phone, p.institution, 
                    a.status, a.attendance_time, a.notes
             FROM attendance a
             JOIN participants p ON a.participant_id = p.id
             WHERE a.event_id = ?`,
      [eventId]
    );
    return rows;
  }

  static async getAttendanceStats(eventId) {
    const [rows] = await pool.execute(
      `SELECT status, COUNT(*) as count 
             FROM attendance 
             WHERE event_id = ? 
             GROUP BY status`,
      [eventId]
    );
    return rows;
  }

  // Bulk attendance recording
  static async recordBulkAttendance(eventId, attendanceRecords) {
    const connection = await pool.getConnection();

    try {
      await connection.beginTransaction();

      for (const record of attendanceRecords) {
        const { participant_id, status, notes } = record;

        await connection.execute(
          `INSERT INTO attendance (event_id, participant_id, status, notes) 
                     VALUES (?, ?, ?, ?) 
                     ON DUPLICATE KEY UPDATE status=?, notes=?, attendance_time=CURRENT_TIMESTAMP`,
          [eventId, participant_id, status, notes, status, notes]
        );
      }

      await connection.commit();
      return { success: true, message: "Bulk attendance recorded successfully" };
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  }
}

module.exports = Attendance;
