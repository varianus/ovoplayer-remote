{hint: save all files to location: /home/varianus/source/ovoplayer_remote/jni/ }
library controls;  //[by Lamw: Lazarus Android Module Wizard: 28/12/2015 09:33:27]
  
{$mode delphi}
  
uses
  Classes, SysUtils, And_jni, And_jni_Bridge, AndroidWidget, Laz_And_Controls,
  Laz_And_Controls_Events, UConnect, uplayer, ubackend, uplaylist;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnTimer
  Signature: (J)V }
procedure pOnTimer(PEnv: PJNIEnv; this: JObject; pasobj: JLong); cdecl;
begin
  Java_Event_pOnTimer(PEnv,this,TObject(pasobj));
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnBroadcastReceiver
  Signature: (JLandroid/content/Intent;)V }
procedure pOnBroadcastReceiver(PEnv: PJNIEnv; this: JObject; pasobj: JLong; intent: JObject); cdecl;
begin
  Java_Event_pOnBroadcastReceiver(PEnv,this,TObject(pasobj),intent);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnCreate
  Signature: (Landroid/content/Context;Landroid/widget/RelativeLayout;)V }
procedure pAppOnCreate(PEnv: PJNIEnv; this: JObject; context: JObject; layout: JObject); cdecl;
begin
  Java_Event_pAppOnCreate(PEnv,this,context,layout);Connect.Init(gApp);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnScreenStyle
  Signature: ()I }
function pAppOnScreenStyle(PEnv: PJNIEnv; this: JObject): JInt; cdecl;
begin
  Result:=Java_Event_pAppOnScreenStyle(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnNewIntent
  Signature: ()V }
procedure pAppOnNewIntent(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnNewIntent(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnDestroy
  Signature: ()V }
procedure pAppOnDestroy(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnDestroy(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnPause
  Signature: ()V }
procedure pAppOnPause(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnPause(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnRestart
  Signature: ()V }
procedure pAppOnRestart(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnRestart(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnResume
  Signature: ()V }
procedure pAppOnResume(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnResume(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnStart
  Signature: ()V }
procedure pAppOnStart(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnStart(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnStop
  Signature: ()V }
procedure pAppOnStop(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnStop(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnBackPressed
  Signature: ()V }
procedure pAppOnBackPressed(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnBackPressed(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnRotate
  Signature: (I)I }
function pAppOnRotate(PEnv: PJNIEnv; this: JObject; rotate: JInt): JInt; cdecl;
begin
  Result:=Java_Event_pAppOnRotate(PEnv,this,rotate);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnConfigurationChanged
  Signature: ()V }
procedure pAppOnConfigurationChanged(PEnv: PJNIEnv; this: JObject); cdecl;
begin
  Java_Event_pAppOnConfigurationChanged(PEnv,this);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnActivityResult
  Signature: (IILandroid/content/Intent;)V }
procedure pAppOnActivityResult(PEnv: PJNIEnv; this: JObject; requestCode: JInt; resultCode: JInt; data: JObject); cdecl;
begin
  Java_Event_pAppOnActivityResult(PEnv,this,requestCode,resultCode,data);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnCreateOptionsMenu
  Signature: (Landroid/view/Menu;)V }
procedure pAppOnCreateOptionsMenu(PEnv: PJNIEnv; this: JObject; menu: JObject); cdecl;
begin
  Java_Event_pAppOnCreateOptionsMenu(PEnv,this,menu);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnClickOptionMenuItem
  Signature: (Landroid/view/MenuItem;ILjava/lang/String;Z)V }
procedure pAppOnClickOptionMenuItem(PEnv: PJNIEnv; this: JObject; menuItem: JObject; itemID: JInt; itemCaption: JString; checked: JBoolean); cdecl;
begin
  Java_Event_pAppOnClickOptionMenuItem(PEnv,this,menuItem,itemID,itemCaption,checked);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnPrepareOptionsMenu
  Signature: (Landroid/view/Menu;I)Z }
function pAppOnPrepareOptionsMenu(PEnv: PJNIEnv; this: JObject; menu: JObject; menuSize: JInt): JBoolean; cdecl;
begin
  Result:=Java_Event_pAppOnPrepareOptionsMenu(PEnv,this,menu,menuSize);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnPrepareOptionsMenuItem
  Signature: (Landroid/view/Menu;Landroid/view/MenuItem;I)Z }
function pAppOnPrepareOptionsMenuItem(PEnv: PJNIEnv; this: JObject; menu: JObject; menuItem: JObject; itemIndex: JInt): JBoolean; cdecl;
begin
  Result:=Java_Event_pAppOnPrepareOptionsMenuItem(PEnv,this,menu,menuItem,itemIndex);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnCreateContextMenu
  Signature: (Landroid/view/ContextMenu;)V }
procedure pAppOnCreateContextMenu(PEnv: PJNIEnv; this: JObject; menu: JObject); cdecl;
begin
  Java_Event_pAppOnCreateContextMenu(PEnv,this,menu);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnClickContextMenuItem
  Signature: (Landroid/view/MenuItem;ILjava/lang/String;Z)V }
