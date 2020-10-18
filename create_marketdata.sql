DROP TABLE IF EXISTS ExchangeRate;
DROP TABLE IF EXISTS Trading;
DROP TABLE IF EXISTS Market;
DROP TABLE IF EXISTS Currency;

CREATE TABLE Currency(
    uid SERIAL,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT currency_pkey PRIMARY KEY (uid)
);

CREATE TABLE Market(
    uid SERIAL,
    currency INTEGER NOT NULL,
    name VARCHAR(30) NOT NULL,
    location VARCHAR(30) NOT NULL,
    CONSTRAINT market_pkey PRIMARY KEY (uid),
    FOREIGN KEY (currency) REFERENCES Currency (uid) ON DELETE RESTRICT
);

CREATE TABLE Trading(
	uid SERIAL,
    market INTEGER NOT NULL,
    code VARCHAR(10) NOT NULL,
    date DATE NOT NULL,
    open REAL NOT NULL,
    close REAL NOT NULL,
    high REAL,
    low REAL,
    volume INTEGER NOT NULL,
    CONSTRAINT trading_pkey PRIMARY KEY (uid),
    FOREIGN KEY (market) REFERENCES Market (uid) ON DELETE RESTRICT,
    CONSTRAINT trading_uniqueness UNIQUE (market, code, date)
);

CREATE TABLE ExchangeRate(
    uid SERIAL,
    localcurrency INTEGER NOT NULL,
    foreigncurrency INTEGER NOT NULL,
    exchangerate REAL NOT NULL,
    date DATE NOT NULL,
    CONSTRAINT exchangerate_pkey PRIMARY KEY (uid),
    FOREIGN KEY (localcurrency) REFERENCES Currency (uid) ON DELETE RESTRICT,
    FOREIGN KEY (foreigncurrency) REFERENCES Currency (uid) ON DELETE RESTRICT,
    CONSTRAINT exchangerate_uniqueness UNIQUE (localcurrency, foreigncurrency, date)
);

INSERT INTO Currency(name)
    VALUES ('AUD');

INSERT INTO Market(currency, name, location)
    VALUES (1, 'ASX', 'Australia');