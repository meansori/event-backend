// File: backend/controllers/authController.js
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const Admin = require("../models/Admin");

const authController = {
  async register(req, res) {
    try {
      const { name, email, password, organization_name } = req.body;

      // Check if admin exists
      const existingAdmin = await Admin.findByEmail(email);
      if (existingAdmin) {
        return res.status(400).json({ error: "Admin already exists" });
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 10);

      // Create admin
      const adminId = await Admin.create({
        name,
        email,
        password: hashedPassword,
        organization_name,
      });

      const admin = await Admin.findById(adminId);
      const token = jwt.sign({ id: admin.id }, process.env.JWT_SECRET || "your-secret-key", { expiresIn: "24h" });

      res.status(201).json({
        message: "Admin registered successfully",
        admin: {
          id: admin.id,
          name: admin.name,
          email: admin.email,
          organization_name: admin.organization_name,
        },
        token,
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  async login(req, res) {
    try {
      const { email, password } = req.body;

      // Find admin
      const admin = await Admin.findByEmail(email);
      if (!admin) {
        return res.status(400).json({ error: "Invalid credentials" });
      }

      // Check password
      const validPassword = await bcrypt.compare(password, admin.password);
      if (!validPassword) {
        return res.status(400).json({ error: "Invalid credentials" });
      }

      // Generate token
      const token = jwt.sign({ id: admin.id }, process.env.JWT_SECRET || "your-secret-key", { expiresIn: "24h" });

      res.json({
        message: "Login successful",
        admin: {
          id: admin.id,
          name: admin.name,
          email: admin.email,
          organization_name: admin.organization_name,
        },
        token,
      });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = authController;
