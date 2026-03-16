package nappgui4cj

import cenum.{CEnum, CFlagEnum}

@CEnum[public Align UInt32](
    Left = 1
    Top = 1
    Center = 2
    Right = 3
    Bottom = 3
    Justify = 4
)

@CFlagEnum[public ButtonFlag UInt32](
    Flag = 0
    Push = 0
    Check2 = 1
    Check3 = 2
    Radio = 3
    Flat = 4
    FlatGle = 5
    Type = 7
)

@CEnum[public Clipboard UInt32](
    Copy
    Cut
    Paste
)

@CEnum[public Codec UInt32](
    JPG = 1
    PNG
    BMP
    GIF
)

@CFlagEnum[public CtrlMsel UInt32](
    No
    Single
    Burst
)

@CEnum[public CtrlOp UInt32](
    Add = 1
    Del
    Ins
    Set
)

@CEnum[public CtrlState UInt32](
    Normal
    Hot
    Pressed
    BkNormal
    BkHot
    BkPressed
    Disabled
)

@CEnum[public DrawOp UInt32](
    Stroke = 1
    Fill
    SkFill
    FillSk
)

@CFlagEnum[public EditFlag UInt32](
    Flag = 0
    Single = 0
    Multi = 1
    Type = 1
    AutoSel = 4
)

@CEnum[public Ellipsis UInt32](
    None = 1
    Begin
    Middle
    End
    MLine
)

@CFlagEnum[public FStyle UInt32](
    Normal = 0
    Bold = 1
    Italic = 2
    Strikeout = 4
    Underline = 8
    Subscript = 16
    Supscript = 32
    Pixels = 0
    Points = 64
    Cell = 128
)

@CEnum[public FillWrap UInt32](
    Clamp
    Tile
    Flip
)

@CEnum[public GUIClose UInt32](
    Esc = 1
    Intro
    Button
    Deact
)

@CEnum[public GUICursor UInt32](
    Arrow = 1
    Hand
    IBeam
    Cross
    SizeWE
    SizeNS
    User
)

@CEnum[public GUIEvent UInt32](
    Label = 0x400
    Button
    Popup
    ListBox
    Slider
    UpDown
    TxtFilter
    TxtChange
    FocusResign
    FocusAccept
    Focus
    Menu
    Draw
    Overlay
    Resize
    Enter
    Exit
    Moved
    Down
    Up
    Click
    Drag
    Wheel
    KeyDown
    KeyUp
    Scroll
    WndMoved
    WndSizing
    WndSize
    WndClose
    Color
    Theme
    ObjChange
    TblNRows
    TblBegin
    TblEnd
    TblCell
    TblSel
    TblHeadClick
    TblRowClick
    Idle
)

@CEnum[public GUIFocus UInt32](
    Changed = 1
    Keep
    NoNext
    NoResign
    NoAccept
)

@CEnum[public GUIMouse UInt32](
    Left = 1
    Right
    Middle
)

@CEnum[public GUIOrient UInt32](
    Horizontal = 1
    Vertical
)

@CEnum[public GUIProp UInt32](
    Children = 0
)

@CEnum[public GUIRole UInt32](
    Main = 0
    Overlay = 1
    Modal = 2
    Managed = 3
)

@CEnum[public GUIScale UInt32](
    None = 1
    Auto
    Aspect
    AspectDw
    Adjust
)

@CEnum[public GUIScroll UInt32](
    Begin = 1
    End
    StepLeft
    StepRight
    PageLeft
    PageRight
    Thumb
)

@CEnum[public GUISize UInt32](
    Mini = 1
    Small
    Regular
)

@CEnum[public GUIState UInt32](
    Off = 0
    On
    Mixed
)

@CEnum[public GUITab UInt32](
    Key = 1
    BackKey
    Next
    Prev
    Move
    Click
)

@CEnum[public GUIText UInt32](
    Family = 0
    Units
    Size
    Style
    Color
    BgColor
    PgColor
    ParAlign
    LSpacing
    BfParSpace
    AfParSpace
    ApplyAll
    ApplySel
    Select
    ShowSelect
    Scroll
    WrapMode
)

@CEnum[public GUIType UInt32](
    Button = 0
    Popup = 1
    Editbox = 2
    Combobox = 3
    Slider = 4
    UpDown = 5
    Progress = 6
    Textview = 7
    Webview = 8
    Treeview = 9
    Boxview = 10
    Splitview = 11
    Customview = 12
    Panel = 13
    Line = 14
    Header = 15
    Window = 16
    Toolbar = 17
)

@CEnum[public GUIWeb UInt32](
    Navigate = 1
    Back
    Forward
)

@CEnum[public Indicator UInt32](
    None = 0
    UpArrow
    DownArrow
)

@CFlagEnum[public LabelFlag UInt32](
    Flag = 0
    Single = 0
    Multi = 1
    Type = 1
)

@CEnum[public LineCap UInt32](
    Flat
    Square
    Round
)

@CEnum[public LineJoin UInt32](
    Miter
    Round
    Bevel
)

@CFlagEnum[public MenuFlag UInt32](
    Flag = 0
    Item
    Separator
)

@CEnum[public PixFormat UInt32](
    Index1
    Index2
    Index4
    Index8
    Gray8
    RGB24
    RGBA32
    Image
)

@CFlagEnum[public ProgressFlag UInt32](
    Flag = 0
    Horz = 0
    Vert = 1
    Type = 1
)

@CFlagEnum[public SliderFlag UInt32](
    Flag = 0
    Horz = 0
    Vert = 1
    Type = 1
)

@CEnum[public SplitMode UInt32](
    Normal = 1
    Fixed0
    Fixed1
)

@CFlagEnum[public SplitFlag UInt32](
    Flag = 0
    Vert = 0
    Horz = 1
    Type = 1
)

@CEnum[public SysColor UInt32](
    DarkMode = 0
    Label
    View
    Line
    Link
    Border
)

@CFlagEnum[public WindowFlag UInt32](
    Flag = 0
    Edge = 1 << 0
    Title = 1 << 1
    Max = 1 << 2
    Min = 1 << 3
    Close = 1 << 4
    Resize = 1 << 5
    Return = 1 << 6
    Esc = 1 << 7
    Offscreen = 1 << 8
    ModalNoHide = 1 << 9
    Std = Title | Min | Close
    StdRes = Std | Max | Resize
)
