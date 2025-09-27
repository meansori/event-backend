// File: backend/models/Admin.js
const pool = require("../config/database");

class Admin {
  static async findByEmail(email) {
    const [rows] = await pool.execute("SELECT * FROM admins WHERE email = ?", [email]);
    return rows[0];
  }

  static async create(adminData) {
    const { name, email, password, organization_name } = adminData;
    const [result] = await pool.execute(
      "INSERT INTO admins (name, email, password, organization_name) VALUES (?, ?, ?, ?)",
      [name, email, password, organization_name]
    );
    return result.insertId;
  }

  static async findById(id) {
    const [rows] = await pool.execute(
      "SELECT id, name, email, organization_name, created_at FROM admins WHERE id = ?",
      [id]
    );
    return rows[0];
  }
}

module.exports = Admin;
