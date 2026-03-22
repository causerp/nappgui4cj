package nappgui4cj

@C
public struct Box2Dd {
    public var min: V2Dd
    public var max: V2Dd

    public init() {
        min = V2Dd()
        max = V2Dd()
    }

    public init(min: V2Dd, max: V2Dd) {
        this.min = min
        this.max = max
    }
}

@C
public struct Box2Df {
    public var min: V2Df
    public var max: V2Df

    public init() {
        min = V2Df()
        max = V2Df()
    }

    public init(min: V2Df, max: V2Df) {
        this.min = min
        this.max = max
    }
}

@C
public struct Cir2Dd {
    public var c: V2Dd
    public var r: Float64

    public init() {
        c = V2Dd()
        r = 0.0
    }

    public init(c: V2Dd, r: Float64) {
        this.c = c
        this.r = r
    }
}

@C
public struct Cir2Df {
    public var c: V2Df
    public var r: Float32

    public init() {
        c = V2Df()
        r = 0.0
    }

    public init(c: V2Df, r: Float32) {
        this.c = c
        this.r = r
    }
}

@C
public struct Col2Dd {
    public var p: V2Dd
    public var n: V2Dd
    public var d: Float64

    public init() {
        p = V2Dd()
        n = V2Dd()
        d = 0.0
    }

    public init(p: V2Dd, n: V2Dd, d: Float64) {
        this.p = p
        this.n = n
        this.d = d
    }
}

@C
public struct Col2Df {
    public var p: V2Df
    public var n: V2Df
    public var d: Float32

    public init() {
        p = V2Df()
        n = V2Df()
        d = 0.0
    }

    public init(p: V2Df, n: V2Df, d: Float32) {
        this.p = p
        this.n = n
        this.d = d
    }
}

@C
public struct EvButton {
    public var index: UInt32
    public var state: GUIState
    public var text: CString

    public init() {
        index = 0
        state = GUIState.Off
        text = CString(CPointer())
    }
}

@C
public struct EvDraw {
    public var ctx: DCtx
    public var x: Float32
    public var y: Float32
    public var width: Float32
    public var height: Float32

    public init() {
        ctx = DCtx()
        x = 0.0
        y = 0.0
        width = 0.0
        height = 0.0
    }
}

@C
public struct EvMenu {
    public var index: UInt32
    public var state: GUIState
    public var text: CString

    public init() {
        index = 0
        state = GUIState.Off
        text = CString(CPointer())
    }
}

@C
public struct EvMouse {
    public var x: Float32
    public var y: Float32
    public var lx: Float32
    public var ly: Float32
    public var button: GUIMouse
    public var count: UInt32
    public var modifiers: UInt32
    public var tag: UInt32

    public init() {
        x = 0.0
        y = 0.0
        lx = 0.0
        ly = 0.0
        button = GUIMouse.Left
        count = 0
        modifiers = 0
        tag = 0
    }
}

@C
public struct EvPos {
    public var x: Float32
    public var y: Float32

    public init() {
        x = 0.0
        y = 0.0
    }
}

@C
public struct EvScroll {
    public var orient: GUIOrient
    public var scroll: GUIScroll
    public var cpos: Float32

    public init() {
        orient = GUIOrient.Horizontal
        scroll = GUIScroll.Begin
        cpos = 0.0
    }
}

@C
public struct EvSize {
    public var width: Float32
    public var height: Float32

    public init() {
        width = 0.0
        height = 0.0
    }
}

@C
public struct EvSlider {
    public var pos: Float32
    public var incr: Float32
    public var step: UInt32

    public init() {
        pos = 0.0
        incr = 0.0
        step = 0
    }
}

@C
public struct EvTbCell {
    public var text: CString
    public var icon: CPointer<Unit>
    public var align: Align

    public init() {
        text = CString(CPointer())
        icon = CPointer<Unit>()
        align = Align.Left
    }
}

@C
public struct EvTbPos {
    public var col: UInt32
    public var row: UInt32

    public init() {
        col = 0
        row = 0
    }
}

@C
public struct EvTbRect {
    public var stcol: UInt32
    public var edcol: UInt32
    public var strow: UInt32
    public var edrow: UInt32

    public init() {
        stcol = 0
        edcol = 0
        strow = 0
        edrow = 0
    }
}

@C
public struct EvTbRow {
    public var sel: Bool
    public var row: UInt32

    public init() {
        sel = false
        row = 0
    }
}

@C
public struct EvTbSel {
    public var sel: CPointer<Unit>

    public init() {
        sel = CPointer<Unit>()
    }
}

@C
public struct EvTextFilter {
    public var apply: Bool
    public var text: VArray<UInt8, $4096>
    public var cpos: UInt32

    public init() {
        apply = false
        text = VArray<UInt8, $4096>(repeat: 0)
        cpos = 0
    }
}

@C
public struct EvText {
    public var text: CString
    public var cpos: UInt32
    public var len: Int32

    public init() {
        text = CString(CPointer())
        cpos = 0
        len = 0
    }
}

@C
public struct EvWheel {
    public var x: Float32
    public var y: Float32
    public var dx: Float32
    public var dy: Float32
    public var dz: Float32

    public init() {
        x = 0.0
        y = 0.0
        dx = 0.0
        dy = 0.0
        dz = 0.0
    }
}

@C
public struct EvWinClose {
    public var origin: GUIClose

    public init() {
        origin = GUIClose.Esc
    }
}

@C
public struct R2Dd {
    public var pos: V2Dd
    public var size: S2Dd

    public init() {
        pos = V2Dd()
        size = S2Dd()
    }

    public init(pos: V2Dd, size: S2Dd) {
        this.pos = pos
        this.size = size
    }
}

@C
public struct R2Df {
    public var pos: V2Df
    public var size: S2Df

    public init() {
        pos = V2Df()
        size = S2Df()
    }

    public init(pos: V2Df, size: S2Df) {
        this.pos = pos
        this.size = size
    }
}

@C
public struct Seg2Dd {
    public var p0: V2Dd
    public var p1: V2Dd

    public init() {
        p0 = V2Dd()
        p1 = V2Dd()
    }

    public init(p0: V2Dd, p1: V2Dd) {
        this.p0 = p0
        this.p1 = p1
    }
}

@C
public struct Seg2Df {
    public var p0: V2Df
    public var p1: V2Df

    public init() {
        p0 = V2Df()
        p1 = V2Df()
    }

    public init(p0: V2Df, p1: V2Df) {
        this.p0 = p0
        this.p1 = p1
    }
}

@C
public struct Tri2Dd {
    public var p0: V2Dd
    public var p1: V2Dd
    public var p2: V2Dd

    public init() {
        p0 = V2Dd()
        p1 = V2Dd()
        p2 = V2Dd()
    }

    public init(p0: V2Dd, p1: V2Dd, p2: V2Dd) {
        this.p0 = p0
        this.p1 = p1
        this.p2 = p2
    }
}

@C
public struct Tri2Df {
    public var p0: V2Df
    public var p1: V2Df
    public var p2: V2Df

    public init() {
        p0 = V2Df()
        p1 = V2Df()
        p2 = V2Df()
    }

    public init(p0: V2Df, p1: V2Df, p2: V2Df) {
        this.p0 = p0
        this.p1 = p1
        this.p2 = p2
    }
}
