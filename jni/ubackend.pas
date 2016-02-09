unit ubackend;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, AndroidWidget, tcpsocketclient, Laz_And_Controls, preferences, NetSupport;

type

  { TBackend }

  TBackend = class(TDataModule)
    Client: jTCPSocketClient;
    ConnectTest: jTimer;
    Pref: jPreferences;
    procedure ClientConnected(Sender: TObject);
    procedure ClientMessagesReceived(Sender: TObject;
      messagesReceived: array of pchar);
    procedure ConnectTestTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FInitialized: boolean;
    fRetryCount: integer;
  public
    ActiveForm: JForm;
    OutCfg: RConnectionCfg;
    InCfg: RConnectionCfg;
    Procedure LogDebug(tag, message:string);
    procedure Init(refApp: jApp);
    procedure TryConnect(Host: string; Port: integer);
  end;

var
  Backend: TBackend;

implementation

uses UConnect, uplayer, uplaylist, NetProtocol;

{$R *.lfm}

{ TBackend }

procedure TBackend.DataModuleCreate(Sender: TObject);
begin
  FInitialized:=false;
  OutCfg.SizeMode:=smByte;
  InCfg.SizeMode:=smUTF8Char;
end;

procedure TBackend.DataModuleDestroy(Sender: TObject);
begin
  Client.CloseConnection();
end;

procedure TBackend.LogDebug(tag, message: string);
begin
  if Assigned(ActiveForm) then
   ActiveForm.LogDebug(tag, message);
end;

procedure TBackend.ClientConnected(Sender: TObject);
begin

  ConnectTest.Enabled:=False;
  Client.SendMessage(EncodeString(BuildCommand(CATEGORY_CONFIG, COMMAND_SIZEMODE, '1'),OutCfg));
  Connect.OnConnectResult(true);


end;

procedure TBackend.ClientMessagesReceived(Sender: TObject;
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
      if ActiveForm = Player then
         Player.HandleServerMessage(s);
      if ActiveForm = PlayList then
         playlist.HandleServerMessage(s);

    end;

end;

procedure TBackend.ConnectTestTimer(Sender: TObject);
begin

  if fRetryCount > 4 then
  begin
    LogDebug('OVOVOVOVO', 'CONNECT FAIL');

    ConnectTest.Enabled:=false;
    Connect.OnConnectResult(false);
  end
else
  begin
    Inc(FretryCount);
  end;
end;

procedure TBackend.Init(refApp: jApp);
var
  i: integer;
begin
  if FInitialized  then Exit;
  if refApp = nil then Exit;
  if not refApp.Initialized then Exit;
  for i:= (Self.ComponentCount-1) downto 0 do
  begin
    if (Self.Components[i] is jControl) then
    begin
       (Self.Components[i] as jControl).Init(refApp);
    end;
  end;

end;

Procedure TBackend.TryConnect(Host: string; Port: integer);
begin
  fRetryCount := 0;
  ConnectTest.Enabled:=true;

  Client.ConnectAsync(Host, Port);

end;


initialization
  Backend := nil;

end.

