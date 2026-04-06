package nappgui4cj

foreign {
    func line_horizontal(): CPointer<Unit>

    func line_vertical(): CPointer<Unit>

    func line_length(line: CPointer<Unit>, length: Float32): Unit
}

public enum LineType {
    | LnHorizontal
    | LnVertical
}

public class Line <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(lineType: LineType) {
        m_handle = match (lineType) {
            case LnHorizontal => unsafe { line_horizontal() }
            case LnVertical => unsafe { line_vertical() }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Line {
        Line(handle)
    }

    public func setLength(length: Float32): Unit {
        unsafe { line_length(m_handle, length) }
    }
}
