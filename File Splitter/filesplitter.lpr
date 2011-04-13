program filesplitter;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms
  { you can add units after this }, mainUnit;

begin
    Application.Title:='FileSplitter';
  Application.Initialize;
    Application.CreateForm(TMain, Main);
  Application.Run;
end.

