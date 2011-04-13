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
      filename: TEdit;
      partsText: TEdit;
      Label2: TLabel;
      sizeText: TEdit;
      progress: TProgressBar;
      RadioButton1: TRadioButton;
      RadioButton2: TRadioButton;
      split: TButton;
      procedure aboutClick(Sender: TObject);
      procedure splitClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Main: TMain;

implementation

{ TMain }

procedure TMain.splitClick(Sender: TObject);
var input : TFileStream;
var output : TFileStream;
var i : integer;
var size, splitSize : integer;
var parts : integer;
var partSize : integer;
var bytesRead : integer;
begin
     input := TFileStream.Create(filename.Text, fmOpenRead);
     size := input.size;
     progress.Position := 0;
     
     if RadioButton1.Checked = true then
     begin
         parts := StrToInt(partsText.Text);
         partSize := size div parts;
         progress.max := parts;
         for i := 1 to parts do
         begin
    	      output := TFileStream.Create(filename.Text + '.' + IntToStr(i), fmCreate);
             if i = 1 then
             begin
    		          output.CopyFrom(input, partSize + (size mod partSize));
             end
             else
             begin
     		 	  output.CopyFrom(input, partSize);
             end;

             output.Free;
             progress.stepIt;
             Application.ProcessMessages;
         end;
     end
     else
     begin
          splitSize := StrToInt(sizeText.Text) * 1024 * 1024;
          progress.max := (size div splitSize) + 1;
          i := 0;
          repeat
                i := i + 1;
		        output := TFileStream.Create(filename.Text + '.' + IntToStr(i), fmCreate);
                bytesRead := output.CopyFrom(input, splitSize);
                output.Free;
                progress.stepIt;
                Application.ProcessMessages;
          until bytesRead <> splitSize;
     end;
     
     input.Free;
     ShowMessage('Done!');
end;

procedure TMain.aboutClick(Sender: TObject);
begin
    ShowMessage('File Splitter Utlity.' + #10#13 + 'Compiled 22 March 2009');
end;

initialization
  {$I mainunit.lrs}

end.

