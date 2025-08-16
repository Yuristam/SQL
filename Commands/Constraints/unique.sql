-- 3 способа создания UNIQUE ограничения

CREATE TABLE PersonPrivateInfo (
	Login VARCHAR(100) NOT NULL CONSTRAINT UQ_Person_Login UNIQUE,      -- 1 способ
	IDCard VARCHAR(20) NOT NULL,
	PersonalNumber INT NOT NULL,

	CONSTRAINT UQ_Person_IDCard UNIQUE (IDCard)                         -- 2 способ
);

ALTER TABLE PersonPrivateInfo ADD CONSTRAINT UQ_Person_PersonalNumber UNIQUE (PersonalNumber);   -- 3 способ