procedure pAppOnClickContextMenuItem(PEnv: PJNIEnv; this: JObject; menuItem: JObject; itemID: JInt; itemCaption: JString; checked: JBoolean); cdecl;
begin
  Java_Event_pAppOnClickContextMenuItem(PEnv,this,menuItem,itemID,itemCaption,checked);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnDraw
  Signature: (JLandroid/graphics/Canvas;)V }
procedure pOnDraw(PEnv: PJNIEnv; this: JObject; pasobj: JLong; canvas: JObject); cdecl;
begin
  Java_Event_pOnDraw(PEnv,this,TObject(pasobj),canvas);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnTouch
  Signature: (JIIFFFF)V }
procedure pOnTouch(PEnv: PJNIEnv; this: JObject; pasobj: JLong; act: JInt; cnt: JInt; x1: JFloat; y1: JFloat; x2: JFloat; y2: JFloat); cdecl;
begin
  Java_Event_pOnTouch(PEnv,this,TObject(pasobj),act,cnt,x1,y1,x2,y2);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnClickGeneric
  Signature: (JI)V }
procedure pOnClickGeneric(PEnv: PJNIEnv; this: JObject; pasobj: JLong; value: JInt); cdecl;
begin
  Java_Event_pOnClickGeneric(PEnv,this,TObject(pasobj),value);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnSpecialKeyDown
  Signature: (CILjava/lang/String;)Z }
function pAppOnSpecialKeyDown(PEnv: PJNIEnv; this: JObject; keyChar: JChar; keyCode: JInt; keyCodeString: JString): JBoolean; cdecl;
begin
  Result:=Java_Event_pAppOnSpecialKeyDown(PEnv,this,keyChar,keyCode,keyCodeString);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnClick
  Signature: (JI)V }
procedure pOnClick(PEnv: PJNIEnv; this: JObject; pasobj: JLong; value: JInt); cdecl;
begin
  Java_Event_pOnClick(PEnv,this,TObject(pasobj),value);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnChange
  Signature: (JLjava/lang/String;I)V }
procedure pOnChange(PEnv: PJNIEnv; this: JObject; pasobj: JLong; txt: JString; count: JInt); cdecl;
begin
  Java_Event_pOnChange(PEnv,this,TObject(pasobj),txt,count);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnChanged
  Signature: (JLjava/lang/String;I)V }
procedure pOnChanged(PEnv: PJNIEnv; this: JObject; pasobj: JLong; txt: JString; count: JInt); cdecl;
begin
  Java_Event_pOnChanged(PEnv,this,TObject(pasobj),txt,count);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnEnter
  Signature: (J)V }
procedure pOnEnter(PEnv: PJNIEnv; this: JObject; pasobj: JLong); cdecl;
begin
  Java_Event_pOnEnter(PEnv,this,TObject(pasobj));
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnClose
  Signature: (J)V }
