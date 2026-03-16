package nappgui4cj

foreign {
    func window_create(flags: WindowFlag): CPointer<Unit>

    func window_destroy(window: CPointer<CPointer<Unit>>): Unit

    func window_panel(window: CPointer<Unit>, panel: Panel): Unit

    func window_title(window: CPointer<Unit>, text: CString): Unit

    func window_show(window: CPointer<Unit>): Unit

    func window_OnClose(window: CPointer<Unit>, listener: Listener): Unit

    func window_origin(window: CPointer<Unit>, origin: V2Df): Unit
}

@C
public struct Window {
    private var m_handle: CPointer<Unit> = CPointer()

    public init() {}

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public static func create(flags: WindowFlag): Window {
        Window(unsafe { window_create(flags) })
    }

    public mut func destroy(): Unit {
        unsafe { window_destroy(inout m_handle) }
    }

    public func setTitle(id: ResId): Unit {
        unsafe {
            window_title(m_handle, id.cStr)
        }
    }

    public func setTitle(title: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(title)
            window_title(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setPanel(panel: Panel): Unit {
        unsafe { window_panel(m_handle, panel) }
    }

    public func show(): Unit {
        unsafe { window_show(m_handle) }
    }

    public func setOrigin(origin: V2Df): Unit {
        unsafe { window_origin(m_handle, origin) }
    }

    public func onClose<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { window_OnClose(m_handle, listener) }
    }
}
