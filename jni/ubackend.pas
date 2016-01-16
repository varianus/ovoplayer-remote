unit ubackend;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, AndroidWidget, tcpsocketclient, Laz_And_Controls, preferences;

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
    Procedure LogDebug(tag, message:string);
    procedure Init(refApp: jApp);
    procedure TryConnect(Host: string; Port: integer);
  end;

var
  Backend: TBackend;

implementation

uses UConnect, uplayer;

{$R *.lfm}

{ TBackend }

procedure TBackend.DataModuleCreate(Sender: TObject);
begin
  FInitialized:=false;
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
  LogDebug('OVOVOVOVO', 'CONNECT OK');

  ConnectTest.Enabled:=False;
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
      Player.HandleServerMessage(s);
    end;

end;

procedure TBackend.ConnectTestTimer(Sender: TObject);
begin
  LogDebug('OVOVOVOVO', 'TIMER');

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
  LogDebug('OVOVOVOVO', 'INIT DATAMODULE');
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
  LogDebug('OVOVOVOVO', 'TRY CONNECT');

  Client.ConnectAsync(Host, Port);

end;


initialization
  Backend := nil;

end.

