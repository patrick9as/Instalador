﻿--
-- Script was generated by Devart dbForge Studio 2018 for SQL Server, Version 5.6.104.0
-- Product home page: http://www.devart.com/dbforge/sql/studio
-- Script date 16/07/2020 14:40:48
-- Server version: 10.50.4000
--

SET DATEFORMAT ymd
SET ARITHABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS, XACT_ABORT OFF
GO

INSERT MC_TabelaPrecos(Codigo, Descricao, MargemPadrao, Sync) VALUES (1, '1 - OURO', 45, NULL)
INSERT MC_TabelaPrecos(Codigo, Descricao, MargemPadrao, Sync) VALUES (2, '2 - PRATA', 28, NULL)
INSERT MC_TabelaPrecos(Codigo, Descricao, MargemPadrao, Sync) VALUES (3, '3 - BRONZE', 15, NULL)
INSERT MC_TabelaPrecos(Codigo, Descricao, MargemPadrao, Sync) VALUES (4, '4 - MÍNIMA', 10, NULL)
GO