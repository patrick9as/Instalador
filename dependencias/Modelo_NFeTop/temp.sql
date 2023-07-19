Select CodNota, Num_Nota_Fiscal, Tipo_Ambiente, Dest_Razao, Inf_Motivo
       from NFe_Cab
       where Num_Nota_Fiscal = 01
       and Num_Mod_Doc = 055
       and Tipo_Ambiente = 00
       and CodNota <> 1
       and Num_Serie = 1
       and Ind_Emit = 0
