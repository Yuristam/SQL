/* Create Database */

CREATE DATABASE JobsDB

GO

USE JobsDB

----------------------------------
/* Delete Database */

USE master 

GO

DROP DATABASE JobsDB

----------------------------------
/* Rename Database */

ALTER DATABASE JobsDB MODIFY NAME = NewJobsDB;
