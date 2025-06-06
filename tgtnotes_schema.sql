DROP DATABASE IF EXISTS tgtnotes;
CREATE DATABASE tgtnotes;
GO

USE tgtnotes;
GO

CREATE TABLE roles (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	CONSTRAINT pk_roles PRIMARY KEY (id)
);

CREATE TABLE genres (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	CONSTRAINT pk_genres PRIMARY KEY (id)
);

CREATE TABLE languages (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	CONSTRAINT pk_languages PRIMARY KEY (id)
);

CREATE TABLE admin (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	mail NVARCHAR(255),
	password NVARCHAR(255),
	role_id INT,
	CONSTRAINT pk_admin PRIMARY KEY (id),
	CONSTRAINT fk_admin_role FOREIGN KEY(role_id) REFERENCES roles (id)
);

CREATE TABLE activity (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	type NVARCHAR(20) CHECK (type IN ('event', 'task', 'reminder')),
	description NVARCHAR(255),
	date DATE,
	admin_user_id INT,
	CONSTRAINT pk_activity PRIMARY KEY (id),
	CONSTRAINT fk_activity_admin FOREIGN KEY(admin_user_id) REFERENCES admin (id)
);

CREATE TABLE app (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	mail NVARCHAR(255) UNIQUE,
	password NVARCHAR(255),
	role NVARCHAR(60),
	rating INT CHECK (rating BETWEEN 1 AND 5) NULL,
	latitude DECIMAL(10,8) NULL,
	longitude DECIMAL(11,8) NULL,
	active BIT,
	language_id INT NULL,
	CONSTRAINT pk_app PRIMARY KEY (id),
	CONSTRAINT fk_app_language FOREIGN KEY(language_id) REFERENCES languages (id)
);

CREATE TABLE files (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	type NVARCHAR(20) CHECK (type IN ('image', 'video', 'audio', 'document')),
	date DATE,
	app_id INT,
	CONSTRAINT pk_files PRIMARY KEY (id, app_id),
	CONSTRAINT fk_file_app FOREIGN KEY(app_id) REFERENCES app (id)
);

CREATE TABLE notifications (
	id INT IDENTITY(1,1),
	content NVARCHAR(60),
	date DATE,
	app_id INT,
	CONSTRAINT pk_notifications PRIMARY KEY (id, app_id),
	CONSTRAINT fk_notifications_app FOREIGN KEY(app_id) REFERENCES app (id)
);

CREATE TABLE chats (
	id INT IDENTITY(1,1),
	date DATE,
	user1_id INT,
	user2_id INT,
	CONSTRAINT pk_chats PRIMARY KEY (id),
	CONSTRAINT fk_chats_user1 FOREIGN KEY(user1_id) REFERENCES app (id),
	CONSTRAINT fk_chats_user2 FOREIGN KEY(user2_id) REFERENCES app (id)
);

CREATE TABLE messages (
	id INT IDENTITY(1,1),
	sender_id INT,
	content NVARCHAR(255),
	send_at DATETIME,
	is_read BIT,
	chat_id INT,
	CONSTRAINT pk_messages PRIMARY KEY (id),
	CONSTRAINT fk_messages_chat FOREIGN KEY(chat_id) REFERENCES chats (id)
);

CREATE TABLE rating (
	id INT IDENTITY(1,1) PRIMARY KEY,
	rating INT CHECK (rating BETWEEN 1 AND 5),
	artist_id INT NULL,
	space_id INT NULL,
	CONSTRAINT fk_rating_artist FOREIGN KEY(artist_id) REFERENCES app (id),
	CONSTRAINT fk_rating_space FOREIGN KEY(space_id) REFERENCES app (id)
);

CREATE TABLE spaces (
	app_user_id INT,
	capacity INT,
	zip_code NVARCHAR(10),
	CONSTRAINT pk_spaces PRIMARY KEY (app_user_id),
	CONSTRAINT fk_spaces_app FOREIGN KEY(app_user_id) REFERENCES app (id) ON DELETE CASCADE
);

CREATE TABLE artists (
	app_user_id INT,
	CONSTRAINT pk_artists PRIMARY KEY (app_user_id),
	CONSTRAINT fk_artists_app FOREIGN KEY(app_user_id) REFERENCES app (id) ON DELETE CASCADE
);

CREATE TABLE artist_genres (
	artist_id INT,
	genre_id INT,
	creation_date DATE,
	CONSTRAINT pk_artist_genres PRIMARY KEY (artist_id, genre_id),
	CONSTRAINT fk_artist FOREIGN KEY(artist_id) REFERENCES artists (app_user_id),
	CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genres (id)
);

CREATE TABLE matches (
	artist_id INT,
	space_id INT,
	match_date DATE,
	CONSTRAINT pk_matches PRIMARY KEY (artist_id, space_id),
	CONSTRAINT fk_matches_artist FOREIGN KEY(artist_id) REFERENCES app (id),
	CONSTRAINT fk_matches_space FOREIGN KEY(space_id) REFERENCES app (id)
);

CREATE TABLE temp_match (
	artist_id INT,
	space_id INT,
	artist_like BIT DEFAULT 0,
	space_like BIT DEFAULT 0,
	status NVARCHAR(20) CHECK (status IN ('pending', 'accepted', 'rejected')) DEFAULT 'pending',
	request_date DATETIME DEFAULT GETDATE(),
	CONSTRAINT pk_temp_match PRIMARY KEY (artist_id, space_id),
	CONSTRAINT fk_temp_match_artist FOREIGN KEY(artist_id) REFERENCES app(id),
	CONSTRAINT fk_temp_match_space FOREIGN KEY(space_id) REFERENCES app(id)
);

CREATE TABLE contracts (
	artist_id INT,
	space_id INT,
	title NVARCHAR(255),
	meet_type NVARCHAR(20) CHECK (meet_type IN ('meeting', 'work')),
	status NVARCHAR(20) CHECK (status IN ('todo', 'finished')),
	init_hour DATETIMEOFFSET,
	end_hour DATETIMEOFFSET,
	CONSTRAINT pk_contracts PRIMARY KEY (artist_id, space_id, init_hour, end_hour),
	CONSTRAINT fk_contracts_artist FOREIGN KEY(artist_id) REFERENCES app (id),
	CONSTRAINT fk_contracts_space FOREIGN KEY(space_id) REFERENCES app (id)
);

CREATE TABLE incidences (
	app_user_id INT,
	admin_user_id INT,
	description NVARCHAR(MAX),
	status NVARCHAR(20) CHECK (status IN ('open', 'in_progress', 'closed')),
	CONSTRAINT pk_incidences PRIMARY KEY (app_user_id, admin_user_id),
	CONSTRAINT fk_incidences_app FOREIGN KEY(app_user_id) REFERENCES app (id),
	CONSTRAINT fk_incidences_admin FOREIGN KEY(admin_user_id) REFERENCES admin (id)
);
GO
