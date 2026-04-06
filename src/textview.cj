package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func textview_create(): CPointer<Unit>

    func textview_OnFilter(view: CPointer<Unit>, listener: Listener): Unit

    func textview_OnFocus(view: CPointer<Unit>, listener: Listener): Unit

    func textview_size(view: CPointer<Unit>, size: S2Df): Unit

    func textview_clear(view: CPointer<Unit>): Unit

    // func textview_printf(view: CPointer<Unit>, format: CString, ...): UInt32

    func textview_writef(view: CPointer<Unit>, text: CString): Unit

    // func textview_cpos_printf(view: CPointer<Unit>, format: CString, ...): UInt32

    func textview_cpos_writef(view: CPointer<Unit>, text: CString): Unit

    func textview_rtf(view: CPointer<Unit>, rtf_in: CPointer<Unit>): Unit

    func textview_units(view: CPointer<Unit>, units: UInt32): Unit

    func textview_family(view: CPointer<Unit>, family: CString): Unit

    func textview_fsize(view: CPointer<Unit>, size: Float32): Unit

    func textview_fstyle(view: CPointer<Unit>, fstyle: FStyle): Unit

    func textview_color(view: CPointer<Unit>, color: Color): Unit

    func textview_bgcolor(view: CPointer<Unit>, color: Color): Unit

    func textview_pgcolor(view: CPointer<Unit>, color: Color): Unit

    func textview_halign(view: CPointer<Unit>, align: Align): Unit

    func textview_lspacing(view: CPointer<Unit>, scale: Float32): Unit

    func textview_bfspace(view: CPointer<Unit>, space: Float32): Unit

    func textview_afspace(view: CPointer<Unit>, space: Float32): Unit

    func textview_apply_all(view: CPointer<Unit>): Unit

    func textview_apply_select(view: CPointer<Unit>): Unit

    func textview_scroll_visible(view: CPointer<Unit>, horizontal: Bool, vertical: Bool): Unit

    func textview_editable(view: CPointer<Unit>, is_editable: Bool): Unit

    func textview_select(view: CPointer<Unit>, start: Int32, end: Int32): Unit

    func textview_show_select(view: CPointer<Unit>, show: Bool): Unit

    func textview_del_select(view: CPointer<Unit>): Unit

    func textview_scroll_caret(view: CPointer<Unit>): Unit

    func textview_get_text(view: CPointer<Unit>): CString

    func textview_copy(view: CPointer<Unit>): Unit

    func textview_cut(view: CPointer<Unit>): Unit

    func textview_paste(view: CPointer<Unit>): Unit

    func textview_wrap(view: CPointer<Unit>, wrap: Bool): Unit
}

public class TextView <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { textview_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): TextView {
        TextView(handle)
    }

    @EventHandler(textview_OnFilter)

    @EventHandler(textview_OnFocus)

    public func setSize(size: S2Df): Unit {
        unsafe { textview_size(m_handle, size) }
    }

    public func clear(): Unit {
        unsafe { textview_clear(m_handle) }
    }

    public func writef(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            textview_writef(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func cposWritef(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            textview_cpos_writef(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func rtf(data: Array<Byte>): Unit {
        unsafe {
            let size = UInt32(data.size)
            let rawData = acquireArrayRawData(data)
            rtf(rawData.pointer, size)
            releaseArrayRawData(rawData)
        }
    }

    public func rtf(dataPtr: CPointer<Byte>, size: UInt32): Unit {
        var stm = NStream(dataPtr, size)
        unsafe { textview_rtf(m_handle, stm.m_handle) }
        stm.close()
    }

    public func setUnits(units: UInt32): Unit {
        unsafe { textview_units(m_handle, units) }
    }

    public func setFamily(family: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(family)
            textview_family(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setFSize(size: Float32): Unit {
        unsafe { textview_fsize(m_handle, size) }
    }

    public func setFStyle(fstyle: FStyle): Unit {
        unsafe { textview_fstyle(m_handle, fstyle) }
    }

    public func setColor(color: Color): Unit {
        unsafe { textview_color(m_handle, color) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { textview_bgcolor(m_handle, color) }
    }

    public func setPgColor(color: Color): Unit {
        unsafe { textview_pgcolor(m_handle, color) }
    }

    public func setHAlign(align: Align): Unit {
        unsafe { textview_halign(m_handle, align) }
    }

    public func setLSpacing(scale: Float32): Unit {
        unsafe { textview_lspacing(m_handle, scale) }
    }

    public func setBfSpace(space: Float32): Unit {
        unsafe { textview_bfspace(m_handle, space) }
    }

    public func setAfSpace(space: Float32): Unit {
        unsafe { textview_afspace(m_handle, space) }
    }

    public func applyAll(): Unit {
        unsafe { textview_apply_all(m_handle) }
    }

    public func applySelect(): Unit {
        unsafe { textview_apply_select(m_handle) }
    }

    public func setScrollVisible(horizontal: Bool, vertical: Bool): Unit {
        unsafe { textview_scroll_visible(m_handle, horizontal, vertical) }
    }

    public func setEditable(isEditable: Bool): Unit {
        unsafe { textview_editable(m_handle, isEditable) }
    }

    public func select(start: Int32, end: Int32): Unit {
        unsafe { textview_select(m_handle, start, end) }
    }

    public func showSelect(show: Bool): Unit {
        unsafe { textview_show_select(m_handle, show) }
    }

    public func delSelect(): Unit {
        unsafe { textview_del_select(m_handle) }
    }

    public func scrollCaret(): Unit {
        unsafe { textview_scroll_caret(m_handle) }
    }

    public func getText(): String {
        unsafe { textview_get_text(m_handle).toString() }
    }

    public func copy(): Unit {
        unsafe { textview_copy(m_handle) }
    }

    public func cut(): Unit {
        unsafe { textview_cut(m_handle) }
    }

    public func paste(): Unit {
        unsafe { textview_paste(m_handle) }
    }

    public func setWrap(wrap: Bool): Unit {
        unsafe { textview_wrap(m_handle, wrap) }
    }
}
