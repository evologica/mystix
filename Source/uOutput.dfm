object OutputForm: TOutputForm
  Left = 408
  Top = 130
  Width = 398
  Height = 277
  BorderStyle = bsSizeToolWin
  Caption = 'OutputForm'
  Color = clBtnFace
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 390
    Height = 225
    Align = alClient
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object tbOutputs: TJvTabBar
    Left = 0
    Top = 225
    Width = 390
    Align = alBottom
    Orientation = toBottom
    AutoFreeClosed = False
    AllowTabMoving = True
    Tabs = <>
    Painter = JvModernTabBarPainter
  end
  object JvDockClient: TJvDockClient
    LRDockWidth = 100
    TBDockHeight = 100
    DirectDrag = False
    ShowHint = True
    EnableCloseButton = True
    DockStyle = MainForm.JvDockVIDStyle1
    Left = 68
    Top = 56
  end
  object JvModernTabBarPainter: TJvModernTabBarPainter
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    DisabledFont.Charset = DEFAULT_CHARSET
    DisabledFont.Color = clGrayText
    DisabledFont.Height = -11
    DisabledFont.Name = 'MS Sans Serif'
    DisabledFont.Style = []
    SelectedFont.Charset = EASTEUROPE_CHARSET
    SelectedFont.Color = clWindowText
    SelectedFont.Height = -11
    SelectedFont.Name = 'Tahoma'
    SelectedFont.Style = []
    Left = 100
    Top = 56
  end
end
