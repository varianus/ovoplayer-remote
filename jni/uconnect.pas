{Hint: save all files to location: /home/varianus/source/ovoplayer-remote/jni }
unit UConnect;

{$mode objfpc}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls,
  Laz_And_Controls_Events, AndroidWidget, intentmanager, actionbartab,
  tcpsocketclient, seekbar, basetag, basetypes;

type

  { TConnect }

  TConnect = class(jForm)
    Title: jTextView;
    bConnect: jButton;
    Client: jTCPSocketClient;
    ConnectTest: jTimer;
    edtIPAddress: jEditText;
    jActionBarTab1: jActionBarTab;
    bPrev: jImageBtn;
    bPlay: jImageBtn;
    bNext: jImageBtn;
    jImageList1: jImageList;
    jImageView1: jImageView;
    jImageView2: jImageView;
    jPanel1: jPanel;
    jPanel2: jPanel;
    jPanel3: jPanel;
    jSeekBar1: jSeekBar;
    Album: jTextView;
    Message: jTextView;
    Artist: jTextView;
    procedure bConnectClick(Sender: TObject);
    procedure ClientConnected(Sender: TObject);
    procedure ClientMessagesReceived(Sender: TObject;
      messagesReceived: array of pchar);
    procedure ConnectJNIPrompt(Sender: TObject);
    procedure ConnectTestTimer(Sender: TObject);
    procedure bPrevClick(Sender: TObject);
    procedure bPlayClick(Sender: TObject);
    procedure bNextClick(Sender: TObject);
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
      s:= StrPas(messagesReceived[i]);
      LogDebug('OVOVOVOVO',s);
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

procedure TConnect.OnConnectResult(Connected: boolean);
begin
  if not Connected then
    Message.Text:= 'Connection Error'
  else
    begin
       Message.Text:= 'Connected';
       jPanel2.Visible:=true;
       jPanel1.Visible:=false;
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
  DataSize: integer;
  NewState: TEngineState;
begin
   r := SplitCommand(sMessage);
   if (r.Category = CATEGORY_INFORMATION) then
       case r.Command of
         INFO_METADATA : begin
                           tags := DecodeMetaData(r.Param);
                           TagsToMap(tags);
                        end;
         INFO_COVER : begin
                  //      if URIToFilename(r.param,s) then
                  //         image1.Picture.LoadFromFile(s);
                      end;

         INFO_ENGINE_STATE :   Begin
                                 NewState:= TEngineState(StrToInt(r.Param));
                                 if NewState = ENGINE_PLAY then
                                   begin
                                      bPlay.ImageUpIdentifier:='media_playback_pause';
                                      bPlay.ImageDownIdentifier:='media_playback_pause';
                                   end
                                 else
                                   begin
                                     bPlay.ImageUpIdentifier:='media_playback_start';
                                     bPlay.ImageDownIdentifier:='media_playback_start';
                                  end
                               end

    else
      Title.Text:= 'Got something else';

  end;
  LogDebug('OVO_Get', 'Exit');
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
