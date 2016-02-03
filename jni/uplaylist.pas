{Hint: save all files to location: /jni }
unit uplaylist;

{$mode delphi}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls, 
    Laz_And_Controls_Events, AndroidWidget;

type

  { Tplaylist }

  Tplaylist = class(jForm)
    jlvPlayList: jListView;
    jPanel1: jPanel;
    procedure jPanel1FlingGesture(Sender: TObject; flingGesture: TFlingGesture);
    procedure playlistBackButton(Sender: TObject);
    procedure playlistJNIPrompt(Sender: TObject);
  private

    {private declarations}
  public
    procedure HandleServerMessage(smessage: String);
  end;

var
  playlist: Tplaylist;

implementation

uses uplayer, ubackend, BaseTypes, basetag, netprotocol, netsupport;

{$R *.lfm}
  

{ Tplaylist }

Procedure TPlayList.HandleServerMessage(smessage:String);
var
  r : RExternalCommand;
  tags: TCommonTags;
  s, Data: string;
  CurrPos, TotalCount: integer;
  NewState: TEngineState;
begin
  r := SplitCommand(sMessage);
  if (r.Category = CATEGORY_INFORMATION) and (r.Command = INFO_FULLPLAYLIST) then
     begin
       jlvPlayList.Clear;
       TotalCount:=StrToIntDef(ExtractField(r.param), 0);
       LogDebug('OVOVOVOVO', 'GOT PLAYLIST');
       for CurrPos:= 0 to TotalCount -1 do
         begin
           tags := DecodeMetaData(r.Param);
           jlvPlayList.Add(tags.Title+'|'+tags.AlbumArtist,'|');
         end;

     end
  else
    Player.HandleServerMessage(smessage);

end;


procedure Tplaylist.playlistBackButton(Sender: TObject);
begin
  Player.Show;
end;

procedure Tplaylist.jPanel1FlingGesture(Sender: TObject;
  flingGesture: TFlingGesture);
var
  msg:string;
begin
  if flingGesture <> fliLeftToRight then
     exit;

   if player = nil then
    begin
      gApp.CreateForm(Tplayer, player);
      Backend.ActiveForm:= player;
      player.Init(gApp);
    end
  else
    begin
      playlist.Show; //actRecyclable
    end;
    self.Close;
    LogDebug('OVOVOVOVO', 'GO To PLAYER');
end;

procedure Tplaylist.playlistJNIPrompt(Sender: TObject);
var
  msg:string;
begin
  Backend.ActiveForm:=self;
  self.UpdateLayout;

  msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_FULLPLAYLIST), Backend.cfg);
  backend.Client.SendMessage(msg);

end;

end.
