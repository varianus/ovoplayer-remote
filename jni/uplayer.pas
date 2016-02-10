{Hint: save all files to location: /jni }
unit uplayer;

{$mode delphi}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls,
  Laz_And_Controls_Events, AndroidWidget, seekbar, broadcastreceiver,
  intentmanager, imagefilemanager, customdialog, menu, basetypes, basetag,
  netprotocol;

type

  { TPlayer }

  TPlayer = class(jForm)
    Album: jTextView;
    Artist: jTextView;
    bNext: jImageBtn;
    bPlay: jImageBtn;
    bPrev: jImageBtn;
    jBitmap1: jBitmap;
    jBroadcastReceiver1: jBroadcastReceiver;
    CoverView: jImageView;
    jIntentManager1: jIntentManager;
    jMenu1: jMenu;
    jSeekBar1: jSeekBar;
    jTextView1: jTextView;
    pnlControls: jPanel;
    pnlInfo: jPanel;
    pnlCover: jPanel;
    pnlPlayer: jPanel;
    TimerPos: jTimer;
    Title: jTextView;
    TVCurrPos: jTextView;
    procedure bNextClick(Sender: TObject);
    procedure bPlayClick(Sender: TObject);
    procedure bPrevClick(Sender: TObject);
    procedure jBroadcastReceiver1Receiver(Sender: TObject; intent: jObject);
    procedure jCustomDialog1Show(Sender: TObject; dialog: jObject; title: string
      );
    procedure jSeekBar1ProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jSeekBar1StartTrackingTouch(Sender: TObject; progress: integer);
    procedure jSeekBar1StopTrackingTouch(Sender: TObject; progress: integer);
    procedure PlayerClickOptionMenuItem(Sender: TObject; jObjMenuItem: jObject;
      itemID: integer; itemCaption: string; checked: boolean);
    procedure PlayerClose(Sender: TObject);
    procedure PlayerCreateOptionMenu(Sender: TObject; jObjMenu: jObject);
    procedure PlayerJNIPrompt(Sender: TObject);
    procedure PlayerRotate(Sender: TObject; rotate: TScreenStyle);
    procedure pnlPlayerFlingGesture(Sender: TObject; flingGesture: TFlingGesture
      );
    procedure TimerPosTimer(Sender: TObject);
  private
    FSeeking: boolean;
    msg: string;
    fTags: TCommonTags;
    procedure DecodeImage(s: string);
    procedure TagsToMap(Tags: TCommonTags);
  public
    procedure HandleServerMessage(smessage: String);

  end;

var
  Player: TPlayer;

implementation
uses uBackend, uplaylist, base64, netsupport;
{$R *.lfm}
  

{ TPlayer }

procedure TPlayer.PlayerJNIPrompt(Sender: TObject);
begin
   pnlPlayer.MatchParent();
   Self.UpdateLayout;
   FSeeking:= False;
   jBroadcastReceiver1.Registered:=true;
   msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_ENGINE_STATE), Backend.OutCfg);
   Backend.Client.SendMessage(msg);
   msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_POSITION), Backend.OutCfg);
   Backend.Client.SendMessage(msg);
   msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_METADATA), Backend.OutCfg);
   Backend.Client.SendMessage(msg);
   msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_COVERIMG, EncodeImageSize(CoverView.Width, CoverView.Height)), Backend.OutCfg);
   Backend.Client.SendMessage(msg);

   jMenu1.Clear();  //clean up ...
   jMenu1.InvalidateOptionsMenu();  //fire OnCreateOptionsMenu --> OnPrepareOptionsMenu to do form2 menu ...

end;

procedure TPlayer.bPrevClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PREVIOUS), Backend.OutCfg);
  Backend.Client.SendMessage(msg);
end;

procedure TPlayer.jBroadcastReceiver1Receiver(Sender: TObject; intent: jObject);
var
  act : string;
begin
  act := jIntentManager1.GetAction(intent);
  if act = 'android.intent.action.SCREEN_OFF' then
    TimerPos.Enabled := false;

  if act = 'android.intent.action.SCREEN_ON' then
    begin
                              msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_ENGINE_STATE), Backend.OutCfg);
                              Backend.Client.SendMessage(msg);
                              msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_METADATA), Backend.OutCfg);
                              Backend.Client.SendMessage(msg);

       TimerPos.Enabled := true;
    end;

end;

procedure TPlayer.jCustomDialog1Show(Sender: TObject; dialog: jObject;
  title: string);
