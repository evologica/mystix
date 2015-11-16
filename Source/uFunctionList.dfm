object FunctionListForm: TFunctionListForm
  Left = 297
  Top = 117
  BorderStyle = bsSizeToolWin
  Caption = 'Function List'
  ClientHeight = 283
  ClientWidth = 217
  Color = clBtnFace
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lvwFuncList: TListView
    Left = 0
    Top = 0
    Width = 217
    Height = 283
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        Caption = 'Line'
      end>
    RowSelect = True
    ShowColumnHeaders = False
    ShowWorkAreas = True
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnCompare = lvwFuncListCompare
    OnDblClick = lvwFuncListDblClick
    ExplicitWidth = 225
    ExplicitHeight = 288
  end
  object JvDockClient: TJvDockClient
    DirectDrag = False
    DockStyle = MainForm.JvDockVIDStyle1
    Left = 68
    Top = 140
  end
end
