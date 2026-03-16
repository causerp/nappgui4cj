package nappgui4cj

foreign {
    func view_create(): CPointer<Unit>

    func view_scroll(): CPointer<Unit>

    func view_custom(scroll: Bool, border: Bool): CPointer<Unit>

    func view_data_imp(view: View, data: CPointer<CPointer<Unit>>, func_destroy_data: CPointer<Unit>): Unit

    func view_get_data_imp(view: View): CPointer<Unit>

    func view_size(view: View, size: S2Df): Unit

    func view_OnDraw(view: View, listener: Listener): Unit

    func view_OnOverlay(view: View, listener: Listener): Unit

    func view_OnSize(view: View, listener: Listener): Unit

    func view_OnEnter(view: View, listener: Listener): Unit

    func view_OnExit(view: View, listener: Listener): Unit

    func view_OnMove(view: View, listener: Listener): Unit

    func view_OnDown(view: View, listener: Listener): Unit

    func view_OnUp(view: View, listener: Listener): Unit

    func view_OnClick(view: View, listener: Listener): Unit

    func view_OnDrag(view: View, listener: Listener): Unit

    func view_OnWheel(view: View, listener: Listener): Unit

    func view_OnKeyDown(view: View, listener: Listener): Unit

    func view_OnKeyUp(view: View, listener: Listener): Unit

    func view_OnFocus(view: View, listener: Listener): Unit

    func view_OnResignFocus(view: View, listener: Listener): Unit

    func view_OnAcceptFocus(view: View, listener: Listener): Unit

    func view_OnScroll(view: View, listener: Listener): Unit

    func view_allow_tab(view: View, allow: Bool): Unit

    func view_keybuf(view: View, buffer: CPointer<Unit>): Unit

    func view_get_size(view: View, size: CPointer<S2Df>): Unit

    func view_content_size(view: View, size: S2Df, line: S2Df): Unit

    func view_scroll_x(view: View, pos: Float32): Unit

    func view_scroll_y(view: View, pos: Float32): Unit

    func view_scroll_size(view: View, width: CPointer<Float32>, height: CPointer<Float32>): Unit

    func view_scroll_visible(view: View, horizontal: Bool, vertical: Bool): Unit

    func view_viewport(view: View, pos: CPointer<V2Df>, size: CPointer<S2Df>): Unit

    func view_point_scale(view: View, scale: CPointer<Float32>): Unit

    func view_update(view: View): Unit

    func view_native(view: View): CPointer<Unit>
}

@C
public struct View {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { view_create() }
    }

    public init(scroll: Bool, border!: Bool = false) {
        m_handle = match {
            case scroll && !border => unsafe { view_scroll() }
            case _ => unsafe { view_custom(scroll, border) }
        }
    }

    public func setData(data: CPointer<CPointer<Unit>>, destroyFunc: CPointer<Unit>): Unit {
        unsafe { view_data_imp(this, data, destroyFunc) }
    }

    public func getData(): CPointer<Unit> {
        unsafe { view_get_data_imp(this) }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { view_size(this, size) }
    }

    public func onDraw<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnDraw(this, listener) }
    }

    public func onOverlay<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnOverlay(this, listener) }
    }

    public func onSize<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnSize(this, listener) }
    }

    public func onEnter<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnEnter(this, listener) }
    }

    public func onExit<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnExit(this, listener) }
    }

    public func onMove<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnMove(this, listener) }
    }

    public func onDown<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnDown(this, listener) }
    }

    public func onUp<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnUp(this, listener) }
    }

    public func onClick<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnClick(this, listener) }
    }

    public func onDrag<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnDrag(this, listener) }
    }

    public func onWheel<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnWheel(this, listener) }
    }

    public func onKeyDown<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnKeyDown(this, listener) }
    }

    public func onKeyUp<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnKeyUp(this, listener) }
    }

    public func onFocus<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnFocus(this, listener) }
    }

    public func onResignFocus<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnResignFocus(this, listener) }
    }

    public func onAcceptFocus<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnAcceptFocus(this, listener) }
    }

    public func onScroll<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { view_OnScroll(this, listener) }
    }

    public func allowTab(allow: Bool): Unit {
        unsafe { view_allow_tab(this, allow) }
    }

    public func setKeyBuf(buffer: CPointer<Unit>): Unit {
        unsafe { view_keybuf(this, buffer) }
    }

    public func getSize(): S2Df {
        unsafe {
            var s = S2Df()
            view_get_size(this, inout s)
            return s
        }
    }

    public func setContentSize(size: S2Df, line: S2Df): Unit {
        unsafe { view_content_size(this, size, line) }
    }

    public func scrollX(pos: Float32): Unit {
        unsafe { view_scroll_x(this, pos) }
    }

    public func scrollY(pos: Float32): Unit {
        unsafe { view_scroll_y(this, pos) }
    }

    public func getScrollSize(): (Float32, Float32) {
        unsafe {
            var w: Float32 = 0.0
            var h: Float32 = 0.0
            view_scroll_size(this, inout w, inout h)
            return (w, h)
        }
    }

    public func setScrollVisible(horizontal: Bool, vertical: Bool): Unit {
        unsafe { view_scroll_visible(this, horizontal, vertical) }
    }

    // public func getViewport(): (V2Df, S2Df) {
    //     unsafe {
    //         var p = V2Df()
    //         var s = S2Df()
    //         view_viewport(this, inout p, inout s)
    //         return (p, s)
    //     }
    // }

    public func getPointScale(): Float32 {
        unsafe {
            var scale: Float32 = 0.0
            view_point_scale(this, inout scale)
            return scale
        }
    }

    public func update(): Unit {
        unsafe { view_update(this) }
    }

    public func getNative(): CPointer<Unit> {
        unsafe { view_native(this) }
    }
}
