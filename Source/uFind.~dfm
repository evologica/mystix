object FindDialog: TFindDialog
  Left = 326
  Top = 477
  AlphaBlend = True
  BorderStyle = bsDialog
  Caption = 'Find Text'
  ClientHeight = 165
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object lblFind: TLabel
    Left = 8
    Top = 12
    Width = 60
    Height = 13
    Caption = '&Text to find:'
    FocusControl = cmbFind
  end
  object cmbFind: TComboBox
    Left = 96
    Top = 8
    Width = 233
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    OnChange = cmbFindChange
  end
  object gbConditions: TGroupBox
    Left = 8
    Top = 36
    Width = 177
    Height = 121
    Caption = 'Conditions'
    TabOrder = 1
    object chkWhole: TCheckBox
      Left = 8
      Top = 16
      Width = 165
      Height = 17
      Caption = 'Match &whole words'
      TabOrder = 0
    end
    object chkCase: TCheckBox
      Left = 8
      Top = 36
      Width = 165
      Height = 17
      Caption = 'Match &case'
      TabOrder = 1
    end
    object chkRegExp: TCheckBox
      Left = 8
      Top = 56
      Width = 165
      Height = 17
      Caption = '&Regular expressions'
      TabOrder = 2
      OnClick = chkRegExpClick
    end
    object chkSelOnly: TCheckBox
      Left = 8
      Top = 76
      Width = 165
      Height = 17
      Caption = 'Only in selected text'
      TabOrder = 3
    end
    object chkFromCursor: TCheckBox
      Left = 8
      Top = 96
      Width = 165
      Height = 17
      Caption = 'Search from cursor'
      TabOrder = 4
    end
  end
  object chkInAll: TCheckBox
    Left = 192
    Top = 100
    Width = 137
    Height = 17
    Caption = '&In all documents'
    TabOrder = 3
  end
  object btnFindNext: TButton
    Left = 336
    Top = 8
    Width = 97
    Height = 25
    Caption = '&Find Next'
    Default = True
    TabOrder = 4
    OnClick = btnFindNextClick
  end
  object btnClose: TButton
    Left = 336
    Top = 100
    Width = 97
    Height = 25
    Caption = '&Close'
    TabOrder = 5
    OnClick = btnCloseClick
  end
  object btnHelp: TButton
    Left = 336
    Top = 132
    Width = 97
    Height = 25
    Caption = '&Help'
    TabOrder = 6
  end
  object gbDirection: TGroupBox
    Left = 192
    Top = 36
    Width = 137
    Height = 57
    Caption = 'Direction'
    TabOrder = 2
    object rbUp: TRadioButton
      Left = 8
      Top = 16
      Width = 121
      Height = 17
      Caption = '&Up'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbDown: TRadioButton
      Left = 8
      Top = 36
      Width = 121
      Height = 17
      Caption = '&Down'
      TabOrder = 1
    end
  end
end
