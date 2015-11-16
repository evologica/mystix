object OptionsDialog: TOptionsDialog
  Left = 305
  Top = 141
  ActiveControl = chkSaveWindowPos
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 482
  ClientWidth = 501
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pctrlOptions: TPageControl
    Left = 8
    Top = 8
    Width = 485
    Height = 429
    ActivePage = tsGeneral
    TabIndex = 0
    TabOrder = 0
    object tsGeneral: TTabSheet
      Caption = 'General'
      object lblInterfaceLanguage: TLabel
        Left = 4
        Top = 112
        Width = 96
        Height = 13
        Caption = 'Interface language:'
      end
      object lblDefExtension: TLabel
        Left = 4
        Top = 168
        Width = 89
        Height = 13
        Caption = 'Default extension:'
      end
      object lblDefDocumentType: TLabel
        Left = 4
        Top = 140
        Width = 114
        Height = 13
        Caption = 'Default document type:'
      end
      object chkSaveWindowPos: TCheckBox
        Left = 4
        Top = 24
        Width = 333
        Height = 17
        Caption = 'Save main window position on exit'
        TabOrder = 0
      end
      object cmbLanguage: TComboBox
        Left = 148
        Top = 108
        Width = 141
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
      end
      object txtDefExt: TEdit
        Left = 224
        Top = 164
        Width = 65
        Height = 21
        TabOrder = 6
      end
      object chkReopenWorkspace: TCheckBox
        Left = 4
        Top = 44
        Width = 333
        Height = 17
        Caption = 'Reopen last workspace'
        TabOrder = 1
      end
      object chkReopenLastFiles: TCheckBox
        Left = 4
        Top = 64
        Width = 333
        Height = 17
        Caption = 'Reopen last open files'
        TabOrder = 2
      end
      object chkCreateEmpty: TCheckBox
        Left = 4
        Top = 84
        Width = 333
        Height = 17
        Caption = 'Create empty document at startup'
        TabOrder = 3
      end
      object cmbDocType: TComboBox
        Left = 148
        Top = 136
        Width = 141
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
      end
      object chkOneCopy: TCheckBox
        Left = 4
        Top = 4
        Width = 333
        Height = 17
        Caption = 'Allow to run only one copy'
        TabOrder = 7
      end
    end
    object tsEditor: TTabSheet
      Caption = 'Editor'
      ImageIndex = 1
      object gbGeneral: TGroupBox
        Left = 4
        Top = 4
        Width = 469
        Height = 253
        Caption = 'General options'
        TabOrder = 0
        object lblActiveLine: TLabel
          Left = 8
          Top = 140
          Width = 79
          Height = 13
          Caption = 'Active line color:'
        end
        object lblExtraLine: TLabel
          Left = 8
          Top = 168
          Width = 88
          Height = 13
          Caption = 'Extra line spacing:'
        end
        object lblInsertCaret: TLabel
          Left = 236
          Top = 140
          Width = 90
          Height = 13
          Caption = 'Insert mode caret:'
        end
        object lblOverwriteCaret: TLabel
          Left = 236
          Top = 168
          Width = 109
          Height = 13
          Caption = 'Overwrite mode caret:'
        end
        object lblMaxUndo: TLabel
          Left = 8
          Top = 196
          Width = 75
          Height = 13
          Caption = 'Maximum undo:'
        end
        object lblTabWidth: TLabel
          Left = 236
          Top = 224
          Width = 51
          Height = 13
          Caption = 'Tab width:'
        end
        object lblFoldingButton: TLabel
          Left = 236
          Top = 196
          Width = 99
          Height = 13
          Caption = 'Folding button style:'
        end
        object chkAutoIndent: TCheckBox
          Left = 8
          Top = 16
          Width = 221
          Height = 17
          Caption = 'Auto indent'
          TabOrder = 0
        end
        object chkGroupUndo: TCheckBox
          Left = 8
          Top = 56
          Width = 221
          Height = 17
          Caption = 'Group undo'
          TabOrder = 2
        end
        object chkHighlightLine: TCheckBox
          Left = 8
          Top = 76
          Width = 221
          Height = 17
          Caption = 'Highlight active line'
          TabOrder = 3
        end
        object chkInsertMode: TCheckBox
          Left = 8
          Top = 116
          Width = 221
          Height = 17
          Caption = 'Insert mode'
          TabOrder = 5
        end
        object chkScrollPastEOF: TCheckBox
          Left = 236
          Top = 16
          Width = 221
          Height = 17
          Caption = 'Scroll past EOF'
          TabOrder = 6
        end
        object chkScrollPastEOL: TCheckBox
          Left = 236
          Top = 36
          Width = 221
          Height = 17
          Caption = 'Scroll past EOL'
          TabOrder = 7
        end
        object chkIndentGuides: TCheckBox
          Left = 236
          Top = 56
          Width = 221
          Height = 17
          Caption = 'Show indent guides'
          TabOrder = 8
        end
        object chkSpecialCharacters: TCheckBox
          Left = 236
          Top = 76
          Width = 221
          Height = 17
          Caption = 'Show special characters'
          TabOrder = 9
        end
        object chkTabsToSpaces: TCheckBox
          Left = 236
          Top = 96
          Width = 221
          Height = 17
          Caption = 'Tabs to spaces'
          TabOrder = 10
        end
        object chkWordWrap: TCheckBox
          Left = 236
          Top = 116
          Width = 221
          Height = 17
          Caption = 'Word wrap'
          TabOrder = 11
        end
        object cbActiveLine: TColorBox
          Left = 124
          Top = 136
          Width = 105
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 12
        end
        object Edit2: TEdit
          Left = 180
          Top = 164
          Width = 33
          Height = 21
          TabOrder = 13
          Text = '0'
        end
        object udExtraSpacing: TUpDown
          Left = 213
          Top = 164
          Width = 15
          Height = 21
          Associate = Edit2
          Min = 0
          Max = 60
          Position = 0
          TabOrder = 14
          Wrap = False
        end
        object cmbInsertCaret: TComboBox
          Left = 364
          Top = 136
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 18
        end
        object cmbOverwriteCaret: TComboBox
          Left = 364
          Top = 164
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 19
        end
        object Edit3: TEdit
          Left = 180
          Top = 192
          Width = 33
          Height = 21
          TabOrder = 15
          Text = '0'
        end
        object udMaxUndo: TUpDown
          Left = 213
          Top = 192
          Width = 15
          Height = 21
          Associate = Edit3
          Min = 0
          Max = 1024
          Position = 0
          TabOrder = 16
          Wrap = False
        end
        object Edit4: TEdit
          Left = 412
          Top = 220
          Width = 33
          Height = 21
          TabOrder = 21
          Text = '0'
        end
        object udTabWidth: TUpDown
          Left = 445
          Top = 220
          Width = 15
          Height = 21
          Associate = Edit4
          Min = 0
          Max = 10
          Position = 0
          TabOrder = 22
          Wrap = False
        end
        object chkHighlightGuides: TCheckBox
          Left = 8
          Top = 96
          Width = 221
          Height = 17
          Caption = 'Highlight indent guides'
          TabOrder = 4
        end
        object btnFont: TButton
          Left = 8
          Top = 220
          Width = 221
          Height = 25
          Caption = 'Font: Courier New, 10'
          TabOrder = 17
          OnClick = btnFontClick
        end
        object chkCodeFolding: TCheckBox
          Left = 8
          Top = 36
          Width = 221
          Height = 17
          Caption = 'Code folding'
          TabOrder = 1
        end
        object cmbFoldingButton: TComboBox
          Left = 364
          Top = 192
          Width = 97
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 20
        end
      end
      object gbGutterMargin: TGroupBox
        Left = 4
        Top = 264
        Width = 469
        Height = 129
        Caption = 'Gutter and margin'
        TabOrder = 1
        object lblRightMarginPos: TLabel
          Left = 216
          Top = 20
          Width = 104
          Height = 13
          Caption = 'Right margin position:'
        end
        object lblGutterColor: TLabel
          Left = 216
          Top = 48
          Width = 61
          Height = 13
          Caption = 'Gutter color:'
        end
        object lblFoldingBarColor: TLabel
          Left = 216
          Top = 76
          Width = 83
          Height = 13
          Caption = 'Folding bar color:'
        end
        object lblFoldingLinesColor: TLabel
          Left = 216
          Top = 104
          Width = 107
          Height = 13
          Caption = 'Folding bar lines color:'
        end
        object chkShowGutter: TCheckBox
          Left = 8
          Top = 16
          Width = 193
          Height = 17
          Caption = 'Show gutter'
          TabOrder = 0
        end
        object chkShowRightMargin: TCheckBox
          Left = 8
          Top = 36
          Width = 193
          Height = 17
          Caption = 'Show right margin'
          TabOrder = 1
        end
        object chkShowLineNumbers: TCheckBox
          Left = 8
          Top = 56
          Width = 193
          Height = 17
          Caption = 'Show line numbers'
          TabOrder = 2
        end
        object chkShowLeadingZeros: TCheckBox
          Left = 8
          Top = 76
          Width = 193
          Height = 17
          Caption = 'Show leading zeros'
          TabOrder = 3
        end
        object chkZeroStart: TCheckBox
          Left = 8
          Top = 96
          Width = 193
          Height = 17
          Caption = 'Zero start'
          TabOrder = 4
        end
        object Edit5: TEdit
          Left = 412
          Top = 16
          Width = 33
          Height = 21
          TabOrder = 5
          Text = '0'
        end
        object udRightMargin: TUpDown
          Left = 445
          Top = 16
          Width = 15
          Height = 21
          Associate = Edit5
          Min = 0
          Position = 0
          TabOrder = 6
          Wrap = False
        end
        object cbGutter: TColorBox
          Left = 352
          Top = 43
          Width = 109
          Height = 22
          DefaultColorColor = clBtnFace
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 7
        end
        object cbFoldingBar: TColorBox
          Left = 352
          Top = 71
          Width = 109
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 8
        end
        object cbFoldingLines: TColorBox
          Left = 352
          Top = 99
          Width = 109
          Height = 22
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 9
        end
      end
    end
    object tsDocumentTypes: TTabSheet
      Caption = 'Document Types'
      ImageIndex = 2
      object lstDocTypes: TListBox
        Left = 4
        Top = 4
        Width = 145
        Height = 237
        ItemHeight = 13
        TabOrder = 0
        OnClick = lstDocTypesClick
      end
      object gbDocTypeProperties: TGroupBox
        Left = 156
        Top = 4
        Width = 233
        Height = 237
        Caption = 'Properties'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object lblDocTypeName: TLabel
          Left = 8
          Top = 16
          Width = 31
          Height = 13
          Caption = 'Name:'
        end
        object lblDocTypeExtensions: TLabel
          Left = 8
          Top = 60
          Width = 56
          Height = 13
          Caption = 'Extensions:'
        end
        object lblDocTypeSyntaxFile: TLabel
          Left = 8
          Top = 104
          Width = 55
          Height = 13
          Caption = 'Syntax file:'
        end
        object lblDocTypeRegExp: TLabel
          Left = 8
          Top = 148
          Width = 137
          Height = 13
          Caption = 'Function regular expression:'
        end
        object txtDocTypeName: TEdit
          Left = 8
          Top = 32
          Width = 217
          Height = 21
          TabOrder = 0
          OnExit = txtDocTypeNameExit
        end
        object txtExtensions: TEdit
          Left = 8
          Top = 76
          Width = 217
          Height = 21
          TabOrder = 1
          OnExit = txtExtensionsExit
        end
        object txtSyntax: TEdit
          Left = 8
          Top = 120
          Width = 193
          Height = 21
          TabOrder = 2
          OnExit = txtSyntaxExit
        end
        object txtRegExp: TEdit
          Left = 8
          Top = 164
          Width = 217
          Height = 21
          TabOrder = 4
          OnExit = txtRegExpExit
        end
        object btnSyntax: TButton
          Left = 204
          Top = 120
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnSyntaxClick
        end
        object chkDefEditor: TCheckBox
          Left = 8
          Top = 192
          Width = 217
          Height = 17
          Caption = 'Default editor of this file type'
          TabOrder = 5
          OnClick = chkDefEditorClick
        end
        object chkSysContext: TCheckBox
          Left = 8
          Top = 212
          Width = 217
          Height = 17
          Caption = 'Add to system context menu'
          TabOrder = 6
          OnClick = chkSysContextClick
        end
      end
      object btnAddDocType: TButton
        Left = 396
        Top = 8
        Width = 75
        Height = 25
        Caption = '&Add'
        TabOrder = 3
        OnClick = btnAddDocTypeClick
      end
      object btnDeleteDocType: TButton
        Left = 396
        Top = 36
        Width = 75
        Height = 25
        Caption = '&Delete'
        TabOrder = 4
        OnClick = btnDeleteDocTypeClick
      end
      object gbCommonDocTypes: TGroupBox
        Left = 4
        Top = 248
        Width = 385
        Height = 149
        Caption = 'Common document types'
        TabOrder = 2
        object lblCommonDocTypesIntro: TLabel
          Left = 8
          Top = 16
          Width = 369
          Height = 29
          AutoSize = False
          Caption = 
            'Select up to ten document types that will be displayed in View->' +
            'Document Type menu.'
          WordWrap = True
        end
        object lstCommonDocTypes: TCheckListBox
          Left = 8
          Top = 48
          Width = 369
          Height = 93
          ItemHeight = 13
          TabOrder = 0
          OnMouseUp = lstCommonDocTypesMouseUp
        end
      end
    end
    object tsKeyboard: TTabSheet
      Caption = 'Keyboard && Mouse'
      ImageIndex = 6
      object gbKeyboard: TGroupBox
        Left = 4
        Top = 4
        Width = 469
        Height = 237
        Caption = 'Keyboard shortcuts'
        TabOrder = 0
        object lblKeyCategories: TLabel
          Left = 8
          Top = 16
          Width = 56
          Height = 13
          Caption = 'Categories:'
        end
        object lblKeyCommands: TLabel
          Left = 152
          Top = 16
          Width = 56
          Height = 13
          Caption = 'Commands:'
        end
        object lblShortcutKey: TLabel
          Left = 316
          Top = 16
          Width = 65
          Height = 13
          Caption = 'Shortcut key:'
        end
        object lblShortCutAssigned: TLabel
          Left = 316
          Top = 80
          Width = 60
          Height = 13
          Caption = 'Assigned to:'
        end
        object lblShortCutAssignedTo: TLabel
          Left = 316
          Top = 96
          Width = 108
          Height = 13
          Caption = 'lblShortCutAssignedTo'
        end
        object lstKeyCat: TListBox
          Left = 8
          Top = 32
          Width = 137
          Height = 197
          ItemHeight = 13
          Sorted = True
          TabOrder = 0
          OnClick = lstKeyCatClick
        end
        object lstKeyCmd: TListBox
          Left = 152
          Top = 32
          Width = 157
          Height = 197
          ItemHeight = 13
          Sorted = True
          TabOrder = 1
          OnClick = lstKeyCmdClick
        end
        object chkCtrl: TCheckBox
          Left = 316
          Top = 32
          Width = 41
          Height = 17
          Caption = 'Ctrl'
          TabOrder = 2
          OnClick = chkCtrlClick
        end
        object chkShift: TCheckBox
          Left = 360
          Top = 32
          Width = 45
          Height = 17
          Caption = 'Shift'
          TabOrder = 3
          OnClick = chkShiftClick
        end
        object chkAlt: TCheckBox
          Left = 408
          Top = 32
          Width = 33
          Height = 17
          Caption = 'Alt'
          TabOrder = 4
          OnClick = chkAltClick
        end
        object cmbShortCut: TComboBox
          Left = 316
          Top = 52
          Width = 145
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          Sorted = True
          TabOrder = 5
          OnChange = cmbShortCutChange
          Items.Strings = (
            ''
            #39
            '-'
            ','
            '.'
            '/'
            ';'
            '\'
            ']'
            '='
            '0'
            '1'
            '2'
            '3'
            '4'
            '5'
            '6'
            '7'
            '8'
            '9'
            'A'
            'B'
            'BkSp'
            'C'
            'D'
            'Del'
            'Down'
            'E'
            'End'
            'F'
            'F1'
            'F10'
            'F11'
            'F12'
            'F2'
            'F3'
            'F4'
            'F5'
            'F6'
            'F7'
            'F8'
            'F9'
            'G'
            'H'
            'Home'
            'I'
            'Ins'
            'J'
            'K'
            'L'
            'Left'
            'M'
            'N'
            'O'
            'P'
            'PgDn'
            'PgUp'
            'Q'
            'R'
            'Right'
            'S'
            'T'
            'Tab'
            'U'
            'Up'
            'V'
            'W'
            'X'
            'Y'
            'Z'
            '[')
        end
      end
      object gbMouse: TGroupBox
        Left = 4
        Top = 248
        Width = 469
        Height = 149
        Caption = 'Mouse'
        TabOrder = 1
        object lblGestureUp: TLabel
          Left = 8
          Top = 16
          Width = 57
          Height = 13
          Caption = 'Gesture up:'
        end
        object lblGestureLeft: TLabel
          Left = 8
          Top = 60
          Width = 61
          Height = 13
          Caption = 'Gesture left:'
        end
        object lblGestureDown: TLabel
          Left = 8
          Top = 104
          Width = 71
          Height = 13
          Caption = 'Gesture down:'
        end
        object lblGestureRight: TLabel
          Left = 160
          Top = 16
          Width = 67
          Height = 13
          Caption = 'Gesture right:'
        end
        object lblMiddleButton: TLabel
          Left = 160
          Top = 60
          Width = 69
          Height = 13
          Caption = 'Middle button:'
        end
        object cmbGestureUp: TComboBox
          Left = 8
          Top = 32
          Width = 141
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 0
        end
        object cmbGestureLeft: TComboBox
          Left = 8
          Top = 76
          Width = 141
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 1
        end
        object cmbGestureDown: TComboBox
          Left = 8
          Top = 120
          Width = 141
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 2
        end
        object cmbGestureRight: TComboBox
          Left = 160
          Top = 32
          Width = 141
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
        end
        object cmbMiddleButton: TComboBox
          Left = 160
          Top = 76
          Width = 141
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 4
        end
      end
    end
  end
  object btnOK: TButton
    Left = 256
    Top = 448
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 336
    Top = 448
    Width = 75
    Height = 25
    Caption = '&Cancel'
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object btnHelp: TButton
    Left = 416
    Top = 448
    Width = 75
    Height = 25
    Caption = '&Help'
    TabOrder = 3
  end
  object dlgOpen: TOpenDialog
    Filter = 'Syntax files (*.xml)|*.xml'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 120
    Top = 448
  end
  object dlgFont: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Options = [fdFixedPitchOnly, fdNoStyleSel]
    Left = 152
    Top = 448
  end
end
