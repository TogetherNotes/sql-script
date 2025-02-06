# TogetherNotes SQL Script

This repository contains the SQL script for setting up the **TogetherNotes** database. **TogetherNotes** is a platform that connects musicians with venues, providing a space to manage performances, contracts, ratings, communications, and more.

### Database Structure

The SQL script creates the database and sets up the following tables:

- **roles**: Stores the different roles in the system.
- **genres**: Stores the music genres available for musicians.
- **languages**: Stores the languages available for the application.
- **files**: Stores multimedia files associated with the platform (images, videos, etc.).
- **notifications**: Stores system notifications for users.
- **admin**: Stores information about system administrators.
- **activity**: Stores activities related to system administration (events, tasks, reminders).
- **app**: Stores the details of musicians and venues using the platform.
- **chats**: Stores the chat conversations between users.
- **messages**: Stores the individual messages sent within chats.
- **spaces**: Stores the location details of venues.
- **artists**: Associates artists (musicians) with their genres.
- **match_events**: Stores matches between artists and venues for performances.
- **contracts**: Stores the details of contracts between artists and venues.
- **incidences**: Stores the incidences reported by administrators for resolution.

### Entity-Relationship Model

For a visual representation of the database structure, you can view the **Entity-Relationship (ER)** model and **Relational model** at the following link:  
[View ER and Relational Models](https://docs.google.com/document/d/1tQc-pb7o94L09-MsGT9NfMlz0ZMNcJtB27-1kStjR0E/edit?usp=sharing)

### Usage

1. Run the script to create the **tgtnotes** database and all necessary tables.
2. Populate the tables with your data as needed.
3. Use the database to manage users, performances, communications, and much more for your platform.