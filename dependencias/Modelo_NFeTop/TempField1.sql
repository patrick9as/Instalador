if  not exists (select * from dbo.sysobjects where id = object_id( N'NFe_Emitente'))
  begin
   create table NFe_Emitente (  TipoFretePadrao smallint NULL  Default( 9 ))
  end