procedure pOnClose(PEnv: PJNIEnv; this: JObject; pasobj: JLong); cdecl;
begin
  Java_Event_pOnClose(PEnv,this,TObject(pasobj));
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnViewClick
  Signature: (Landroid/view/View;I)V }
procedure pAppOnViewClick(PEnv: PJNIEnv; this: JObject; view: JObject; id: JInt); cdecl;
begin
  Java_Event_pAppOnViewClick(PEnv,this,view,id);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pAppOnListItemClick
  Signature: (Landroid/widget/AdapterView;Landroid/view/View;II)V }
procedure pAppOnListItemClick(PEnv: PJNIEnv; this: JObject; adapter: JObject; view: JObject; position: JInt; id: JInt); cdecl;
begin
  Java_Event_pAppOnListItemClick(PEnv,this,adapter,view,position,id);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnFlingGestureDetected
  Signature: (JI)V }
procedure pOnFlingGestureDetected(PEnv: PJNIEnv; this: JObject; pasobj: JLong; direction: JInt); cdecl;
begin
  Java_Event_pOnFlingGestureDetected(PEnv,this,TObject(pasobj),direction);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnPinchZoomGestureDetected
  Signature: (JFI)V }
procedure pOnPinchZoomGestureDetected(PEnv: PJNIEnv; this: JObject; pasobj: JLong; scaleFactor: JFloat; state: JInt); cdecl;
begin
  Java_Event_pOnPinchZoomGestureDetected(PEnv,this,TObject(pasobj),scaleFactor,state);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnSeekBarProgressChanged
  Signature: (JIZ)V }
procedure pOnSeekBarProgressChanged(PEnv: PJNIEnv; this: JObject; pasobj: JLong; progress: JInt; fromUser: JBoolean); cdecl;
begin
  Java_Event_pOnSeekBarProgressChanged(PEnv,this,TObject(pasobj),progress,fromUser);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnSeekBarStartTrackingTouch
  Signature: (JI)V }
procedure pOnSeekBarStartTrackingTouch(PEnv: PJNIEnv; this: JObject; pasobj: JLong; progress: JInt); cdecl;
begin
  Java_Event_pOnSeekBarStartTrackingTouch(PEnv,this,TObject(pasobj),progress);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnSeekBarStopTrackingTouch
  Signature: (JI)V }
procedure pOnSeekBarStopTrackingTouch(PEnv: PJNIEnv; this: JObject; pasobj: JLong; progress: JInt); cdecl;
begin
  Java_Event_pOnSeekBarStopTrackingTouch(PEnv,this,TObject(pasobj),progress);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnTCPSocketClientMessageReceived
  Signature: (J[Ljava/lang/String;)V }
procedure pOnTCPSocketClientMessageReceived(PEnv: PJNIEnv; this: JObject; pasobj: JLong; messagesReceived: JStringArray); cdecl;
begin
  Java_Event_pOnTCPSocketClientMessageReceived(PEnv,this,TObject(pasobj),messagesReceived);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnTCPSocketClientConnected
  Signature: (J)V }
procedure pOnTCPSocketClientConnected(PEnv: PJNIEnv; this: JObject; pasobj: JLong); cdecl;
begin
  Java_Event_pOnTCPSocketClientConnected(PEnv,this,TObject(pasobj));
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnClickWidgetItem
  Signature: (JIZ)V }
procedure pOnClickWidgetItem(PEnv: PJNIEnv; this: JObject; pasobj: JLong; position: JInt; checked: JBoolean); cdecl;
begin
  Java_Event_pOnClickWidgetItem(PEnv,this,TObject(pasobj),position,checked);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnClickCaptionItem
  Signature: (JILjava/lang/String;)V }
procedure pOnClickCaptionItem(PEnv: PJNIEnv; this: JObject; pasobj: JLong; position: JInt; caption: JString); cdecl;
begin
  Java_Event_pOnClickCaptionItem(PEnv,this,TObject(pasobj),position,caption);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnListViewLongClickCaptionItem
  Signature: (JILjava/lang/String;)V }
