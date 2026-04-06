package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func updown_create(): CPointer<Unit>

    func updown_OnClick(updown: CPointer<Unit>, listener: Listener): Unit

    func updown_tooltip(updown: CPointer<Unit>, text: CString): Unit
}

public class UpDown <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { updown_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): UpDown {
        UpDown(handle)
    }

    @EventHandler(updown_OnClick)

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            updown_tooltip(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }
}
