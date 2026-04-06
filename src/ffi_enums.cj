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

@CEnum[public CoreEvent UInt32](
    EAssert = 0x100
    File
    Entry
    Exit
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

@CEnum[public DBindSt UInt32](
    OK
    MemberExists
    TypeExists
    TypeUnknown
    TypeUsed
    AliasSize
)

@CEnum[public Device UInt32](
    Desktop = 1
    Phone
    Tablet
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

@CEnum[public Endian UInt32](
    Little = 1
    Big
)

@CEnum[public FError UInt32](
    Exists = 1
    NoPath
    NoFile
    BigName
    NoFiles
    NoEmpty
    NoAccess
    Lock
    Big
    SeekNeg
    Undef
    OK
)

@CEnum[public FileMode UInt32](
    Read = 1
    Write
    Append
)

@CEnum[public FileSeek UInt32](
    Set = 1
    Cur
    End
)

@CEnum[public FileType UInt32](
    Archive = 1
    Directory
    Other
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

@CEnum[public LToken UInt32](
    SLCom = 1
    MLCom
    Space
    EOL

    Less
    Great
    Comma
    Period
    SColon
    Colon

    OpenPar
    ClosPar
    OpenBrac
    ClosBrac
    OpenCurl
    ClosCurl

    Plus
    Minus
    Asterk
    Equals

    Dollar
    Percent
    Pound
    Amper

    Apost
    Quote
    Circum
    Tilde
    Excla
    Quest
    VLine
    Slash
    BSlash
    At

    Integer
    Octal
    Hex
    Real
    Str
    Ident

    Undef
    Corrup
    EOF

    Reserved
)

@CEnum[public MacOs UInt32](
    No = 0
    Legacy
    SnowLeopard
    Lion
    MountainLion
    Mavericks
    Yosemite
    ElCapitan
    Sierra
    HighSierra
    Mojave
    Catalina
    BigSur
    Monterey
    Ventura
    Sonoma
    Sequoia
    Tahoe
)

@CFlagEnum[public MenuFlag UInt32](
    Flag = 0
    Item
    Separator
)

@CFlagEnum[public MKey UInt32](
    None = 0
    Shift = 1
    Control = 1 << 1
    Alt = 1 << 2
    Command = 1 << 3
)

@CEnum[public Month UInt32](
    January = 1
    February
    March
    April
    May
    June
    July
    August
    September
    October
    November
    December
)

@CEnum[public PError UInt32](
    Pipe = 1
    Exec
    OK
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

@CEnum[public Platform UInt32](
    Windows = 1
    MacOS
    Linux
    iOS
)

@CFlagEnum[public ProgressFlag UInt32](
    Flag = 0
    Horz = 0
    Vert = 1
    Type = 1
)

@CEnum[public SError UInt32](
    NoNet = 1
    NoHost
    Timeout
    Stream
    Undef
    OK
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

@CEnum[public SState UInt32](
    OK
    End
    Corrupt
    Broken
)

@CEnum[public SysColor UInt32](
    DarkMode = 0
    Label
    View
    Line
    Link
    Border
)

@CEnum[public VKey UInt32](
    Undef = 0
    A = 1
    S = 2
    D = 3
    F = 4
    H = 5
    G = 6
    Z = 7
    X = 8
    C = 9
    V = 10
    BSlash = 11
    B = 12
    Q = 13
    W = 14
    E = 15
    R = 16
    Y = 17
    T = 18
    Key1 = 19
    Key2 = 20
    Key3 = 21
    Key4 = 22
    Key6 = 23
    Key5 = 24
    Key9 = 25
    Key7 = 26
    Key8 = 27
    Key0 = 28
    RCurly = 29
    O = 30
    U = 31
    LCurly = 32
    I = 33
    P = 34
    Return = 35
    L = 36
    J = 37
    Semicolon = 38
    K = 39
    Quest = 40
    Comma = 41
    Minus = 42
    N = 43
    M = 44
    Period = 45
    Tab = 46
    Space = 47
    GtLt = 48
    Back = 49
    Escape = 50
    F17 = 51
    NumDecimal = 52
    NumMult = 53
    NumAdd = 54
    NumLock = 55
    NumDiv = 56
    NumRet = 57
    NumMinus = 58
    F18 = 59
    F19 = 60
    NumEqual = 61
    Num0 = 62
    Num1 = 63
    Num2 = 64
    Num3 = 65
    Num4 = 66
    Num5 = 67
    Num6 = 68
    Num7 = 69
    Num8 = 70
    Num9 = 71
    F5 = 72
    F6 = 73
    F7 = 74
    F3 = 75
    F8 = 76
    F9 = 77
    F11 = 78
    F13 = 79
    F16 = 80
    F14 = 81
    F10 = 82
    F12 = 83
    F15 = 84
    PageUp = 85
    Home = 86
    Supr = 87
    F4 = 88
    PageDown = 89
    F2 = 90
    End = 91
    F1 = 92
    Left = 93
    Right = 94
    Down = 95
    Up = 96
    LShift = 97
    RShift = 98
    LCtrl = 99
    RCtrl = 100
    LAlt = 101
    RAlt = 102
    Insert = 103
    Exclam = 104
    Menu = 105
    LWin = 106
    RWin = 107
    Caps = 108
    Tilde = 109
    Grave = 110
    Plus = 111
)

@CEnum[public WeekDay UInt32](
    Sunday
    Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
)

@CEnum[public Win UInt32](
    No = 0
    Win9x
    NT4
    Win2K
    WinXP
    XP1
    XP2
    XP3
    Vista
    Vista1
    Vista2
    Win7
    Win71
    Win8
    Win81
    Win10
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