procedure pOnListViewLongClickCaptionItem(PEnv: PJNIEnv; this: JObject; pasobj: JLong; position: JInt; caption: JString); cdecl;
begin
  Java_Event_pOnListViewLongClickCaptionItem(PEnv,this,TObject(pasobj),position,caption);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnListViewDrawItemCaptionColor
  Signature: (JILjava/lang/String;)I }
function pOnListViewDrawItemCaptionColor(PEnv: PJNIEnv; this: JObject; pasobj: JLong; position: JInt; caption: JString): JInt; cdecl;
begin
  Result:=Java_Event_pOnListViewDrawItemCaptionColor(PEnv,this,TObject(pasobj),position,caption);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnListViewDrawItemBitmap
  Signature: (JILjava/lang/String;)Landroid/graphics/Bitmap; }
function pOnListViewDrawItemBitmap(PEnv: PJNIEnv; this: JObject; pasobj: JLong; position: JInt; caption: JString): JObject; cdecl;
begin
  Result:=Java_Event_pOnListViewDrawItemBitmap(PEnv,this,TObject(pasobj),position,caption);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnActionBarTabSelected
  Signature: (JLandroid/view/View;Ljava/lang/String;)V }
procedure pOnActionBarTabSelected(PEnv: PJNIEnv; this: JObject; pasobj: JLong; view: JObject; title: JString); cdecl;
begin
  Java_Event_pOnActionBarTabSelected(PEnv,this,TObject(pasobj),view,title);
end;

{ Class:     org_varianus_ovoplayer_remote_Controls
  Method:    pOnActionBarTabUnSelected
  Signature: (JLandroid/view/View;Ljava/lang/String;)V }
procedure pOnActionBarTabUnSelected(PEnv: PJNIEnv; this: JObject; pasobj: JLong; view: JObject; title: JString); cdecl;
begin
  Java_Event_pOnActionBarTabUnSelected(PEnv,this,TObject(pasobj),view,title);
end;

