-- Insertar roles
INSERT INTO roles (name) VALUES
('root'),
('admin'),
('mant');

-- Insertar géneros
INSERT INTO genres (name) VALUES
('Rock'),
('Pop'),
('Jazz'),
('Classical'),
('Electronic');

-- Insertar idiomas
INSERT INTO languages (name) VALUES
('Español'),
('English'),
('Catalan');

-- Insertar administradores
INSERT INTO admin (name, mail, password, role_id) VALUES
('root', 'root@domain.com', 'rootpassword', 1),
('admin', 'admin@domain.com', 'adminpassword', 2),
('mant', 'mant@domain.com', 'mantpassword', 3);

-- Insertar aplicaciones (con latitud y longitud de Barcelona)
-- Un usuario es solo un 'Artist' o 'Space', no ambos
INSERT INTO app (name, mail, password, role, latitude, longitude, active, language_id) VALUES
('Artist1', 'artist1@domain.com', 'artist1password', 'Artist', 41.3784, 2.1914, 1, 1),
('Artist2', 'artist2@domain.com', 'artist2password', 'Artist', 41.3784, 2.1914, 1, 2),
('Space1', 'space1@domain.com', 'space1password', 'Space', 41.3784, 2.1914, 1, 3),
('Space2', 'space2@domain.com', 'space2password', 'Space', 41.3784, 2.1914, 1, 1);

-- Insertar archivos
INSERT INTO files (name, type, date, app_id) VALUES
('file1.jpg', 'image', '2025-03-27', 1),
('file2.mp3', 'audio', '2025-03-27', 2),
('file3.mp4', 'video', '2025-03-27', 3),
('file4.pdf', 'document', '2025-03-27', 4);

-- Insertar notificaciones
INSERT INTO notifications (content, date, app_id) VALUES
('Notification 1', '2025-03-27', 1),
('Notification 2', '2025-03-27', 2),
('Notification 3', '2025-03-27', 3),
('Notification 4', '2025-03-27', 4);

-- Insertar chats
-- Los chats son entre artistas y espacios
INSERT INTO chats (date, user1_id, user2_id) VALUES
('2025-03-27', 1, 3),
('2025-03-27', 1, 4),
('2025-03-27', 2, 3),
('2025-03-27', 2, 4);

-- Insertar mensajes
INSERT INTO messages (sender_id, content, send_at, is_read, chat_id) VALUES
(1, 'Hello Space1 from Artist1', '2025-03-27 10:00', 0, 1),
(3, 'Hello Artist1 from Space1', '2025-03-27 10:05', 0, 1),
(1, 'Hello Space2 from Artist1', '2025-03-27 10:10', 0, 2),
(4, 'Hello Artist1 from Space2', '2025-03-27 10:15', 0, 2),
(2, 'Hello Space1 from Artist2', '2025-03-27 10:20', 0, 3),
(3, 'Hello Artist2 from Space1', '2025-03-27 10:25', 0, 3),
(2, 'Hello Space2 from Artist2', '2025-03-27 10:30', 0, 4),
(4, 'Hello Artist2 from Space2', '2025-03-27 10:35', 0, 4);

-- Insertar ratings
-- Los ratings son entre artistas y espacios
INSERT INTO rating (rating, artist_id, space_id) VALUES
(5, 1, 3),
(4, 1, 4),
(4, 2, 3),
(3, 2, 4);

-- Insertar espacios (solo usuarios que son 'Space')
INSERT INTO spaces (app_user_id, capacity, zip_code) VALUES
(3, 50, '08002'),
(4, 100, '08003');

-- Insertar artistas (solo usuarios que son 'Artist')
INSERT INTO artists (app_user_id) VALUES
(1),
(2);

-- Insertar géneros de artistas
INSERT INTO artist_genres (artist_id, genre_id, creation_date) VALUES
(1, 1, '2025-03-27'),
(2, 2, '2025-03-27');

-- Insertar coincidencias
-- Las coincidencias son entre artistas y espacios
INSERT INTO matches (artist_id, space_id, match_date) VALUES
(1, 3, '2025-03-27'),
(1, 4, '2025-03-27'),
(2, 3, '2025-03-27'),
(2, 4, '2025-03-27');

-- Insertar coincidencias temporales
INSERT INTO temp_match (artist_id, space_id, artist_like, space_like, status, request_date) VALUES
(1, 3, 1, 1, 'accepted', '2025-03-27'),
(1, 4, 0, 1, 'pending', '2025-03-27'),
(2, 3, 1, 0, 'rejected', '2025-03-27'),
(2, 4, 1, 1, 'accepted', '2025-03-27');

-- Insertar contratos
INSERT INTO contracts (artist_id, space_id, meet_type, status, init_hour, end_hour) VALUES
(1, 3, 'meeting', 'todo', '2025-03-27 14:00', '2025-03-27 16:00'),
(1, 4, 'work', 'finished', '2025-03-27 10:00', '2025-03-27 12:00'),
(2, 3, 'meeting', 'todo', '2025-03-27 18:00', '2025-03-27 20:00'),
(2, 4, 'work', 'finished', '2025-03-27 16:00', '2025-03-27 18:00');

-- Insertar incidencias
-- Las incidencias pueden ser abiertas por el admin
INSERT INTO incidences (app_user_id, admin_user_id, description, status) VALUES
(1, 1, 'Issue with the app', 'open'),
(2, 2, 'Issue with the connection', 'in_progress'),
(3, 3, 'Issue with the user interface', 'closed'),
(4, 3, 'Problem with user access', 'open');
