{Hint: save all files to location: /jni }
unit uplayer;

{$mode delphi}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls, 
    Laz_And_Controls_Events, AndroidWidget, seekbar,
    basetypes, basetag,  netprotocol;

type

  { TPlayer }

  TPlayer = class(jForm)
    Album: jTextView;
    Artist: jTextView;
    bNext: jImageBtn;
    bPlay: jImageBtn;
    bPrev: jImageBtn;
    jImageView2: jImageView;
    jSeekBar1: jSeekBar;
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
    procedure jSeekBar1ProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jSeekBar1StartTrackingTouch(Sender: TObject; progress: integer);
    procedure jSeekBar1StopTrackingTouch(Sender: TObject; progress: integer);
    procedure PlayerJNIPrompt(Sender: TObject);
    procedure PlayerRotate(Sender: TObject; rotate: TScreenStyle);
    procedure TimerPosTimer(Sender: TObject);
  private
    FSeeking: boolean;
    msg: string;
    procedure TagsToMap(Tags: TCommonTags);
  public
    procedure HandleServerMessage(smessage: String);

  end;

var
  Player: TPlayer;

implementation
uses uBackend;
{$R *.lfm}
  

{ TPlayer }

procedure TPlayer.PlayerJNIPrompt(Sender: TObject);
begin
   pnlPlayer.MatchParent();
   FSeeking:= False;
   msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_ENGINE_STATE));
   Backend.Client.SendMessage(msg);
   msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_METADATA));
   Backend.Client.SendMessage(msg);
   Self.UpdateLayout;

end;

procedure TPlayer.bPrevClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PREVIOUS));
  Backend.Client.SendMessage(msg);
end;

procedure TPlayer.jSeekBar1ProgressChanged(Sender: TObject; progress: integer;
  fromUser: boolean);
begin
  if fromUser then
    begin
      msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_SEEK, IntToStr(Progress)));
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

procedure TPlayer.bPlayClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PLAYPAUSE));
  Backend.Client.SendMessage(msg);

end;

procedure TPlayer.bNextClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_NEXT));
  Backend.Client.SendMessage(msg);
end;

procedure TPlayer.PlayerRotate(Sender: TObject; rotate: TScreenStyle);
begin

  if rotate = ssLandscape then
    begin
      pnlCover.LayoutParamHeight:=lpMatchParent;
      pnlCover.LayoutParamWidth:= lpHalfOfParent;
      pnlInfo.PosRelativeToAnchor:=[raToRightOf];
      pnlInfo.PosRelativeToParent:=[rpTop];
      pnlInfo.LayoutParamHeight:=lpMatchParent;
      pnlInfo.LayoutParamWidth:= lpHalfOfParent;

    end
  Else
    begin
      pnlCover.LayoutParamHeight:=lpTwoFifthOfParent;
      pnlCover.LayoutParamWidth:= lpMatchParent;
      pnlInfo.LayoutParamHeight:=lpTwoFifthOfParent;
      pnlInfo.LayoutParamWidth:= lpMatchParent;
      pnlControls.LayoutParamHeight:=lpOneFifthOfParent;
      pnlInfo.PosRelativeToAnchor:=[raBelow];
      pnlInfo.PosRelativeToParent:=[rpLeft];

    end;
  pnlCover.ResetAllRules;
  pnlInfo.ResetAllRules;

  self.UpdateLayout;

end;

procedure TPlayer.TimerPosTimer(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_POSITION));
  backend.Client.SendMessage(msg);

end;

procedure TPlayer.TagsToMap(Tags:TCommonTags);
var
  i: integer;
begin
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

Procedure TPlayer.HandleServerMessage(smessage:String);
var
  r : RExternalCommand;
  tags: TCommonTags;
  s, Data: string;
  CurrPos: integer;
  NewState: TEngineState;
begin
   r := SplitCommand(sMessage);
   if (r.Category = CATEGORY_INFORMATION) then
       if  r.Command =
         INFO_METADATA then begin
                         tags := DecodeMetaData(r.Param);
                         TagsToMap(tags);
                       end
       else if r.command =
         INFO_COVER then begin
                  //      if URIToFilename(r.param,s) then
                  //         image1.Picture.LoadFromFile(s);
                     end
       else if (r.command =
         INFO_POSITION)  then begin
                          if not FSeeking then
                            begin
                             CurrPos:= StrToInt(r.Param);
                             jSeekBar1.Progress:= CURRPOS;
                             TVCurrPos.TEXT:= timeToStr(CurrPos / MSecsPerDay) + ' / ' +TimeToStr(jseekbar1.max / MSecsPerDay);
                           end
                         end

       else if r.command =
         INFO_ENGINE_STATE then   Begin
                                 NewState:= TEngineState(StrToInt(r.Param));
                                 if NewState = ENGINE_PLAY then
                                   begin
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
