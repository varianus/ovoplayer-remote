{Hint: save all files to location: /home/varianus/source/ovoplayer-remote/jni }
unit UConnect;

{$mode Delphi}

interface

uses
  Classes, SysUtils, And_jni, And_jni_Bridge, Laz_And_Controls,
  Laz_And_Controls_Events, AndroidWidget, intentmanager, actionbartab,
  tcpsocketclient, seekbar, basetag, basetypes, preferences, menu;

type

  { TConnect }

  TConnect = class(jForm)
    Album: jTextView;
    Artist: jTextView;
    bNext: jImageBtn;
    bPlay: jImageBtn;
    bPrev: jImageBtn;
    jActionBarTab1: jActionBarTab;
    jMenu1: jMenu;
    pnlControls: jPanel;
    pnlInfo: jPanel;
    pnlCover: jPanel;
    jSeekBar1: jSeekBar;
    Title: jTextView;
    TVCurrPos: jTextView;
    bConnect: jButton;
    edtIPAddress: jEditText;
    jImageList1: jImageList;
    jImageView1: jImageView;
    jImageView2: jImageView;
    pnlConnection: jPanel;
    Message: jTextView;
    procedure bConnectClick(Sender: TObject);
    procedure ConnectClose(Sender: TObject);
    procedure ConnectCreateOptionMenu(Sender: TObject; jObjMenu: jObject);
    procedure ConnectDestroy(Sender: TObject);
    procedure ConnectJNIPrompt(Sender: TObject);
  private
    RetryCount: integer;
    msg: string;
    CurrState : TEngineState;
  public
    procedure OnConnectResult(Connected: boolean);
  end;

var
  Connect: TConnect;

implementation
uses
   netProtocol, ubackend, uplayer;
{$R *.lfm}

{ TConnect }

procedure TConnect.bConnectClick(Sender: TObject);
begin
  Backend.Pref.setStringData('LastAddress',edtIPAddress.Text);
  Message.Text:='Connecting ....';
  Connect.SetEnabled(False);

  Backend.TryConnect(edtIPAddress.Text, 6860);

end;

procedure TConnect.ConnectClose(Sender: TObject);
begin
  jMenu1.Clear();  //clean up ...
end;

procedure TConnect.ConnectCreateOptionMenu(Sender: TObject; jObjMenu: jObject);
begin
    jMenu1.AddItem(jObjMenu, 1000, 'Settings', 'ic_settings_white_36dp', mitDefault, misIfRoomWithText);
end;

procedure TConnect.ConnectDestroy(Sender: TObject);
begin
 Backend.Pref.setStringData('LastAddress',edtIPAddress.Text);
end;

procedure TConnect.ConnectJNIPrompt(Sender: TObject);
begin
 CustomColor:=$ffffffff;
 Self.SetIconActionBar('ic_launcher');

  if not Assigned(Backend) then
    begin
      Backend := TBackend.Create(Nil);
      Backend.Init(gApp);
    end;
 Backend.ActiveForm:=self;
 self.UpdateLayout;
 edtIPAddress.text := Backend.Pref.GetStringData('LastAddress','10.0.2.2');

 jMenu1.Clear();  //clean up ...
 jMenu1.InvalidateOptionsMenu();  //fire OnCreateOptionsMenu --> OnPrepareOptionsMenu to do form2 menu ...


end;

procedure TConnect.OnConnectResult(Connected: boolean);
begin
  if not Connected then
    Message.Text:= 'Connection Error'
  else
    begin
      Message.Text:= 'Connected';
      if Player = nil then
        begin
          gApp.CreateForm(TPlayer, Player);
          Backend.ActiveForm:= Player;
          Player.Init(gApp);
        end
      else
        begin
          Player.Show; //actRecyclable
        end;
    end;
  Connect.SetEnabled(true);
end;



end.
