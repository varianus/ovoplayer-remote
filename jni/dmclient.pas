unit dmClient;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, tcpsocketclient, Laz_And_Controls, AndroidWidget;
type

  { TCore }
  TTryConnectResult = procedure (Connected: boolean) of object;

  TCore = class(jForm)
    Client: jTCPSocketClient;
    ConnectTest: jTimer;
    jImageBtn1: jImageBtn;
    jImageBtn2: jImageBtn;
    jImageBtn3: jImageBtn;
    jImageList1: jImageList;
    jImageView1: jImageView;
    jPanel1: jPanel;
    procedure ClientConnected(Sender: TObject);
    procedure ClientMessagesReceived(Sender: TObject;
      messagesReceived: array of string);
    procedure ConnectTestTimer(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    RetryCount: integer;
    FOnConnectResult: TTryConnectResult;
    procedure SetOnConnectResult(AValue: TTryConnectResult);
    { private declarations }
  public
    Function TryConnect(Host: string; Port: integer): boolean;
    property OnConnectResult: TTryConnectResult read FOnConnectResult write SetOnConnectResult;
  end;

var
  Core: TCore;

implementation

{$R *.lfm}

{ TCore }

procedure TCore.ClientMessagesReceived(Sender: TObject;
  messagesReceived: array of string);
var
  len:integer;
  i: integer;
  s: string;
begin
  len:= Length(messagesReceived);
  for i:= 0 to len-1 do
    begin
      s:= (messagesReceived[i]);
      If Length(s) < 4 then break;
        //HandleServerMessage(s);
    end;
end;

procedure TCore.ConnectTestTimer(Sender: TObject);
begin
  if RetryCount > 4 then
    begin
      LogDebug('OVOVOVOVO','Done');
      ConnectTest.Enabled:=false;
      if Assigned(FOnConnectResult) then
        FOnConnectResult(false);
    end
  else
    begin
      LogDebug('OVOVOVOVO','retry');
      Inc(retryCount);
    end;
end;

procedure TCore.DataModuleCreate(Sender: TObject);
begin
  LogDebug('OVOVOVOVO', 'Creating1');

end;

procedure TCore.ClientConnected(Sender: TObject);
begin
  LogDebug('OVOVOVOVO','Connected');
  ConnectTest.Enabled:=False;
  if Assigned(FOnConnectResult) then
   FOnConnectResult(true);
end;

procedure TCore.SetOnConnectResult(AValue: TTryConnectResult);
begin
  FOnConnectResult := AValue;
end;

function TCore.TryConnect(Host: string; Port: integer): boolean;
begin
  LogDebug('OVOVOVOVO','->Connect');
  RetryCount := 0;
  ConnectTest.Enabled:=true;
  Client.ConnectAsync(Host, Port);
  LogDebug('OVOVOVOVO','<-Connect');

end;

end.

