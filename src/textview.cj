package nappgui4cj

foreign {
    func textview_create(): CPointer<Unit>

    func textview_OnFilter(view: TextView, listener: Listener): Unit

    func textview_OnFocus(view: TextView, listener: Listener): Unit

    func textview_size(view: TextView, size: S2Df): Unit

    func textview_clear(view: TextView): Unit

    // func textview_printf(view: TextView, format: CString, ...): UInt32

    func textview_writef(view: TextView, text: CString): Unit

    // func textview_cpos_printf(view: TextView, format: CString, ...): UInt32

    func textview_cpos_writef(view: TextView, text: CString): Unit

    func textview_rtf(view: TextView, rtf_in: CPointer<Unit>): Unit

    func textview_units(view: TextView, units: UInt32): Unit

    func textview_family(view: TextView, family: CString): Unit

    func textview_fsize(view: TextView, size: Float32): Unit

    func textview_fstyle(view: TextView, fstyle: UInt32): Unit

    func textview_color(view: TextView, color: Color): Unit

    func textview_bgcolor(view: TextView, color: Color): Unit

    func textview_pgcolor(view: TextView, color: Color): Unit

    func textview_halign(view: TextView, align: Align): Unit

    func textview_lspacing(view: TextView, scale: Float32): Unit

    func textview_bfspace(view: TextView, space: Float32): Unit

    func textview_afspace(view: TextView, space: Float32): Unit

    func textview_apply_all(view: TextView): Unit

    func textview_apply_select(view: TextView): Unit

    func textview_scroll_visible(view: TextView, horizontal: Bool, vertical: Bool): Unit

    func textview_editable(view: TextView, is_editable: Bool): Unit

    func textview_select(view: TextView, start: Int32, end: Int32): Unit

    func textview_show_select(view: TextView, show: Bool): Unit

    func textview_del_select(view: TextView): Unit

    func textview_scroll_caret(view: TextView): Unit

    func textview_get_text(view: TextView): CString

    func textview_copy(view: TextView): Unit

    func textview_cut(view: TextView): Unit

    func textview_paste(view: TextView): Unit

    func textview_wrap(view: TextView, wrap: Bool): Unit
}

@C
public struct TextView {
    private var m_handle: CPointer<Unit> = CPointer()

    public init() {
        m_handle = unsafe { textview_create() }
    }

    public func onFilter(listener: Listener): Unit {
        unsafe { textview_OnFilter(this, listener) }
    }

    public func onFocus(listener: Listener): Unit {
        unsafe { textview_OnFocus(this, listener) }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { textview_size(this, size) }
    }

    public func clear(): Unit {
        unsafe { textview_clear(this) }
    }

    public func writef(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            textview_writef(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func cposWritef(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            textview_cpos_writef(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func rtf(rtfIn: CPointer<Unit>): Unit {
        unsafe { textview_rtf(this, rtfIn) }
    }

    public func setUnits(units: UInt32): Unit {
        unsafe { textview_units(this, units) }
    }

    public func setFamily(family: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(family)
            textview_family(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setFSize(size: Float32): Unit {
        unsafe { textview_fsize(this, size) }
    }

    public func setFStyle(fstyle: UInt32): Unit {
        unsafe { textview_fstyle(this, fstyle) }
    }

    public func setColor(color: Color): Unit {
        unsafe { textview_color(this, color) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { textview_bgcolor(this, color) }
    }

    public func setPgColor(color: Color): Unit {
        unsafe { textview_pgcolor(this, color) }
    }

    public func setHAlign(align: Align): Unit {
        unsafe { textview_halign(this, align) }
    }

    public func setLSpacing(scale: Float32): Unit {
        unsafe { textview_lspacing(this, scale) }
    }

    public func setBfSpace(space: Float32): Unit {
        unsafe { textview_bfspace(this, space) }
    }

    public func setAfSpace(space: Float32): Unit {
        unsafe { textview_afspace(this, space) }
    }

    public func applyAll(): Unit {
        unsafe { textview_apply_all(this) }
    }

    public func applySelect(): Unit {
        unsafe { textview_apply_select(this) }
    }

    public func setScrollVisible(horizontal: Bool, vertical: Bool): Unit {
        unsafe { textview_scroll_visible(this, horizontal, vertical) }
    }

    public func setEditable(isEditable: Bool): Unit {
        unsafe { textview_editable(this, isEditable) }
    }

    public func select(start: Int32, end: Int32): Unit {
        unsafe { textview_select(this, start, end) }
    }

    public func showSelect(show: Bool): Unit {
        unsafe { textview_show_select(this, show) }
    }

    public func delSelect(): Unit {
        unsafe { textview_del_select(this) }
    }

    public func scrollCaret(): Unit {
        unsafe { textview_scroll_caret(this) }
    }

    public func getText(): String {
        unsafe { textview_get_text(this).toString() }
    }

    public func copy(): Unit {
        unsafe { textview_copy(this) }
    }

    public func cut(): Unit {
        unsafe { textview_cut(this) }
    }

    public func paste(): Unit {
        unsafe { textview_paste(this) }
    }

    public func setWrap(wrap: Bool): Unit {
        unsafe { textview_wrap(this, wrap) }
    }
}
