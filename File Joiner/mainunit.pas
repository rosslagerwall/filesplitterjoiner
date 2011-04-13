unit mainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls;

type

  { TMain }

  TMain = class(TForm)
      about: TButton;
      join: TButton;
      filename: TEdit;
      Label1: TLabel;
      Label2: TLabel;
      progress: TProgressBar;
      procedure aboutClick(Sender: TObject);
      procedure joinClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Main: TMain;

implementation

{ TMain }

procedure TMain.joinClick(Sender: TObject);
var numberText : string;
var outputFilename : string;
var parts, i : integer;
var input : TFileStream;
var output : TFileStream;
begin
     numberText := ExtractFileExt(filename.Text);
     outputFilename := filename.Text;
     Delete(outputFilename, Length(outputFilename) - Length(ExtractFileExt(filename.Text)) + 1, Length(ExtractFileExt(filename.Text)));
     Delete(numberText, 1, 1);
     parts := StrToInt(numberText);
     progress.max := parts;
     output := TFileStream.Create(outputFilename, fmCreate);
     for i := 1 to parts do
     begin
     	  input := TFileStream.Create(outputFilename + '.' + IntToStr(i), fmOpenRead);
          output.CopyFrom(input, input.size);
          input.Free;
          progress.stepIt;
          Application.ProcessMessages;
     end;
     ShowMessage('Done!');
     output.Free;
end;

procedure TMain.aboutClick(Sender: TObject);
begin
     ShowMessage('File Joiner Utlity.' + #10#13 + 'Compiled 22 March 2009');
end;

initialization
  {$I mainunit.lrs}

end.

