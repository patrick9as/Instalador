
CREATE PROCEDURE dbo.sp_ExtratoConsiliadoResumoTitulos @Data VARCHAR(12)
AS

  SELECT
    mt.Vencimento
   ,mfp.Descricao
   ,ISNULL(CONVERT(NUMERIC(18, 2), SUM(mt.Valor)), 0) AS Valor
   ,1 AS Ordem
  FROM MC_Titulos mt
  LEFT JOIN MC_FormasPadrao mfp
    ON mt.CodFormaPagto = mfp.CodFormaPadrao
  WHERE mt.Vencimento >= dbo.converterData(@Data)
  AND mt.Vencimento <= dbo.converterData(@Data)
  AND codFormaPagto IN (2, 21)
  AND Situacao = 'PEN'
  GROUP BY Vencimento
          ,mfp.Descricao
  UNION ALL
  SELECT
    Totalizador.Vencimento
   ,'TOTAL' AS Descricao
   ,Totalizador.Valor
   ,2 AS Ordem
  FROM (SELECT
      dbo.converterData(@Data) AS Vencimento
     ,ISNULL(CONVERT(NUMERIC(18, 2), SUM(mt.Valor)), 0) AS Valor
    FROM MC_Titulos mt
    WHERE mt.Vencimento >= dbo.converterData(@Data)
    AND mt.Vencimento <= dbo.converterData(@Data)
    AND codFormaPagto IN (2, 21)
    AND Situacao = 'PEN'
    GROUP BY Vencimento) AS Totalizador
  ORDER BY Vencimento, Ordem
