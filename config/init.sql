-- File: database/migration_fixed.sql

-- Hapus database lama jika ada
DROP DATABASE IF EXISTS community_attendance;
CREATE DATABASE community_attendance;
USE community_attendance;

-- Table for administrators
CREATE TABLE admins (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    organization_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table for events/activities
CREATE TABLE events (
    id INT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    location VARCHAR(200),
    max_participants INT,
    status ENUM('scheduled', 'ongoing', 'completed', 'cancelled') DEFAULT 'scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE
);

-- Table for community members/participants (DIUBAH: tidak terikat event)
CREATE TABLE participants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    admin_id INT NOT NULL,  -- Tambah admin_id untuk mengelompokkan participant per admin
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    institution VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES admins(id) ON DELETE CASCADE
);

-- Table untuk menghubungkan participant dengan event (MANY-to-MANY)
CREATE TABLE event_participants (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    participant_id INT NOT NULL,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES participants(id) ON DELETE CASCADE,
    UNIQUE KEY unique_event_participant (event_id, participant_id)
);

-- Table for attendance records (DIUBAH struktur)
CREATE TABLE attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    participant_id INT NOT NULL,
    attendance_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('present', 'absent', 'late') DEFAULT 'present',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (participant_id) REFERENCES participants(id) ON DELETE CASCADE,
    UNIQUE KEY unique_attendance (event_id, participant_id)
);

-- Insert sample admin (password: admin123)
INSERT INTO admins (name, email, password, organization_name) 
VALUES ('Admin Default', 'admin@community.com', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Community Organization');

-- Insert sample participants
INSERT INTO participants (admin_id, name, email, phone, institution) VALUES
(1, 'John Doe', 'john@email.com', '08123456789', 'University A'),
(1, 'Jane Smith', 'jane@email.com', '08123456780', 'University B'),
(1, 'Bob Wilson', 'bob@email.com', '08123456781', 'Company X');