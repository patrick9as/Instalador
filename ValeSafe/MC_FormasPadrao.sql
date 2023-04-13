﻿--
-- Script was generated by Devart dbForge Studio 2021 for SQL Server, Version 6.0.383.0
-- Product home page: http://www.devart.com/dbforge/sql/studio
-- Script date 30/11/2022 12:12:44
-- Server version: 15.00.2000
--

SET DATEFORMAT ymd
SET ARITHABORT, ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER, ANSI_NULLS, NOCOUNT ON
SET NUMERIC_ROUNDABORT, IMPLICIT_TRANSACTIONS, XACT_ABORT OFF
GO

INSERT MC_FormasPadrao(Codigo, CodFormaPadrao, Sigla, Descricao, TipoVP, AtivarNaPromocao, CodPC, Parcelar, Tipo, TipoTroco, CartaoPref, Comissao_Integral, LancarNoContasAReceber, FinalizarVendaBExp, BaixarEstoque, DescricaoMobile, CodBanco, PermiteRecebimento, PermiteCompraVLC, EmissaoCupomObrigatoria, UtilizarLeitorBiometrico, NaoBaixarEstoque, UsarTEF, SolicitarDadosCartao, EmitirPromissoria, VLCSimplificada) VALUES (1, 1, 'DNH', 'DINHEIRO', NULL, 'N', NULL, 'S', 'V', 'DNH', 'N', NULL, NULL, 'S', 'S', NULL, NULL, 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT MC_FormasPadrao(Codigo, CodFormaPadrao, Sigla, Descricao, TipoVP, AtivarNaPromocao, CodPC, Parcelar, Tipo, TipoTroco, CartaoPref, Comissao_Integral, LancarNoContasAReceber, FinalizarVendaBExp, BaixarEstoque, DescricaoMobile, CodBanco, PermiteRecebimento, PermiteCompraVLC, EmissaoCupomObrigatoria, UtilizarLeitorBiometrico, NaoBaixarEstoque, UsarTEF, SolicitarDadosCartao, EmitirPromissoria, VLCSimplificada) VALUES (2, 22, 'DEP', 'DEPOSITO CONTA', NULL, 'N', NULL, 'S', 'P', 'DNH', 'N', NULL, NULL, 'S', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT MC_FormasPadrao(Codigo, CodFormaPadrao, Sigla, Descricao, TipoVP, AtivarNaPromocao, CodPC, Parcelar, Tipo, TipoTroco, CartaoPref, Comissao_Integral, LancarNoContasAReceber, FinalizarVendaBExp, BaixarEstoque, DescricaoMobile, CodBanco, PermiteRecebimento, PermiteCompraVLC, EmissaoCupomObrigatoria, UtilizarLeitorBiometrico, NaoBaixarEstoque, UsarTEF, SolicitarDadosCartao, EmitirPromissoria, VLCSimplificada) VALUES (3, 21, 'BOL', 'BOLETO', NULL, 'N', NULL, 'S', 'P', 'DNH', 'N', NULL, NULL, 'S', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT MC_FormasPadrao(Codigo, CodFormaPadrao, Sigla, Descricao, TipoVP, AtivarNaPromocao, CodPC, Parcelar, Tipo, TipoTroco, CartaoPref, Comissao_Integral, LancarNoContasAReceber, FinalizarVendaBExp, BaixarEstoque, DescricaoMobile, CodBanco, PermiteRecebimento, PermiteCompraVLC, EmissaoCupomObrigatoria, UtilizarLeitorBiometrico, NaoBaixarEstoque, UsarTEF, SolicitarDadosCartao, EmitirPromissoria, VLCSimplificada) VALUES (4, 60, 'CCD', 'CARTAO CREDITO', NULL, 'N', NULL, 'S', 'V', 'DNH', 'N', NULL, NULL, 'S', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT MC_FormasPadrao(Codigo, CodFormaPadrao, Sigla, Descricao, TipoVP, AtivarNaPromocao, CodPC, Parcelar, Tipo, TipoTroco, CartaoPref, Comissao_Integral, LancarNoContasAReceber, FinalizarVendaBExp, BaixarEstoque, DescricaoMobile, CodBanco, PermiteRecebimento, PermiteCompraVLC, EmissaoCupomObrigatoria, UtilizarLeitorBiometrico, NaoBaixarEstoque, UsarTEF, SolicitarDadosCartao, EmitirPromissoria, VLCSimplificada) VALUES (5, 61, 'CCL', 'CARTAO DEBITO', NULL, 'N', NULL, 'S', 'V', 'DNH', 'N', NULL, NULL, 'S', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT MC_FormasPadrao(Codigo, CodFormaPadrao, Sigla, Descricao, TipoVP, AtivarNaPromocao, CodPC, Parcelar, Tipo, TipoTroco, CartaoPref, Comissao_Integral, LancarNoContasAReceber, FinalizarVendaBExp, BaixarEstoque, DescricaoMobile, CodBanco, PermiteRecebimento, PermiteCompraVLC, EmissaoCupomObrigatoria, UtilizarLeitorBiometrico, NaoBaixarEstoque, UsarTEF, SolicitarDadosCartao, EmitirPromissoria, VLCSimplificada) VALUES (6, 99, 'CDV', 'DEVOLUCAO', NULL, 'N', NULL, 'S', 'V', 'DNH', 'N', NULL, NULL, 'S', 'S', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO