

CREATE TABLE CLIENTS (
    CLIENT_ID SERIAL PRIMARY KEY,
    CURRENT_AGE INT NOT NULL,
    RETIREMENT_AGE INT,
    BIRTH_YEAR INT NOT NULL,
    BIRTH_MONTH INT NOT NULL,
    GENDER VARCHAR(10),
    ADDRESS TEXT,
    LATITUDE DECIMAL(10, 7),
    LONGITUDE DECIMAL(10, 7),
    PER_CAPITA_INCOME DECIMAL(12, 2),
    YEARLY_INCOME DECIMAL(12, 2),
    TOTAL_DEBT DECIMAL(12, 2),
    CREDIT_SCORE INT,
    NUM_CREDIT_CARDS INT
);

CREATE TYPE has_chip_enum AS ENUM ('YES', 'NO');
CREATE TYPE has_carddark_enum AS ENUM ('YES', 'NO');

CREATE TABLE CARDS (
    CARD_ID SERIAL PRIMARY KEY,
    CLIENT_ID INT REFERENCES CLIENTS(CLIENT_ID) ON DELETE CASCADE,
    CARD_BRAND VARCHAR(50),
    CARD_TYPE VARCHAR(50),
    CARD_NUMBER VARCHAR(20) NOT NULL,
    EXPIRES DATE,
    CVV VARCHAR(4),
    HAS_CHIP has_chip_enum NOT NULL,
    NUM_CARDS_ISSUED INT,
    CREDIT_LIMIT DECIMAL(12, 2),
    ACCT_OPEN_DATE varchar(11),
    YEAR_PIN_LAST_CHANGED INT,
    CARD_ON_DARK_WEB has_carddark_enum NOT NULL
);





CREATE TABLE MERCHANTS (
    MERCHANT_ID SERIAL PRIMARY KEY,
    MERCHANT_CITY VARCHAR(100),
    MERCHANT_STATE VARCHAR(50),
    ZIP VARCHAR(20)
);


CREATE TABLE MCC (
    MCC INT PRIMARY KEY,
    DESCRIPTION VARCHAR(255)
);


CREATE TABLE TRANSACTIONS (
    TRANSACTION_ID SERIAL PRIMARY KEY,
    DATE TIMESTAMP NOT NULL,
    CLIENT_ID INT REFERENCES CLIENTS(CLIENT_ID) ON DELETE CASCADE,
    CARD_ID INT REFERENCES CARDS(CARD_ID) ON DELETE CASCADE,
    AMOUNT DECIMAL(12, 2) NOT NULL,
    USE_CHIP BOOLEAN NOT NULL,
    MERCHANT_ID INT REFERENCES MERCHANTS(MERCHANT_ID) ON DELETE CASCADE,
    MCC INT REFERENCES MCC(MCC),
    ERRORS TEXT
);


ALTER TABLE CLIENTS
ALTER COLUMN LATITUDE TYPE DECIMAL(12, 7),
ALTER COLUMN LONGITUDE TYPE DECIMAL(12, 7);
