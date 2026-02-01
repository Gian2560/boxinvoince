IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BoxInVoice')
BEGIN
    CREATE DATABASE BoxInVoice;
END
GO

USE BoxInVoice;
GO

create table UserBox (
 id uniqueidentifier primary key default newId(),
 username NVARCHAR(250) NOT NULL UNIQUE,
 password NVARCHAR(250) NOT NULL,
 phone_number int NOT NULL,
 prefix_number CHAR(5) NOT NULL,
 name VARCHAR(250) NOT NULL,
 last_name VARCHAR(250) NOT NULL,
 role VARCHAR(20) NOT NULL 
);

create table Party(
 id uniqueidentifier primary key default newId(),
 owner_id uniqueidentifier NOT NULL,
 time_start DateTime2 NOT NULL,
 time_end DateTime2 NULL,
 status VARCHAR(10) NOT NULL
        CHECK (status IN ('ACTIVE', 'FINISHED')),
 CONSTRAINT FK_Party_Owner
        FOREIGN KEY (owner_id) REFERENCES UserBox(id)
);

CREATE TABLE UserParty (
    party_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT PK_UserParty PRIMARY KEY (party_id, user_id),

    CONSTRAINT FK_UserParty_Party
        FOREIGN KEY (party_id) REFERENCES party(id),

    CONSTRAINT FK_UserParty_User
        FOREIGN KEY (user_id) REFERENCES UserBox(id)
);
CREATE TABLE Song (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    title VARCHAR(255) NOT NULL,
    duration TIME NOT NULL
);
CREATE TABLE Lyric (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    song_id UNIQUEIDENTIFIER NOT NULL,
    startTime TIME NOT NULL,
    endTime TIME NOT NULL,
    content VARCHAR(MAX) NOT NULL,
    CONSTRAINT FK_Lyric_Song
        FOREIGN KEY (song_id) REFERENCES Song(id)
);


CREATE TABLE Playlist (
    id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),

    party_id UNIQUEIDENTIFIER NOT NULL,
    song_id UNIQUEIDENTIFIER NOT NULL,
    user_id UNIQUEIDENTIFIER NOT NULL,

    position INT NOT NULL,

    status VARCHAR(10) NOT NULL
        CHECK (status IN ('PENDING', 'PLAYING', 'FINISHED', 'SKIPPED')),

    CONSTRAINT FK_Playlist_Party
        FOREIGN KEY (party_id) REFERENCES Party(id),

    CONSTRAINT FK_Playlist_Song
        FOREIGN KEY (song_id) REFERENCES Song(id),

    CONSTRAINT FK_Playlist_User
        FOREIGN KEY (user_id) REFERENCES UserBox(id)
);