const NativeMethods:array[0..45] of JNINativeMethod = (
   (name:'pOnTimer';
    signature:'(J)V';
    fnPtr:@pOnTimer;),
   (name:'pOnBroadcastReceiver';
    signature:'(JLandroid/content/Intent;)V';
    fnPtr:@pOnBroadcastReceiver;),
   (name:'pAppOnCreate';
    signature:'(Landroid/content/Context;Landroid/widget/RelativeLayout;)V';
    fnPtr:@pAppOnCreate;),
   (name:'pAppOnScreenStyle';
    signature:'()I';
    fnPtr:@pAppOnScreenStyle;),
   (name:'pAppOnNewIntent';
    signature:'()V';
    fnPtr:@pAppOnNewIntent;),
   (name:'pAppOnDestroy';
    signature:'()V';
    fnPtr:@pAppOnDestroy;),
   (name:'pAppOnPause';
    signature:'()V';
    fnPtr:@pAppOnPause;),
   (name:'pAppOnRestart';
    signature:'()V';
    fnPtr:@pAppOnRestart;),
   (name:'pAppOnResume';
    signature:'()V';
    fnPtr:@pAppOnResume;),
   (name:'pAppOnStart';
    signature:'()V';
    fnPtr:@pAppOnStart;),
   (name:'pAppOnStop';
    signature:'()V';
    fnPtr:@pAppOnStop;),
   (name:'pAppOnBackPressed';
    signature:'()V';
    fnPtr:@pAppOnBackPressed;),
   (name:'pAppOnRotate';
    signature:'(I)I';
    fnPtr:@pAppOnRotate;),
   (name:'pAppOnConfigurationChanged';
    signature:'()V';
    fnPtr:@pAppOnConfigurationChanged;),
   (name:'pAppOnActivityResult';
    signature:'(IILandroid/content/Intent;)V';
    fnPtr:@pAppOnActivityResult;),
   (name:'pAppOnCreateOptionsMenu';
    signature:'(Landroid/view/Menu;)V';
    fnPtr:@pAppOnCreateOptionsMenu;),
   (name:'pAppOnClickOptionMenuItem';
    signature:'(Landroid/view/MenuItem;ILjava/lang/String;Z)V';
    fnPtr:@pAppOnClickOptionMenuItem;),
   (name:'pAppOnPrepareOptionsMenu';
    signature:'(Landroid/view/Menu;I)Z';
    fnPtr:@pAppOnPrepareOptionsMenu;),
   (name:'pAppOnPrepareOptionsMenuItem';
    signature:'(Landroid/view/Menu;Landroid/view/MenuItem;I)Z';
    fnPtr:@pAppOnPrepareOptionsMenuItem;),
   (name:'pAppOnCreateContextMenu';
    signature:'(Landroid/view/ContextMenu;)V';
    fnPtr:@pAppOnCreateContextMenu;),
   (name:'pAppOnClickContextMenuItem';
    signature:'(Landroid/view/MenuItem;ILjava/lang/String;Z)V';
    fnPtr:@pAppOnClickContextMenuItem;),
   (name:'pOnDraw';
    signature:'(JLandroid/graphics/Canvas;)V';
    fnPtr:@pOnDraw;),
   (name:'pOnTouch';
    signature:'(JIIFFFF)V';
    fnPtr:@pOnTouch;),
   (name:'pOnClickGeneric';
    signature:'(JI)V';
    fnPtr:@pOnClickGeneric;),
   (name:'pAppOnSpecialKeyDown';
    signature:'(CILjava/lang/String;)Z';
    fnPtr:@pAppOnSpecialKeyDown;),
   (name:'pOnClick';
    signature:'(JI)V';
    fnPtr:@pOnClick;),
   (name:'pOnChange';
    signature:'(JLjava/lang/String;I)V';
    fnPtr:@pOnChange;),
   (name:'pOnChanged';
    signature:'(JLjava/lang/String;I)V';
    fnPtr:@pOnChanged;),
   (name:'pOnEnter';
    signature:'(J)V';
    fnPtr:@pOnEnter;),
   (name:'pOnClose';
    signature:'(J)V';
    fnPtr:@pOnClose;),
   (name:'pAppOnViewClick';
    signature:'(Landroid/view/View;I)V';
    fnPtr:@pAppOnViewClick;),
   (name:'pAppOnListItemClick';
    signature:'(Landroid/widget/AdapterView;Landroid/view/View;II)V';
    fnPtr:@pAppOnListItemClick;),
   (name:'pOnFlingGestureDetected';
    signature:'(JI)V';
    fnPtr:@pOnFlingGestureDetected;),
   (name:'pOnPinchZoomGestureDetected';
    signature:'(JFI)V';
    fnPtr:@pOnPinchZoomGestureDetected;),
   (name:'pOnSeekBarProgressChanged';
    signature:'(JIZ)V';
    fnPtr:@pOnSeekBarProgressChanged;),
   (name:'pOnSeekBarStartTrackingTouch';
    signature:'(JI)V';
    fnPtr:@pOnSeekBarStartTrackingTouch;),
   (name:'pOnSeekBarStopTrackingTouch';
    signature:'(JI)V';
    fnPtr:@pOnSeekBarStopTrackingTouch;),
   (name:'pOnTCPSocketClientMessageReceived';
    signature:'(J[Ljava/lang/String;)V';
    fnPtr:@pOnTCPSocketClientMessageReceived;),
   (name:'pOnTCPSocketClientConnected';
    signature:'(J)V';
    fnPtr:@pOnTCPSocketClientConnected;),
   (name:'pOnClickWidgetItem';
    signature:'(JIZ)V';
    fnPtr:@pOnClickWidgetItem;),
   (name:'pOnClickCaptionItem';
    signature:'(JILjava/lang/String;)V';
    fnPtr:@pOnClickCaptionItem;),
   (name:'pOnListViewLongClickCaptionItem';
    signature:'(JILjava/lang/String;)V';
    fnPtr:@pOnListViewLongClickCaptionItem;),
   (name:'pOnListViewDrawItemCaptionColor';
    signature:'(JILjava/lang/String;)I';
    fnPtr:@pOnListViewDrawItemCaptionColor;),
   (name:'pOnListViewDrawItemBitmap';
    signature:'(JILjava/lang/String;)Landroid/graphics/Bitmap;';
    fnPtr:@pOnListViewDrawItemBitmap;),
   (name:'pOnActionBarTabSelected';
    signature:'(JLandroid/view/View;Ljava/lang/String;)V';
    fnPtr:@pOnActionBarTabSelected;),
   (name:'pOnActionBarTabUnSelected';
    signature:'(JLandroid/view/View;Ljava/lang/String;)V';
    fnPtr:@pOnActionBarTabUnSelected;)
);

