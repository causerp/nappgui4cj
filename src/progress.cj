package nappgui4cj

foreign {
    func progress_create(): CPointer<Unit>

    func progress_width(progress: CPointer<Unit>, width: Float32): Unit

    func progress_undefined(progress: CPointer<Unit>, running: Bool): Unit

    func progress_value(progress: CPointer<Unit>, value: Float32): Unit
}

public class Progress <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { progress_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Progress {
        Progress(handle)
    }

    public func setWidth(width: Float32): Unit {
        unsafe { progress_width(m_handle, width) }
    }

    public func setUndefined(running: Bool): Unit {
        unsafe { progress_undefined(m_handle, running) }
    }

    public func setValue(value: Float32): Unit {
        unsafe { progress_value(m_handle, value) }
    }
}
