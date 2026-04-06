package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func view_create(): CPointer<Unit>

    func view_scroll(): CPointer<Unit>

    func view_custom(scroll: Bool, border: Bool): CPointer<Unit>

    func view_data_imp(view: CPointer<Unit>, data: CPointer<CPointer<Unit>>, func_destroy_data: CPointer<Unit>): Unit

    func view_get_data_imp(view: CPointer<Unit>): CPointer<Unit>

    func view_size(view: CPointer<Unit>, size: S2Df): Unit

    func view_OnDraw(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnOverlay(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnSize(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnEnter(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnExit(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnMove(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnDown(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnUp(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnClick(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnDrag(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnWheel(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnKeyDown(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnKeyUp(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnFocus(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnResignFocus(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnAcceptFocus(view: CPointer<Unit>, listener: Listener): Unit

    func view_OnScroll(view: CPointer<Unit>, listener: Listener): Unit

    func view_allow_tab(view: CPointer<Unit>, allow: Bool): Unit

    func view_keybuf(view: CPointer<Unit>, buffer: CPointer<Unit>): Unit

    func view_get_size(view: CPointer<Unit>, size: CPointer<S2Df>): Unit

    func view_content_size(view: CPointer<Unit>, size: S2Df, line: S2Df): Unit

    func view_scroll_x(view: CPointer<Unit>, pos: Float32): Unit

    func view_scroll_y(view: CPointer<Unit>, pos: Float32): Unit

    func view_scroll_size(view: CPointer<Unit>, width: CPointer<Float32>, height: CPointer<Float32>): Unit

    func view_scroll_visible(view: CPointer<Unit>, horizontal: Bool, vertical: Bool): Unit

    func view_viewport(view: CPointer<Unit>, pos: CPointer<V2Df>, size: CPointer<S2Df>): Unit

    func view_point_scale(view: CPointer<Unit>, scale: CPointer<Float32>): Unit

    func view_update(view: CPointer<Unit>): Unit

    func view_native(view: CPointer<Unit>): CPointer<Unit>
}

public enum ViewType {
    | ViNormal
    | ViScroll
    | ViCustom(Bool, Bool)
}

public class View <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { view_create() }
    }

    public init(viewType: ViewType) {
        m_handle = match (viewType) {
            case ViNormal => unsafe { view_create() }
            case ViScroll => unsafe { view_scroll() }
            case ViCustom(scroll, border) => unsafe { view_custom(scroll, border) }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): View {
        View(handle)
    }

    public func setData(data: CPointer<CPointer<Unit>>, destroyFunc: CPointer<Unit>): Unit {
        unsafe { view_data_imp(m_handle, data, destroyFunc) }
    }

    public func getData(): CPointer<Unit> {
        unsafe { view_get_data_imp(m_handle) }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { view_size(m_handle, size) }
    }

    @EventHandler(view_OnDraw)

    @EventHandler(view_OnOverlay)

    @EventHandler(view_OnSize)

    @EventHandler(view_OnEnter)

    @EventHandler(view_OnExit)

    @EventHandler(view_OnMove)

    @EventHandler(view_OnDown)

    @EventHandler(view_OnUp)

    @EventHandler(view_OnClick)

    @EventHandler(view_OnDrag)

    @EventHandler(view_OnWheel)

    @EventHandler(view_OnKeyDown)

    @EventHandler(view_OnKeyUp)

    @EventHandler(view_OnFocus)

    @EventHandler(view_OnResignFocus)

    @EventHandler(view_OnAcceptFocus)

    @EventHandler(view_OnScroll)

    public func allowTab(allow: Bool): Unit {
        unsafe { view_allow_tab(m_handle, allow) }
    }

    public func setKeyBuf(buffer: CPointer<Unit>): Unit {
        unsafe { view_keybuf(m_handle, buffer) }
    }

    public func getSize(): S2Df {
        unsafe {
            var s = S2Df()
            view_get_size(m_handle, inout s)
            return s
        }
    }

    public func setContentSize(size: S2Df, line: S2Df): Unit {
        unsafe { view_content_size(m_handle, size, line) }
    }

    public func scrollX(pos: Float32): Unit {
        unsafe { view_scroll_x(m_handle, pos) }
    }

    public func scrollY(pos: Float32): Unit {
        unsafe { view_scroll_y(m_handle, pos) }
    }

    public func getScrollSize(): (Float32, Float32) {
        unsafe {
            var w: Float32 = 0.0
            var h: Float32 = 0.0
            view_scroll_size(m_handle, inout w, inout h)
            return (w, h)
        }
    }

    public func setScrollVisible(horizontal: Bool, vertical: Bool): Unit {
        unsafe { view_scroll_visible(m_handle, horizontal, vertical) }
    }

    // public func getViewport(): (V2Df, S2Df) {
    //     unsafe {
    //         var p = V2Df()
    //         var s = S2Df()
    //         view_viewport(m_handle, inout p, inout s)
    //         return (p, s)
    //     }
    // }

    public func getPointScale(): Float32 {
        unsafe {
            var scale: Float32 = 0.0
            view_point_scale(m_handle, inout scale)
            return scale
        }
    }

    public func update(): Unit {
        unsafe { view_update(m_handle) }
    }

    public func getNative(): CPointer<Unit> {
        unsafe { view_native(m_handle) }
    }
}
