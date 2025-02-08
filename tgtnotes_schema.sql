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

CREATE TABLE files (
	id INT IDENTITY(1,1),
	name NVARCHAR(60),
	type NVARCHAR(20) CHECK (type IN ('image', 'video', 'audio', 'document')),
	date DATE,
	CONSTRAINT pk_files PRIMARY KEY (id)
);

CREATE TABLE notifications (
	id INT IDENTITY(1,1),
	content NVARCHAR(60),
	date DATE,
	CONSTRAINT pk_notifications PRIMARY KEY (id)
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
	mail NVARCHAR(255),
	password NVARCHAR(255),
	role_id INT,
	rating INT CHECK (rating BETWEEN 1 AND 5),
	latitude DECIMAL(10,8),
	longitude DECIMAL(11,8),
	active BIT,
	language_id INT,
	file_id INT,
	notification_id INT,
	CONSTRAINT pk_app PRIMARY KEY (id),
	CONSTRAINT fk_app_language FOREIGN KEY(language_id) REFERENCES languages (id),
	CONSTRAINT fk_app_file FOREIGN KEY(file_id) REFERENCES files (id),
	CONSTRAINT fk_app_notification FOREIGN KEY(notification_id) REFERENCES notifications (id)
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

CREATE TABLE contracts (
	id INT IDENTITY(1,1),
	artist_id INT,
	space_id INT,
	init_hour TIME,
	end_hour TIME,
	CONSTRAINT pk_contracts PRIMARY KEY (id),
	CONSTRAINT uq_contract UNIQUE (artist_id, space_id)
	CONSTRAINT fk_contracts_artist FOREIGN KEY(artist_id) REFERENCES app (id),
	CONSTRAINT fk_contracts_space FOREIGN KEY(space_id) REFERENCES app (id)
);

CREATE TABLE rating (
    id INT IDENTITY(1,1) PRIMARY KEY,
	rating INT CHECK (rating BETWEEN 1 AND 5),
    artist_id INT NULL,
    space_id INT NULL,
    contract_id INT NULL,
    CONSTRAINT fk_rating_app FOREIGN KEY(artist_id) REFERENCES app(id),
    CONSTRAINT fk_rating_space FOREIGN KEY(space_id) REFERENCES app(id),
    CONSTRAINT fk_rating_contract FOREIGN KEY(contract_id) REFERENCES contracts(id)
);

CREATE TABLE spaces (
	app_user_id INT,
	capacity INT,
	zip_code NVARCHAR(10),
	CONSTRAINT pk_spaces PRIMARY KEY (app_user_id),
	CONSTRAINT fk_spaces_app FOREIGN KEY(app_user_id) REFERENCES app (id)
);

CREATE TABLE artists (
	app_user_id INT,
	genre_id INT,
	CONSTRAINT pk_artists PRIMARY KEY (app_user_id, genre_id),
	CONSTRAINT fk_artists_app FOREIGN KEY(app_user_id) REFERENCES app (id),
	CONSTRAINT fk_artists_genre FOREIGN KEY(genre_id) REFERENCES genres (id)
);

CREATE TABLE matches (
	artist_id INT,
	space_id INT,
	CONSTRAINT pk_match PRIMARY KEY (artist_id, space_id),
	CONSTRAINT fk_match_artist FOREIGN KEY(artist_id) REFERENCES app (id),
	CONSTRAINT fk_match_space FOREIGN KEY(space_id) REFERENCES app (id)
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