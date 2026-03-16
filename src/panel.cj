package nappgui4cj

foreign {
    func panel_create(): CPointer<Unit>

    func panel_scroll(hscroll: Bool, vscroll: Bool): CPointer<Unit>

    func panel_custom(hscroll: Bool, vscroll: Bool, border: Bool): CPointer<Unit>

    func panel_data_imp(panel: Panel, data: CPointer<CPointer<Unit>>, func_destroy_data: CPointer<Unit>): Unit

    func panel_get_data_imp(panel: Panel): CPointer<Unit>

    func panel_size(panel: Panel, size: S2Df): Unit

    func panel_layout(panel: Panel, layout: Layout): UInt32

    func panel_get_layout(panel: Panel, index: UInt32): Layout

    func panel_visible_layout(panel: Panel, index: UInt32): Unit

    func panel_update(panel: Panel): Unit

    func panel_scroll_width(panel: Panel): Float32

    func panel_scroll_height(panel: Panel): Float32
}

@C
public struct Panel {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { panel_create() }
    }

    public init(hscroll: Bool, vscroll: Bool) {
        m_handle = unsafe { panel_scroll(hscroll, vscroll) }
    }

    public init(hscroll: Bool, vscroll: Bool, border: Bool) {
        m_handle = unsafe { panel_custom(hscroll, vscroll, border) }
    }

    public func setData(data: CPointer<CPointer<Unit>>, funcDestroyData: CPointer<Unit>): Unit {
        unsafe { panel_data_imp(this, data, funcDestroyData) }
    }

    public func getData(): CPointer<Unit> {
        unsafe { panel_get_data_imp(this) }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { panel_size(this, size) }
    }

    public func setLayout(layout: Layout): UInt32 {
        unsafe { panel_layout(this, layout) }
    }

    public func getLayout(index: UInt32): Layout {
        unsafe { panel_get_layout(this, index) }
    }

    public func setVisibleLayout(index: UInt32): Unit {
        unsafe { panel_visible_layout(this, index) }
    }

    public func update(): Unit {
        unsafe { panel_update(this) }
    }

    public func scrollWidth(): Float32 {
        unsafe { panel_scroll_width(this) }
    }

    public func scrollHeight(): Float32 {
        unsafe { panel_scroll_height(this) }
    }
}
