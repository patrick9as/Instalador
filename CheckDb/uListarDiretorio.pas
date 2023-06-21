unit uListarDiretorio;

interface

uses
  System.SysUtils, System.Classes;

type TListarDiretorio = class
  private
  public
    function Lista(Path: string): TStringList;
end;

implementation

{ ListarDiretorio }


{ ListarDiretorio }

function TListarDiretorio.Lista(Path: string): TStringList;
var
  SR: TSearchRec;
  aLista: TStringList;
begin

  aLista := TStringList.Create();

  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin

    repeat
      if (SR.Attr <> faDirectory) then
        aLista.Add(SR.Name);

    until FindNext(SR) <> 0;

    FindClose(SR);

  end;

  result := aLista;
end;

end.
