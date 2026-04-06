package nappgui4cj

foreign {
    func panel_create(): CPointer<Unit>

    func panel_scroll(hscroll: Bool, vscroll: Bool): CPointer<Unit>

    func panel_custom(hscroll: Bool, vscroll: Bool, border: Bool): CPointer<Unit>

    func panel_data_imp(panel: CPointer<Unit>, data: CPointer<CPointer<Unit>>, func_destroy_data: CPointer<Unit>): Unit

    func panel_get_data_imp(panel: CPointer<Unit>): CPointer<Unit>

    func panel_size(panel: CPointer<Unit>, size: S2Df): Unit

    func panel_layout(panel: CPointer<Unit>, layout: CPointer<Unit>): UInt32

    func panel_get_layout(panel: CPointer<Unit>, index: UInt32): CPointer<Unit>

    func panel_visible_layout(panel: CPointer<Unit>, index: UInt32): Unit

    func panel_update(panel: CPointer<Unit>): Unit

    func panel_scroll_width(panel: CPointer<Unit>): Float32

    func panel_scroll_height(panel: CPointer<Unit>): Float32
}

public class Panel <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { panel_create() }
    }

    public init(hscroll!: Bool, vscroll!: Bool) {
        m_handle = unsafe { panel_scroll(hscroll, vscroll) }
    }

    public init(hscroll!: Bool, vscroll!: Bool, border!: Bool) {
        m_handle = unsafe { panel_custom(hscroll, vscroll, border) }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Panel {
        Panel(handle)
    }

    public func setData<T>(data: CPointer<T>, funcDestroyData: DestroyFunc<T>): Unit where T <: CType {
        unsafe {
            var dataPtr = CPointer<Unit>(data)
            panel_data_imp(m_handle, inout dataPtr, CPointer(funcDestroyData))
        }
    }

    public func getData<T>(): CPointer<Unit> where T <: CType {
        unsafe { CPointer<T>(panel_get_data_imp(m_handle)) }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { panel_size(m_handle, size) }
    }

    public func setLayout(layout: Layout): UInt32 {
        unsafe { panel_layout(m_handle, layout.m_handle) }
    }

    public func getLayout(index: UInt32): Layout {
        unsafe { Layout(panel_get_layout(m_handle, index)) }
    }

    public func setVisibleLayout(index: UInt32): Unit {
        unsafe { panel_visible_layout(m_handle, index) }
    }

    public func update(): Unit {
        unsafe { panel_update(m_handle) }
    }

    public func scrollWidth(): Float32 {
        unsafe { panel_scroll_width(m_handle) }
    }

    public func scrollHeight(): Float32 {
        unsafe { panel_scroll_height(m_handle) }
    }
}