function RegisterNativeMethodsArray(PEnv: PJNIEnv; className: PChar; methods: PJNINativeMethod; countMethods:integer):integer;
var
  curClass: jClass;
begin
  Result:= JNI_FALSE;
  curClass:= (PEnv^).FindClass(PEnv, className);
  if curClass <> nil then
  begin
    if (PEnv^).RegisterNatives(PEnv, curClass, methods, countMethods) > 0 then Result:= JNI_TRUE;
  end;
end;

function RegisterNativeMethods(PEnv: PJNIEnv; className: PChar): integer;
begin
  Result:= RegisterNativeMethodsArray(PEnv, className, @NativeMethods[0], Length(NativeMethods));
end;

function JNI_OnLoad(VM: PJavaVM; reserved: pointer): JInt; cdecl;
var
  PEnv: PPointer;
  curEnv: PJNIEnv;
begin
  PEnv:= nil;
  Result:= JNI_VERSION_1_6;
  (VM^).GetEnv(VM, @PEnv, Result);
  if PEnv <> nil then
  begin
     curEnv:= PJNIEnv(PEnv);
     RegisterNativeMethods(curEnv, 'org/varianus/ovoplayer_remote/Controls');
  end;
  gVM:= VM; {AndroidWidget.pas}
end;

procedure JNI_OnUnload(VM: PJavaVM; reserved: pointer); cdecl;
var
  PEnv: PPointer;
  curEnv: PJNIEnv;
begin
  PEnv:= nil;
  (VM^).GetEnv(VM, @PEnv, JNI_VERSION_1_6);
  if PEnv <> nil then
  begin
    curEnv:= PJNIEnv(PEnv);
    (curEnv^).DeleteGlobalRef(curEnv, gjClass);
    gjClass:= nil; {AndroidWidget.pas}
    gVM:= nil; {AndroidWidget.pas}
  end;
  gApp.Terminate;
  FreeAndNil(gApp);
end;

