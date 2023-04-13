DELETE FROM MC_Config
DELETE FROM MC_FormaPag
DELETE FROM MC_FormasPadrao
DELETE FROM PC_Contas
DELETE FROM MC_Setor
DELETE FROM MC_Grupo
DELETE FROM MC_TabelaPrecos

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ExtratoConsiliadoResumoTitulos') 
BEGIN
  DROP PROCEDURE sp_ExtratoConsiliadoResumoTitulos
END

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_ExtratoConsolidadoSaldoDia') 
BEGIN
  DROP PROCEDURE sp_ExtratoConsolidadoSaldoDia
END