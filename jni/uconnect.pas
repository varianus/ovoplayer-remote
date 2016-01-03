{Hint: save all files to location: /home/varianus/source/ovoplayer-remote/jni }
unit UConnect;

{$mode Delphi}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls,
  Laz_And_Controls_Events, AndroidWidget, intentmanager, actionbartab,
  tcpsocketclient, seekbar, basetag, basetypes;

type

  { TConnect }

  TConnect = class(jForm)
    bNext: jImageBtn;
    bPlay: jImageBtn;
    bPrev: jImageBtn;
    jPanel4: jPanel;
    jSeekBar1: jSeekBar;
    TVCurrPos: jTextView;
    TimerPos: jTimer;
    Title: jTextView;
    bConnect: jButton;
    Client: jTCPSocketClient;
    ConnectTest: jTimer;
    edtIPAddress: jEditText;
    jActionBarTab1: jActionBarTab;
    jImageList1: jImageList;
    jImageView1: jImageView;
    jImageView2: jImageView;
    jPanel1: jPanel;
    jPanel2: jPanel;
    jPanel3: jPanel;
    Album: jTextView;
    Message: jTextView;
    Artist: jTextView;
    procedure bConnectClick(Sender: TObject);
    procedure ClientConnected(Sender: TObject);
    procedure ClientMessagesReceived(Sender: TObject;
      messagesReceived: array of Pchar);
    procedure ConnectJNIPrompt(Sender: TObject);
    procedure ConnectTestTimer(Sender: TObject);
    procedure bPrevClick(Sender: TObject);
    procedure bPlayClick(Sender: TObject);
    procedure bNextClick(Sender: TObject);
    procedure jSeekBar1ProgressChanged(Sender: TObject; progress: integer;
      fromUser: boolean);
    procedure jSeekBar1StartTrackingTouch(Sender: TObject; progress: integer);
    procedure jSeekBar1StopTrackingTouch(Sender: TObject; progress: integer);
    procedure TimerPosTimer(Sender: TObject);
  private
    RetryCount: integer;
    msg: string;
    CurrState : TEngineState;
    procedure HandleServerMEssage(smessage: String);
    procedure OnConnectResult(Connected: boolean);
    procedure TagsToMap(Tags: TCommonTags);
    function TryConnect(Host: string; Port: integer): boolean;
  public
    {public declarations}
  end;

var
  Connect: TConnect;

implementation
uses
   netProtocol;
{$R *.lfm}
  

{ TConnect }

procedure TConnect.bConnectClick(Sender: TObject);
begin

  Message.Text:='Connecting ....';
  Connect.SetEnabled(False);

  TryConnect(edtIPAddress.Text, 6860);

end;

procedure TConnect.ClientConnected(Sender: TObject);
begin
  LogDebug('OVOVOVOVO','Connected');
  ConnectTest.Enabled:=False;
  OnConnectResult(true);
end;

procedure TConnect.ClientMessagesReceived(Sender: TObject;
  messagesReceived: array of pchar);
var
  len:integer;
  i: integer;
  s: string;
begin
  len:= Length(messagesReceived);
  for i:= 0 to len-1 do
    begin
      s:= strpas(messagesReceived[i]);
      HandleServerMessage(s);
    end;
end;

procedure TConnect.ConnectJNIPrompt(Sender: TObject);
begin
 jPanel1.MatchParent();
 jPanel2.MatchParent();
 jPanel2.Visible:=false;
 jPanel1.Visible:=true;
end;

procedure TConnect.ConnectTestTimer(Sender: TObject);
begin
    if RetryCount > 4 then
    begin
      LogDebug('OVOVOVOVO','Done');
      ConnectTest.Enabled:=false;
      OnConnectResult(false);
    end
  else
    begin
      LogDebug('OVOVOVOVO','retry');
      Inc(retryCount);
    end;
end;

procedure TConnect.bPrevClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PREVIOUS));
  LogDebug('OVO_send',msg);
  Client.SendMessage(msg);
