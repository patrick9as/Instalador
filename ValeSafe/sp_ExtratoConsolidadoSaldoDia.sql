
CREATE PROCEDURE dbo.sp_ExtratoConsolidadoSaldoDia @DataInicial VARCHAR(12),
@DataFinal VARCHAR(12)

AS

  SELECT
    dbo.converterData(@DataInicial) AS Vencimento
   ,0 AS Receber
   ,ISNULL(CONVERT(NUMERIC(18, 2), SUM(Valor) * (-1)), 0) AS Pagar
  FROM MC_ContasMovimento mcm
  WHERE mcm.Vencimento < dbo.converterData(@DataInicial)
  AND mcm.Situacao = 'PEN'
  UNION ALL
  SELECT
    dbo.converterData(@DataInicial) AS Vencimento
   ,ISNULL(CONVERT(NUMERIC(18, 2), SUM(Valor)), 0) AS Receber
   ,0 AS Pagar
  FROM MC_BancoMov BM
  INNER JOIN MC_Banco B
    ON BM.CodConta = B.Codigo
    AND ISNULL(B.ContaInterna, 'N') <> 'S'
  WHERE Emissao <= dbo.converterData(@DataInicial)
  UNION ALL
  SELECT
    Vencimento
   ,ISNULL(Receber, 0)
   ,ISNULL(Pagar, 0)
  FROM (SELECT
      Vencimento
     ,[1] AS Receber
     ,[2] AS Pagar
    FROM (SELECT
        Vencimento
       ,1 AS Tipo
       ,CONVERT(NUMERIC(18, 2), Valor) AS Valor
      FROM MC_Titulos mt
      WHERE mt.Vencimento >= dbo.converterData(@DataInicial)
      AND mt.Vencimento <= dbo.converterData(@DataFinal)
      AND mt.codFormaPagto IN (2, 21, 22)
      AND mt.Situacao = 'PEN'
      UNION ALL
      SELECT
        Vencimento
       ,2 AS Tipo
       ,CONVERT(NUMERIC(18, 2), Valor * (-1)) AS Valor
      FROM MC_ContasMovimento mcm
      WHERE mcm.Vencimento >= dbo.converterData(@DataInicial)
      AND mcm.Vencimento <= dbo.converterData(@DataFinal)
      AND mcm.Situacao = 'PEN') AS ValoresUnificados
    PIVOT
    (
    SUM(ValoresUnificados.Valor) FOR ValoresUnificados.Tipo IN ([1], [2])
    ) P) AS ExtratoConsolidado
GO