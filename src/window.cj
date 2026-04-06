package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func window_create(flags: WindowFlag): CPointer<Unit>

    func window_destroy(window: CPointer<CPointer<Unit>>): Unit

    func window_panel(window: CPointer<Unit>, panel: CPointer<Unit>): Unit

    func window_title(window: CPointer<Unit>, text: CString): Unit

    func window_show(window: CPointer<Unit>): Unit

    func window_hide(window: CPointer<Unit>): Unit

    func window_OnClose(window: CPointer<Unit>, listener: Listener): Unit

    func window_OnMoved(window: CPointer<Unit>, listener: Listener): Unit

    func window_OnResize(window: CPointer<Unit>, listener: Listener): Unit

    func window_origin(window: CPointer<Unit>, origin: V2Df): Unit

    func window_get_origin(window: CPointer<Unit>): V2Df

    func window_client_size(window: CPointer<Unit>, size: S2Df): Unit

    func window_get_size(window: CPointer<Unit>): S2Df

    func window_get_client_size(window: CPointer<Unit>): S2Df

    func window_get_maximize(window: CPointer<Unit>): Bool

    func window_maximize(window: CPointer<Unit>): Unit

    func window_get_minimize(window: CPointer<Unit>): Bool

    func window_minimize(window: CPointer<Unit>): Unit

    func window_update(window: CPointer<Unit>): Unit

    func window_overlay(window: CPointer<Unit>, parent: CPointer<Unit>): Unit

    func window_modal(window: CPointer<Unit>, parent: CPointer<Unit>): UInt32

    func window_stop_modal(window: CPointer<Unit>, return_value: UInt32): Unit

    func window_defbutton(window: CPointer<Unit>, button: CPointer<Unit>): Unit
}

public struct Window <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(flags: WindowFlag) {
        m_handle = unsafe { window_create(flags) }
    }

    public mut func destroy(): Unit {
        unsafe { window_destroy(inout m_handle) }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func isNull(): Bool {
        m_handle.isNull()
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
        unsafe { window_panel(m_handle, panel.m_handle) }
    }

    public func show(): Unit {
        unsafe { window_show(m_handle) }
    }

    public func hide(): Unit {
        unsafe { window_hide(m_handle) }
    }

    public func setOrigin(origin: V2Df): Unit {
        unsafe { window_origin(m_handle, origin) }
    }

    public func getOrigin(): V2Df {
        unsafe { window_get_origin(m_handle) }
    }

    public func setClientSize(size: S2Df): Unit {
        unsafe { window_client_size(m_handle, size) }
    }

    public func getSize(): S2Df {
        unsafe { window_get_size(m_handle) }
    }

    public func getClientSize(): S2Df {
        unsafe { window_get_client_size(m_handle) }
    }

    public func maximize(): Unit {
        unsafe { window_maximize(m_handle) }
    }

    public func isMaximized(): Bool {
        unsafe { window_get_maximize(m_handle) }
    }

    public func minimize(): Unit {
        unsafe { window_minimize(m_handle) }
    }

    public func isMinimized(): Bool {
        unsafe { window_get_minimize(m_handle) }
    }

    public func update(): Unit {
        unsafe { window_update(m_handle) }
    }

    public func overlay(parent: Window): Unit {
        unsafe { window_overlay(m_handle, parent.m_handle) }
    }

    public func runModal(parent: Window): UInt32 {
        unsafe { window_modal(m_handle, parent.m_handle) }
    }

    public func stopModal(returnValue: UInt32): Unit {
        unsafe { window_stop_modal(m_handle, returnValue) }
    }

    public func setDefaultButton(button: ?Button): Unit {
        unsafe { window_defbutton(m_handle, button?.m_handle ?? CPointer()) }
    }

    @EventHandler(window_OnClose)

    @EventHandler(window_OnMoved)

    @EventHandler(window_OnResize)
}