begin

  jTextView1.Text := fTags.FileName;
  //  Artist.Text := Tags.Artist;
  //  Album.Text := Tags.Album;
    //album.Text := Tags.AlbumArtist;
  //  edGenre.Caption := Tags.Genre;
  //  Title.text := Tags.Title;
  //  jSeekBar1.Max:= Tags.Duration;
    //meComment.Lines.Clear;
    //meComment.Lines.Add(Tags.Comment);
    //
    //i := 0;
    //TryStrToInt(Tags.Year, i);
    //seYear.Value := i;
    //
    //i := 0;
    //TryStrToInt(Tags.TrackString, i);
    //
    //seTrack.Value := i;



end;

procedure TPlayer.jSeekBar1ProgressChanged(Sender: TObject; progress: integer;
  fromUser: boolean);
begin
  if fromUser then
    begin
      msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_SEEK, IntToStr(Progress)), Backend.OutCfg);
      backend.Client.SendMessage(msg);
    end;
end;

procedure TPlayer.jSeekBar1StartTrackingTouch(Sender: TObject; progress: integer
  );
begin
  FSeeking:= true;
  TimerPos.Enabled:=false;
end;

procedure TPlayer.jSeekBar1StopTrackingTouch(Sender: TObject; progress: integer
  );
begin
  FSeeking:= False;
  TimerPos.Enabled:=true;
end;

procedure TPlayer.PlayerClickOptionMenuItem(Sender: TObject;
  jObjMenuItem: jObject; itemID: integer; itemCaption: string; checked: boolean
  );
begin
  if itemid = 3000 then
    begin
        if playlist = nil then
    begin
      gApp.CreateForm(Tplaylist, playlist);
      Backend.ActiveForm:= playlist;
      playlist.Init(gApp);
    end
  else
    begin
      playlist.Show; //actRecyclable
    end;

    end;

end;

procedure TPlayer.PlayerClose(Sender: TObject);
begin
  jMenu1.Clear();  //clean up ...
end;

procedure TPlayer.PlayerCreateOptionMenu(Sender: TObject; jObjMenu: jObject);
begin
   jMenu1.AddItem(jObjMenu, 3000, 'PlayList', 'ic_queue_music_white_36dp', mitDefault, misIfRoomWithText);

end;

procedure TPlayer.bPlayClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PLAYPAUSE), Backend.OutCfg);
  Backend.Client.SendMessage(msg);

end;

procedure TPlayer.bNextClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_NEXT), Backend.OutCfg);
  Backend.Client.SendMessage(msg);
end;

procedure TPlayer.PlayerRotate(Sender: TObject; rotate: TScreenStyle);
begin

  pnlPlayer.MatchParent();

  if rotate = ssLandscape then
    begin
      pnlCover.LayoutParamHeight:=lpThreeFifthOfParent;
      pnlCover.LayoutParamWidth:= lpHalfOfParent;

      pnlInfo.PosRelativeToAnchor:=[raToRightOf];
      pnlInfo.PosRelativeToParent:=[rpTop];
      pnlInfo.LayoutParamHeight:=lpThreeFifthOfParent;
      pnlInfo.LayoutParamWidth:= lpHalfOfParent;

      pnlControls.LayoutParamHeight:=lpOneFifthOfParent;

    end
  Else
    begin
      pnlCover.LayoutParamHeight:=lpTwoFifthOfParent;
      pnlCover.LayoutParamWidth:= lpMatchParent;
      pnlInfo.LayoutParamHeight:=lpTwoFifthOfParent;
      pnlInfo.LayoutParamWidth:= lpMatchParent;
      pnlInfo.PosRelativeToAnchor:=[raBelow];
      pnlInfo.PosRelativeToParent:=[rpLeft];
      pnlControls.LayoutParamHeight:=lpOneFifthOfParent;

    end;
    pnlPlayer.ResetAllRules;
    pnlControls.ResetAllRules;

    pnlCover.ResetAllRules;
    pnlInfo.ResetAllRules;

  self.UpdateLayout;

end;

procedure TPlayer.pnlPlayerFlingGesture(Sender: TObject;
  flingGesture: TFlingGesture);
begin
  if flingGesture <> fliRightToLeft then
    exit;

  if playlist = nil then
    begin
      gApp.CreateForm(Tplaylist, playlist);
      Backend.ActiveForm:= playlist;
      playlist.Init(gApp);
    end
  else
    begin
      playlist.Show; //actRecyclable
    end;