exports
  JNI_OnLoad name 'JNI_OnLoad',
  JNI_OnUnload name 'JNI_OnUnload',
  pOnTimer name 'Java_org_varianus_ovoplayer_remote_Controls_pOnTimer',
  pOnBroadcastReceiver name 'Java_org_varianus_ovoplayer_remote_Controls_pOnBroadcastReceiver',
  pAppOnCreate name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnCreate',
  pAppOnScreenStyle name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnScreenStyle',
  pAppOnNewIntent name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnNewIntent',
  pAppOnDestroy name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnDestroy',
  pAppOnPause name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnPause',
  pAppOnRestart name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnRestart',
  pAppOnResume name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnResume',
  pAppOnStart name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnStart',
  pAppOnStop name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnStop',
  pAppOnBackPressed name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnBackPressed',
  pAppOnRotate name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnRotate',
  pAppOnConfigurationChanged name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnConfigurationChanged',
  pAppOnActivityResult name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnActivityResult',
  pAppOnCreateOptionsMenu name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnCreateOptionsMenu',
  pAppOnClickOptionMenuItem name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnClickOptionMenuItem',
  pAppOnPrepareOptionsMenu name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnPrepareOptionsMenu',
  pAppOnPrepareOptionsMenuItem name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnPrepareOptionsMenuItem',
  pAppOnCreateContextMenu name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnCreateContextMenu',
  pAppOnClickContextMenuItem name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnClickContextMenuItem',
  pOnDraw name 'Java_org_varianus_ovoplayer_remote_Controls_pOnDraw',
  pOnTouch name 'Java_org_varianus_ovoplayer_remote_Controls_pOnTouch',
  pOnClickGeneric name 'Java_org_varianus_ovoplayer_remote_Controls_pOnClickGeneric',
  pAppOnSpecialKeyDown name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnSpecialKeyDown',
  pOnClick name 'Java_org_varianus_ovoplayer_remote_Controls_pOnClick',
  pOnChange name 'Java_org_varianus_ovoplayer_remote_Controls_pOnChange',
  pOnChanged name 'Java_org_varianus_ovoplayer_remote_Controls_pOnChanged',
  pOnEnter name 'Java_org_varianus_ovoplayer_remote_Controls_pOnEnter',
  pOnClose name 'Java_org_varianus_ovoplayer_remote_Controls_pOnClose',
  pAppOnViewClick name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnViewClick',
  pAppOnListItemClick name 'Java_org_varianus_ovoplayer_remote_Controls_pAppOnListItemClick',
  pOnFlingGestureDetected name 'Java_org_varianus_ovoplayer_remote_Controls_pOnFlingGestureDetected',
  pOnPinchZoomGestureDetected name 'Java_org_varianus_ovoplayer_remote_Controls_pOnPinchZoomGestureDetected',
  pOnSeekBarProgressChanged name 'Java_org_varianus_ovoplayer_remote_Controls_pOnSeekBarProgressChanged',
  pOnSeekBarStartTrackingTouch name 'Java_org_varianus_ovoplayer_remote_Controls_pOnSeekBarStartTrackingTouch',
  pOnSeekBarStopTrackingTouch name 'Java_org_varianus_ovoplayer_remote_Controls_pOnSeekBarStopTrackingTouch',
  pOnTCPSocketClientMessageReceived name 'Java_org_varianus_ovoplayer_remote_Controls_pOnTCPSocketClientMessageReceived',
  pOnTCPSocketClientConnected name 'Java_org_varianus_ovoplayer_remote_Controls_pOnTCPSocketClientConnected',
  pOnClickWidgetItem name 'Java_org_varianus_ovoplayer_remote_Controls_pOnClickWidgetItem',
  pOnClickCaptionItem name 'Java_org_varianus_ovoplayer_remote_Controls_pOnClickCaptionItem',
  pOnListViewLongClickCaptionItem name 'Java_org_varianus_ovoplayer_remote_Controls_pOnListViewLongClickCaptionItem',
  pOnListViewDrawItemCaptionColor name 'Java_org_varianus_ovoplayer_remote_Controls_pOnListViewDrawItemCaptionColor',
  pOnListViewDrawItemBitmap name 'Java_org_varianus_ovoplayer_remote_Controls_pOnListViewDrawItemBitmap',
  pOnActionBarTabSelected name 'Java_org_varianus_ovoplayer_remote_Controls_pOnActionBarTabSelected',
  pOnActionBarTabUnSelected name 'Java_org_varianus_ovoplayer_remote_Controls_pOnActionBarTabUnSelected';

begin
  gApp:= jApp.Create(nil);{AndroidWidget.pas}
  gApp.Title:= 'My Android Bridges Library';
  gjAppName:= 'org.varianus.ovoplayer_remote';{AndroidWidget.pas}
  gjClassName:= 'org/varianus/ovoplayer_remote/Controls';{AndroidWidget.pas}
  gApp.AppName:=gjAppName;
  gApp.ClassName:=gjClassName;
  gApp.Initialize;
  gApp.CreateForm(TConnect, Connect);
end.
