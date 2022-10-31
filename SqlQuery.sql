CREATE TABLE IF NOT EXISTS user_profile(
    id BIGSERIAL PRIMARY KEY,
    first_name TEXT(200) NOT NULL,
    last_name TEXT(200) NOT NULL,
    email TEXT(200) NOT NULL UNIQUE,
    gender TEXT(200) NOT NULL CHECK(gender IN {'MALE', 'FEMALE'}),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

-- ONE - to -ONE relationship between user_profile and youtube account
-- This relationship can be created using Primary key-Unique foreign key constraints.

CREATE TABLE IF NOT EXISTS youtube_account(
    id BIGINT PRIMARY KEY REFERENCES user_profile(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

-- ONE to MANY relationship between youtube_account and youtube channel

CREATE TABLE IF NOT EXISTS youtube_channel(
    id BIGSERIAL PRIMARY KEY,
    youtube_account_id BIGINT NOT NULL REFERENCES youtube_account(id),
    channel_name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
);

-- MANY to MANY relationship between two table require a junction table

CREATE TABLE channel_subscriber(
    youtube_account_id BIGINT REFERENCES youtube_account(id),
    youtube_channel_id BIGINT REFERENCES youtube_channel(id),
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    PRIMARY KEY(youtube_account_id, youtube_channel_id)
);