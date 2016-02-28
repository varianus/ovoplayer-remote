{Hint: save all files to location: /jni }
unit uplaylist;

{$mode delphi}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls, 
    Laz_And_Controls_Events, AndroidWidget, customdialog;

type

  { Tplaylist }

  Tplaylist = class(jForm)
    jlvPlayList: jListView;
    jPanel1: jPanel;
    procedure jlvPlayListClickItem(Sender: TObject; itemIndex: integer;
      itemCaption: string);
    procedure jPanel1FlingGesture(Sender: TObject; flingGesture: TFlingGesture);
    procedure playlistBackButton(Sender: TObject);
    procedure playlistJNIPrompt(Sender: TObject);
  private

    OldPos: integer;
  public
    procedure HandleServerMessage(smessage: String);
  end;

var
  playlist: Tplaylist;

implementation

uses uplayer, ubackend, BaseTypes, basetag, netprotocol, netsupport;

{$R *.lfm}
  

{ Tplaylist }

function DumpMetaData(Tags: TCommonTags): String;
begin
  result :=
            (inttostr(Tags.id))+'__'+
            (Tags.FileName)+'__'+
            (Tags.Album)+'__'+
            (Tags.AlbumArtist)+'__'+
            (Tags.Artist)+'__'+
            (Tags.Comment)+'__'+
            (Inttostr(Tags.Duration))+'__'+
            (Tags.Genre)+'__'+
            (Tags.Title)+'__'+
            (Tags.TrackString)+'__'+
            (Tags.Year);
           end;

Procedure TPlayList.HandleServerMessage(smessage:String);
var
  r : RExternalCommand;
  tags: TCommonTags;
  s, Data: string;
  CurrPos, TotalCount: integer;
  NewState: TEngineState;
var
  tmp : TXY;
begin
  r := SplitCommand(sMessage);
  if (r.Category = CATEGORY_INFORMATION)  then
     begin
       if (r.Command = INFO_FULLPLAYLIST) then
       begin
         jlvPlayList.Clear;

         TotalCount:=StrToIntDef(ExtractField(r.param, Backend.InCfg), 0);
         LogDebug('OVOVOVOVO', 'GOT PLAYLIST');
         for CurrPos:= 0 to TotalCount -1 do
           begin
             tags := DecodeMetaData(r.Param, Backend.InCfg);
          //   LogDebug('OVOVOVOVO', DumpMetaData(Tags));
             jlvPlayList.Add(tags.Title+'|'+tags.AlbumArtist,'|', colbrDefault, 0, wgTextView, inttostr(CurrPos+1)+'.',nil);
           end;
         jlvPlayList.HighLightSelectedItem:=true;
         jlvPlayList.HighLightSelectedItemColor:=colbrYellow;

       end
       else
       if (r.Command = INFO_PLAYLISTINDEX) then
       begin
         CurrPos:= StrToIntDef(r.Param, -1);
         if CurrPos > 0 then
           begin
             dec(currpos);
             if OldPos <> -1 then
                jlvPlayList.SetImageByIndex(nil, OldPos);
             jlvPlayList.SetImageByIndex('ic_play_arrow_white_36dp', CurrPos);
             OldPos:= CurrPos;
             tmp.X:= CurrPos;
             tmp.Y := 10;
             jlvPlayList.setItemIndex := tmp;
      //       jlvPlayList.SetSelectedItem(Currpos);
           end;
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
end;

procedure Tplaylist.jlvPlayListClickItem(Sender: TObject; itemIndex: integer;
  itemCaption: string);
var
  msg:string;
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PLAY, IntToStr(ItemIndex)), Backend.OutCfg);
  backend.Client.SendMessage(msg);
end;

procedure Tplaylist.playlistJNIPrompt(Sender: TObject);
var
  msg:string;
begin
  Backend.ActiveForm:=self;

  self.UpdateLayout;
  OldPos := -1;

  msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_FULLPLAYLIST), Backend.OutCfg);
  backend.Client.SendMessage(msg);

  msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_PLAYLISTINDEX), Backend.OutCfg);
  backend.Client.SendMessage(msg);

end;

end.
