-- Insertar roles
INSERT INTO roles (name) VALUES ('root'), ('admin'), ('mant');

-- Insertar géneros musicales
INSERT INTO genres (name) VALUES ('Rock'), ('Pop'), ('Jazz'), ('Hip-Hop'), ('Clásica');

-- Insertar idiomas
INSERT INTO languages (name) VALUES ('Español'), ('Inglés'), ('Francés'), ('Alemán'), ('Italiano');

-- Insertar archivos
INSERT INTO files (name, type, date) VALUES
('imagen1.jpg', 'image', '2024-03-01'),
('video1.mp4', 'video', '2024-03-02'),
('audio1.mp3', 'audio', '2024-03-03'),
('documento1.pdf', 'document', '2024-03-04');

-- Insertar notificaciones
INSERT INTO notifications (content, date) VALUES
('Nueva actualización disponible', '2024-03-01'),
('Mantenimiento programado', '2024-03-02');

-- Insertar administradores
INSERT INTO admin (name, mail, password, role_id) VALUES
('root', 'root@example.com', 'root', 1),
('admin', 'admin@example.com', 'admin', 2),
('mant', 'mant@example.com', 'mant', 3);

-- Insertar actividades
INSERT INTO activity (name, type, description, date, admin_user_id) VALUES
('Evento1', 'event', 'Descripción del evento 1', '2024-03-10', 1),
('Tarea1', 'task', 'Descripción de la tarea 1', '2024-03-11', 2);

-- Insertar usuarios en App (Artistas y Espacios con ubicaciones en Barcelona, España)
INSERT INTO app (name, mail, password, role, rating, latitude, longitude, active, language_id, file_id, notification_id) VALUES
('Artista1', 'artista1@example.com', 'pass123', 'artist', 5, 41.3851, 2.1734, 1, 1, 1, 1),
('Espacio1', 'espacio1@example.com', 'pass123', 'space', 4, 41.3870, 2.1701, 1, 2, 2, 2),
('Artista2', 'artista2@example.com', 'pass123', 'artist', 3, 41.3800, 2.1760, 1, 3, 3, NULL),
('Espacio2', 'espacio2@example.com', 'pass123', 'space', 5, 41.3900, 2.1750, 1, 4, 4, NULL);

-- Insertar chats
INSERT INTO chats (date, user1_id, user2_id) VALUES
('2024-03-05', 1, 2),
('2024-03-06', 3, 4);

-- Insertar mensajes
INSERT INTO messages (sender_id, content, send_at, is_read, chat_id) VALUES
(1, 'Hola, ¿cómo estás?', '2024-03-05 10:00:00', 1, 1),
(2, 'Bien, gracias.', '2024-03-05 10:05:00', 1, 1);

-- Insertar ratings
INSERT INTO rating (rating, artist_id, space_id) VALUES
(5, 1, NULL),
(4, NULL, 2);

-- Insertar espacios
INSERT INTO spaces (app_user_id, capacity, zip_code) VALUES
(2, 100, '08001'),
(4, 200, '08002');

-- Insertar artistas
INSERT INTO artists (app_user_id) VALUES (1), (3);

-- Insertar géneros de artistas
INSERT INTO artist_genres (artist_id, genre_id, creation_date) VALUES
(1, 1, '2024-03-01'),
(3, 2, '2024-03-02');

-- Insertar coincidencias (matches)
INSERT INTO matches (artist_id, space_id, match_date) VALUES
(1, 2, '2024-03-07'),
(3, 4, '2024-03-08');

-- Insertar solicitudes de coincidencias temporales (temp_match)
INSERT INTO temp_match (artist_id, space_id, artist_like, space_like, status, request_date) VALUES
(1, 2, 1, 0, 'pending', '2024-03-07 15:00:00'),
(3, 4, 1, 1, 'accepted', '2024-03-08 16:00:00');

-- Insertar contratos
INSERT INTO contracts (artist_id, space_id, meet_type, status, init_hour, end_hour) VALUES
(1, 2, 'meeting', 'todo', '2024-03-10 10:00:00', '2024-03-10 12:00:00'),
(3, 4, 'work', 'finished', '2024-03-11 14:00:00', '2024-03-11 18:00:00');

-- Insertar incidencias
INSERT INTO incidences (app_user_id, admin_user_id, description, status) VALUES
(1, 1, 'Problema con el acceso', 'open'),
(2, 2, 'Reporte de error en la app', 'in_progress');