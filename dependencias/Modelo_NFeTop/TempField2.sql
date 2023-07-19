  if not exists (select * from syscolumns
    where id=object_id('NFe_Emitente') and name='TipoFretePadrao')
    alter table NFe_Emitente add TipoFretePadrao smallint NULL  Default( 9 )
