CREATE TABLE EmbedIDOOEntA (id INTEGER NOT NULL, password VARCHAR(255), userName VARCHAR(255), identity_id INTEGER, identity_country VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE EmbedIDOOEntB (country VARCHAR(255) NOT NULL, id INTEGER NOT NULL, name VARCHAR(255), salary INTEGER, PRIMARY KEY (country, id));
CREATE TABLE IDClassOOEntityA (id INTEGER NOT NULL, password VARCHAR(255), userName VARCHAR(255), identity_id INTEGER, identity_country VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE IDClassOOEntityB (country VARCHAR(255) NOT NULL, id INTEGER NOT NULL, name VARCHAR(255), salary INTEGER, PRIMARY KEY (country, id));
CREATE TABLE OOBiCardEntA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id), UNIQUE(B_ID));
CREATE TABLE OOBiCardEntB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntA (id INTEGER NOT NULL, name VARCHAR(255), BIENT_B1CP INTEGER, BIENT_B1 INTEGER, B2_ID INTEGER, BIENT_B4 INTEGER, BIENT_B1CA INTEGER, BIENT_B1CM INTEGER, BIENT_B1RF INTEGER, BIENT_B1RM INTEGER, PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B1 (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B2 (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B4 (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B5CA (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B5CM (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B5CP (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B5RF (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOBiEntB_B5RM (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOCardEntA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id), UNIQUE(B_ID));
CREATE TABLE OOCardEntB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OONoOptBiEntityA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE OONoOptBiEntityB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OONoOptEntityA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE OONoOptEntityB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE OOUniEntA (id INTEGER NOT NULL, name VARCHAR(255), UNIENT_B1 INTEGER, B2_ID INTEGER, B4_ID INTEGER, B5CA_ID INTEGER, B5CM_ID INTEGER, B5CP_ID INTEGER, B5RF_ID INTEGER, B5RM_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE OOUniEntB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE PKJoinOOEntityA (id INTEGER NOT NULL, strVal VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE PKJoinOOEntityB (id INTEGER NOT NULL, intVal INTEGER, PRIMARY KEY (id));
CREATE TABLE XMLEmbedIDOOEntA (id INTEGER NOT NULL, password VARCHAR(255), userName VARCHAR(255), identity_id INTEGER, identity_country VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLEmbedIDOOEntB (country VARCHAR(255) NOT NULL, id INTEGER NOT NULL, name VARCHAR(255), salary INTEGER, PRIMARY KEY (country, id));
CREATE TABLE XMLIDClassOOEntityA (id INTEGER NOT NULL, password VARCHAR(255), userName VARCHAR(255), identity_id INTEGER, identity_country VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLIDClassOOEntityB (country VARCHAR(255) NOT NULL, id INTEGER NOT NULL, name VARCHAR(255), salary INTEGER, PRIMARY KEY (country, id));
CREATE TABLE XMLOOBiCardEntA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id), UNIQUE(B_ID));
CREATE TABLE XMLOOBiCardEntB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntA (id INTEGER NOT NULL, name VARCHAR(255), B5CM_ID INTEGER, XMLBIENT_B1 INTEGER, B2_ID INTEGER, B4_ID INTEGER, B5CA_ID INTEGER, B5CP_ID INTEGER, B5RF_ID INTEGER, B5RM_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B1 (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B2 (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B4 (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B5CA (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B5CM (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B5CP (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B5RF (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOBiEntB_B5RM (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOCardEntA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id), UNIQUE(B_ID));
CREATE TABLE XMLOOCardEntB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOONoOptBiEntityA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE XMLOONoOptBiEntityB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOONoOptEntityA (id INTEGER NOT NULL, name VARCHAR(255), B_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE XMLOONoOptEntityB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLOOUniEntA (id INTEGER NOT NULL, name VARCHAR(255), UNIENT_B1 INTEGER, B2_ID INTEGER, B4_ID INTEGER, B5CA_ID INTEGER, B5CM_ID INTEGER, B5CP_ID INTEGER, B5RF_ID INTEGER, B5RM_ID INTEGER, PRIMARY KEY (id));
CREATE TABLE XMLOOUniEntB (id INTEGER NOT NULL, name VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLPKJoinOOEnA (id INTEGER NOT NULL, strVal VARCHAR(255), PRIMARY KEY (id));
CREATE TABLE XMLPKJoinOOEnB (id INTEGER NOT NULL, intVal INTEGER, PRIMARY KEY (id));
CREATE INDEX I_MBDDONT_IDENTITY ON EmbedIDOOEntA (identity_id, identity_country);
CREATE INDEX I_DCLSTTY_IDENTITY ON IDClassOOEntityA (identity_id, identity_country);
CREATE INDEX I_OBCRDNT_B ON OOBiCardEntA (B_ID);
CREATE INDEX I_OOBIENT_B1 ON OOBiEntA (BIENT_B1);
CREATE INDEX I_OOBIENT_B2 ON OOBiEntA (B2_ID);
CREATE INDEX I_OOBIENT_B4 ON OOBiEntA (BIENT_B4);
CREATE INDEX I_OOBIENT_B5CA ON OOBiEntA (BIENT_B1CA);
CREATE INDEX I_OOBIENT_B5CM ON OOBiEntA (BIENT_B1CM);
CREATE INDEX I_OOBIENT_B5CP ON OOBiEntA (BIENT_B1CP);
CREATE INDEX I_OOBIENT_B5RF ON OOBiEntA (BIENT_B1RF);
CREATE INDEX I_OOBIENT_B5RM ON OOBiEntA (BIENT_B1RM);
CREATE INDEX I_OOCRDNT_B ON OOCardEntA (B_ID);
CREATE INDEX I_NPTBTTY_B ON OONoOptBiEntityA (B_ID);
CREATE INDEX I_NPTNTTY_B ON OONoOptEntityA (B_ID);
CREATE INDEX I_OOUNINT_B1 ON OOUniEntA (UNIENT_B1);
CREATE INDEX I_OOUNINT_B2 ON OOUniEntA (B2_ID);
CREATE INDEX I_OOUNINT_B4 ON OOUniEntA (B4_ID);
CREATE INDEX I_OOUNINT_B5CA ON OOUniEntA (B5CA_ID);
CREATE INDEX I_OOUNINT_B5CM ON OOUniEntA (B5CM_ID);
CREATE INDEX I_OOUNINT_B5CP ON OOUniEntA (B5CP_ID);
CREATE INDEX I_OOUNINT_B5RF ON OOUniEntA (B5RF_ID);
CREATE INDEX I_OOUNINT_B5RM ON OOUniEntA (B5RM_ID);
CREATE INDEX I_XMLMDNT_IDENTITY ON XMLEmbedIDOOEntA (identity_id, identity_country);
CREATE INDEX I_XMLDTTY_IDENTITY ON XMLIDClassOOEntityA (identity_id, identity_country);
CREATE INDEX I_XMLBDNT_B ON XMLOOBiCardEntA (B_ID);
CREATE INDEX I_XMLOBNT_B1 ON XMLOOBiEntA (XMLBIENT_B1);
CREATE INDEX I_XMLOBNT_B2 ON XMLOOBiEntA (B2_ID);
CREATE INDEX I_XMLOBNT_B4 ON XMLOOBiEntA (B4_ID);
CREATE INDEX I_XMLOBNT_B5CA ON XMLOOBiEntA (B5CA_ID);
CREATE INDEX I_XMLOBNT_B5CM ON XMLOOBiEntA (B5CM_ID);
CREATE INDEX I_XMLOBNT_B5CP ON XMLOOBiEntA (B5CP_ID);
CREATE INDEX I_XMLOBNT_B5RF ON XMLOOBiEntA (B5RF_ID);
CREATE INDEX I_XMLOBNT_B5RM ON XMLOOBiEntA (B5RM_ID);
CREATE INDEX I_XMLCDNT_B ON XMLOOCardEntA (B_ID);
CREATE INDEX I_XMLNTTY_B ON XMLOONoOptBiEntityA (B_ID);
CREATE INDEX I_XMLNTTY_B1 ON XMLOONoOptEntityA (B_ID);
CREATE INDEX I_XMLUNNT_B1 ON XMLOOUniEntA (UNIENT_B1);
CREATE INDEX I_XMLUNNT_B2 ON XMLOOUniEntA (B2_ID);
CREATE INDEX I_XMLUNNT_B4 ON XMLOOUniEntA (B4_ID);
CREATE INDEX I_XMLUNNT_B5CA ON XMLOOUniEntA (B5CA_ID);
CREATE INDEX I_XMLUNNT_B5CM ON XMLOOUniEntA (B5CM_ID);
CREATE INDEX I_XMLUNNT_B5CP ON XMLOOUniEntA (B5CP_ID);
CREATE INDEX I_XMLUNNT_B5RF ON XMLOOUniEntA (B5RF_ID);
CREATE INDEX I_XMLUNNT_B5RM ON XMLOOUniEntA (B5RM_ID);