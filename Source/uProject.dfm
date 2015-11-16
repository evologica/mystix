object ProjectForm: TProjectForm
  Left = 192
  Top = 110
  Width = 696
  Height = 480
  Caption = 'ProjectForm'
  Color = clBtnFace
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object JvDockClient: TJvDockClient
    LRDockWidth = 100
    TBDockHeight = 100
    DirectDrag = True
    ShowHint = True
    EnableCloseButton = True
    DockStyle = JvDockVCStyle
    Left = 104
    Top = 164
  end
  object JvDockVCStyle: TJvDockVCStyle
    ConjoinServerOption.GrabbersSize = 12
    ConjoinServerOption.SplitterWidth = 4
    Left = 136
    Top = 164
  end
end