end;

procedure TConnect.bPlayClick(Sender: TObject);

begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_PLAYPAUSE));
  LogDebug('OVO_send',msg);
  Client.SendMessage(msg);

end;

procedure TConnect.bNextClick(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_NEXT));
  LogDebug('OVO_send',msg);
  Client.SendMessage(msg);

end;

procedure TConnect.jSeekBar1ProgressChanged(Sender: TObject; progress: integer;
  fromUser: boolean);
begin
  if fromUser then
    begin
      LogDebug('OVO_SEEK',IntToStr(Progress div 1000));
      msg := EncodeString(BuildCommand(CATEGORY_ACTION, COMMAND_SEEK, IntToStr(Progress div 1000)));
      Client.SendMessage(msg);
    end;
end;

procedure TConnect.jSeekBar1StartTrackingTouch(Sender: TObject;
  progress: integer);
begin
   LogDebug('OVO_LOCK','OFF');
  TimerPos.Enabled:=false;
end;

procedure TConnect.jSeekBar1StopTrackingTouch(Sender: TObject; progress: integer
  );
begin
     LogDebug('OVO_LOCK','ON');
    TimerPos.Enabled:=true;
end;

procedure TConnect.TimerPosTimer(Sender: TObject);
begin
  msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_POSITION));
  Client.SendMessage(msg);

end;

procedure TConnect.OnConnectResult(Connected: boolean);
begin
  if not Connected then
    Message.Text:= 'Connection Error'
  else
    begin
       Message.Text:= 'Connected';
       jPanel2.Visible:=true;
       jPanel1.Visible:=false;
       Sleep(100);
       msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_ENGINE_STATE));
       LogDebug('OVO_send',msg);
       Client.SendMessage(msg);
       msg := EncodeString(BuildCommand(CATEGORY_REQUEST, INFO_METADATA));
       LogDebug('OVO_send',msg);
       Client.SendMessage(msg);
    end;
  Connect.SetEnabled(true);
end;


procedure TConnect.TagsToMap(Tags:TCommonTags);
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


Procedure TConnect.HandleServerMessage(smessage:String);
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
                           LogDebug('OVOVOVOVO',smessage);
                           tags := DecodeMetaData(r.Param);
                           TagsToMap(tags);
                        end
       else if r.command =
         INFO_COVER then begin
                  //      if URIToFilename(r.param,s) then
                  //         image1.Picture.LoadFromFile(s);
                      end
       else if r.command =
         INFO_POSITION then begin
                          LogDebug('OVOVOVOVO',smessage);
                          CurrPos:= StrToInt(r.Param);
                          jSeekBar1.Progress:= CURRPOS;
                          TVCurrPos.TEXT:= timeToStr(CurrPos / MSecsPerDay) + ' / ' +TimeToStr(jseekbar1.max / MSecsPerDay);
                      end

       else if r.command =
         INFO_ENGINE_STATE then   Begin
                                 LogDebug('OVOVOVOVO',smessage);
                                 NewState:= TEngineState(StrToInt(r.Param));
                                 if NewState = ENGINE_PLAY then
                                   begin
                                      bPlay.ImageUpIdentifier:='media_playback_pause';
                                      bPlay.ImageDownIdentifier:='media_playback_pause';
                                      TimerPos.Enabled:=true;
                                   end
                                 else
                                   begin
                                     TimerPos.Enabled:=False;
                                     bPlay.ImageUpIdentifier:='media_playback_start';
                                     bPlay.ImageDownIdentifier:='media_playback_start';
                                  end
                               end

    else
      Title.Text:= 'Got something else';
end;


function TConnect.TryConnect(Host: string; Port: integer): boolean;
begin
  LogDebug('OVOVOVOVO','->Connect');
  RetryCount := 0;
  ConnectTest.Enabled:=true;
  Client.ConnectAsync(Host, Port);
  LogDebug('OVOVOVOVO','<-Connect');

end;

end.
