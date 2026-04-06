package nappgui4cj

foreign {
    func splitview_horizontal(): CPointer<Unit>

    func splitview_vertical(): CPointer<Unit>

    func splitview_view(split: CPointer<Unit>, view: CPointer<Unit>, tabstop: Bool): Unit

    func splitview_textview(split: CPointer<Unit>, view: CPointer<Unit>, tabstop: Bool): Unit

    // func splitview_webview(split: CPointer<Unit>, view: CPointer<Unit>, tabstop: Bool): Unit

    // func splitview_tableview(split: CPointer<Unit>, view: CPointer<Unit>, tabstop: Bool): Unit

    func splitview_splitview(split: CPointer<Unit>, view: CPointer<Unit>): Unit

    func splitview_panel(split: CPointer<Unit>, panel: CPointer<Unit>): Unit

    func splitview_pos(split: CPointer<Unit>, mode: SplitMode, pos: Float32): Unit

    func splitview_get_pos(split: CPointer<Unit>, mode: SplitMode): Float32

    func splitview_visible0(split: CPointer<Unit>, visible: Bool): Unit

    func splitview_visible1(split: CPointer<Unit>, visible: Bool): Unit

    func splitview_minsize0(split: CPointer<Unit>, size: Float32): Unit

    func splitview_minsize1(split: CPointer<Unit>, size: Float32): Unit
}

public enum SplitViewType {
    | SvHorizontal
    | SvVertical
}

public class SplitView <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(splitViewType: SplitViewType) {
        m_handle = match (splitViewType) {
            case SvHorizontal => unsafe { splitview_horizontal() }
            case SvVertical => unsafe { splitview_vertical() }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): SplitView {
        SplitView(handle)
    }

    public func setView(view: View, tabstop!: Bool = true): Unit {
        unsafe { splitview_view(m_handle, view.m_handle, tabstop) }
    }

    public func setTextView(view: TextView, tabstop!: Bool = true): Unit {
        unsafe { splitview_textview(m_handle, view.m_handle, tabstop) }
    }

    // public func setWebView(view: WebView, tabstop!: Bool = true): Unit {
    //     unsafe { splitview_webview(m_handle, view.m_handle, tabstop) }
    // }

    // public func setTableView(view: TableView, tabstop!: Bool = true): Unit {
    //     unsafe { splitview_tableview(m_handle, view.m_handle, tabstop) }
    // }

    public func setSplitView(view: SplitView): Unit {
        unsafe { splitview_splitview(m_handle, view.m_handle) }
    }

    public func setPanel(panel: Panel): Unit {
        unsafe { splitview_panel(m_handle, panel.m_handle) }
    }

    public func setPosition(mode: SplitMode, pos: Float32): Unit {
        unsafe { splitview_pos(m_handle, mode, pos) }
    }

    public func getPosition(mode: SplitMode): Float32 {
        unsafe { splitview_get_pos(m_handle, mode) }
    }

    public func setVisiblePane0(visible: Bool): Unit {
        unsafe { splitview_visible0(m_handle, visible) }
    }

    public func setVisiblePane1(visible: Bool): Unit {
        unsafe { splitview_visible1(m_handle, visible) }
    }

    public func setMinSizePane0(size: Float32): Unit {
        unsafe { splitview_minsize0(m_handle, size) }
    }

    public func setMinSizePane1(size: Float32): Unit {
        unsafe { splitview_minsize1(m_handle, size) }
    }
}