end;

procedure TPlayer.TimerPosTimer(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_POSITION), Backend.OutCfg);
  backend.Client.SendMessage(msg);

end;

procedure TPlayer.TagsToMap(Tags:TCommonTags);
var
  i: integer;
begin
  fTags := Tags;
//  leFileName.Caption := Tags.FileName;
  Artist.Text := Tags.Artist;
  Album.Text := Tags.Album;
  //album.Text := Tags.AlbumArtist;
//  edGenre.Caption := Tags.Genre;
  Title.text := Tags.Title;
  jSeekBar1.Max:= Tags.Duration;
  //meComment.Lines.Clear;
  //meComment.Lines.Add(Tags.Comment);
  //
  //i := 0;
  //TryStrToInt(Tags.Year, i);
  //seYear.Value := i;
  //
  //i := 0;
  //TryStrToInt(Tags.TrackString, i);
  //
  //seTrack.Value := i;

end;

procedure TPlayer.DecodeImage(s: string);
var
  DecodedStream: TMemoryStream;
  EncodedStream: TStringStream;
  Decoder: TBase64DecodingStream;
  FImageBitmap: jObject;
  TempFileName: string;
begin
  EncodedStream := TStringStream.Create(S);
  DecodedStream := TMemoryStream.Create;
  Decoder       := TBase64DecodingStream.Create(EncodedStream);
  try
    DecodedStream.CopyFrom(Decoder, Decoder.Size);
    DecodedStream.Position:=0;
    TempFileName:= GetInternalAppStoragePath()+'/tmpcover';
    //LogDebug('OVOVOVOVO____',TempFileName);
    DecodedStream.SaveToFile(TempFileName);
    jBitmap1.LoadFromFile('tmpcover');
    CoverView.SetImageBitmap(jBitmap1.GetJavaBitmap);
  Except
    CoverView.SetImageBitmap(jBitmap1.LoadFromAssets('nocover.png'));
  end;
  DecodedStream.Free;
  EncodedStream.Free;
  Decoder.Free;
end;

Procedure TPlayer.HandleServerMessage(smessage:String);
var
  Command : RExternalCommand;
  tags: TCommonTags;
  s, Data: string;
  CurrPos: integer;
  NewState: TEngineState;
begin
//   LogDebug('OVOVOVO','_____GOT_DATA_'+smessage);
   Command := SplitCommand(sMessage);
   if (Command.Category = CATEGORY_INFORMATION) then
       if  Command.Command =
         INFO_METADATA then begin
                         tags := DecodeMetaData(Command.Param, Backend.InCfg);
                         TagsToMap(tags);
                       end
       else if Command.command =
         INFO_COVERURL then begin
                  //      if URIToFilename(Command.param,s) then
                  //         image1.Picture.LoadFromFile(s);
                     end
       else if Command.command =
       INFO_COVERIMG then begin
                         if Command.Param <> EmptyStr then
                           DecodeImage(Command.Param)
                         else
                           CoverView.SetImageBitmap(jBitmap1.LoadFromAssets('nocover.png'));
                   end

       else if (Command.command =
         INFO_POSITION)  then begin
                          if not FSeeking then
                            begin
                             CurrPos:= StrToInt(Command.Param);
                             jSeekBar1.Progress:= CURRPOS;
                             TVCurrPos.TEXT:= timeToStr(CurrPos / MSecsPerDay) + ' / ' +TimeToStr(jseekbar1.max / MSecsPerDay);
                           end
                         end

       else if Command.command =
         INFO_ENGINE_STATE then   Begin
                                 NewState:= TEngineState(StrToInt(Command.Param));
                                 if NewState = ENGINE_PLAY then
                                   begin
                                      msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_COVERIMG, EncodeImageSize(CoverView.Width, CoverView.Height)), Backend.OutCfg);
                                      Backend.Client.SendMessage(msg);
                                      bPlay.ImageUpIdentifier:='ic_pause_white_36dp';
                                      bPlay.ImageDownIdentifier:='ic_pause_grey600_36dp';
                                      TimerPos.Enabled:=true;
                                   end
                                 else
                                   begin
                                     TimerPos.Enabled:=False;
                                     bPlay.ImageUpIdentifier:='ic_play_arrow_white_36dp';
                                     bPlay.ImageDownIdentifier:='ic_play_arrow_grey600_36dp';
                                  end
                               end

    else
      Title.Text:= 'Got something else';
end;


end.
