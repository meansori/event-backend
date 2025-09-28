const QRCode = require("qrcode");
const crypto = require("crypto");

class QRGenerator {
  // Generate QR code untuk event
  static async generateEventQR(eventId, eventTitle) {
    try {
      const secret = crypto.randomBytes(32).toString("hex");
      const qrData = {
        event_id: eventId,
        event_title: eventTitle,
        secret: secret,
        timestamp: Date.now(),
        type: "event_attendance",
        version: "1.0",
      };

      const qrString = JSON.stringify(qrData);
      const qrImage = await QRCode.toDataURL(qrString, {
        width: 400,
        margin: 2,
        color: {
          dark: "#000000",
          light: "#FFFFFF",
        },
      });

      return {
        image: qrImage,
        data: qrString,
        secret: secret,
      };
    } catch (error) {
      throw new Error("QR generation failed: " + error.message);
    }
  }

  // Validate QR code
  static validateQRData(qrString, expectedEventId = null) {
    try {
      const qrData = JSON.parse(qrString);

      // Basic validation
      if (!qrData.event_id || !qrData.secret || qrData.type !== "event_attendance") {
        return { valid: false, error: "Invalid QR code format" };
      }

      // Event ID validation jika provided
      if (expectedEventId && qrData.event_id != expectedEventId) {
        return { valid: false, error: "QR code not for this event" };
      }

      // Optional: Check expiry (24 jam)
      const now = Date.now();
      const qrTime = qrData.timestamp;
      if (now - qrTime > 24 * 60 * 60 * 1000) {
        return { valid: false, error: "QR code expired" };
      }

      return { valid: true, data: qrData };
    } catch (error) {
      return { valid: false, error: "Invalid QR data" };
    }
  }
}

module.exports = QRGenerator;
