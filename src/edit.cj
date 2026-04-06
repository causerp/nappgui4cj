package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func edit_create(): CPointer<Unit>

    func edit_multiline(): CPointer<Unit>

    func edit_OnFilter(edit: CPointer<Unit>, listener: Listener): Unit

    func edit_OnChange(edit: CPointer<Unit>, listener: Listener): Unit

    func edit_OnFocus(edit: CPointer<Unit>, listener: Listener): Unit

    func edit_width(edit: CPointer<Unit>, width: Float32): Unit

    func edit_height(edit: CPointer<Unit>, height: Float32): Unit

    func edit_text(edit: CPointer<Unit>, text: CString): Unit

    func edit_font(edit: CPointer<Unit>, font: CPointer<Unit>): Unit

    func edit_align(edit: CPointer<Unit>, align: UInt32): Unit

    func edit_passmode(edit: CPointer<Unit>, passmode: Bool): Unit

    func edit_editable(edit: CPointer<Unit>, is_editable: Bool): Unit

    func edit_autoselect(edit: CPointer<Unit>, autoselect: Bool): Unit

    func edit_select(edit: CPointer<Unit>, start: Int32, end: Int32): Unit

    func edit_tooltip(edit: CPointer<Unit>, text: CString): Unit

    func edit_color(edit: CPointer<Unit>, color: Color): Unit

    func edit_color_focus(edit: CPointer<Unit>, color: Color): Unit

    func edit_bgcolor(edit: CPointer<Unit>, color: Color): Unit

    func edit_bgcolor_focus(edit: CPointer<Unit>, color: Color): Unit

    func edit_phtext(edit: CPointer<Unit>, text: CString): Unit

    func edit_phcolor(edit: CPointer<Unit>, color: Color): Unit

    func edit_phstyle(edit: CPointer<Unit>, fstyle: UInt32): Unit

    func edit_vpadding(edit: CPointer<Unit>, padding: Float32): Unit

    func edit_copy(edit: CPointer<Unit>): Unit

    func edit_cut(edit: CPointer<Unit>): Unit

    func edit_paste(edit: CPointer<Unit>): Unit

    func edit_get_text(edit: CPointer<Unit>): CString

    func edit_get_height(edit: CPointer<Unit>): Float32
}

public enum EditType {
    | EdSingle
    | EdMulti
}

public class Edit <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { edit_create() }
    }

    public init(editType: EditType) {
        m_handle = match (editType) {
            case EdSingle => unsafe { edit_create() }
            case EdMulti => unsafe { edit_multiline() }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Edit {
        Edit(handle)
    }

    @EventHandler(edit_OnFilter)

    @EventHandler(edit_OnChange)

    @EventHandler(edit_OnFocus)

    public func setWidth(width: Float32): Unit {
        unsafe { edit_width(m_handle, width) }
    }

    public func setHeight(height: Float32): Unit {
        unsafe { edit_height(m_handle, height) }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            edit_text(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setFont(font: CPointer<Unit>): Unit {
        unsafe { edit_font(m_handle, font) }
    }

    public func setAlign(align: Align): Unit {
        unsafe { edit_align(m_handle, align.value) }
    }

    public func setPassMode(passmode: Bool): Unit {
        unsafe { edit_passmode(m_handle, passmode) }
    }

    public func setEditable(isEditable: Bool): Unit {
        unsafe { edit_editable(m_handle, isEditable) }
    }

    public func setAutoSelect(autoselect: Bool): Unit {
        unsafe { edit_autoselect(m_handle, autoselect) }
    }

    public func setSelect(start: Int32, end: Int32): Unit {
        unsafe { edit_select(m_handle, start, end) }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            edit_tooltip(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setColor(color: Color): Unit {
        unsafe { edit_color(m_handle, color) }
    }

    public func setColorFocus(color: Color): Unit {
        unsafe { edit_color_focus(m_handle, color) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { edit_bgcolor(m_handle, color) }
    }

    public func setBgColorFocus(color: Color): Unit {
        unsafe { edit_bgcolor_focus(m_handle, color) }
    }

    public func setPlaceholderText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            edit_phtext(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setPlaceholderColor(color: Color): Unit {
        unsafe { edit_phcolor(m_handle, color) }
    }

    public func setPlaceholderStyle(fstyle: UInt32): Unit {
        unsafe { edit_phstyle(m_handle, fstyle) }
    }

    public func setVPadding(padding: Float32): Unit {
        unsafe { edit_vpadding(m_handle, padding) }
    }

    public func copy(): Unit {
        unsafe { edit_copy(m_handle) }
    }

    public func cut(): Unit {
        unsafe { edit_cut(m_handle) }
    }

    public func paste(): Unit {
        unsafe { edit_paste(m_handle) }
    }

    public func getText(): String {
        unsafe { edit_get_text(m_handle).toString() }
    }

    public func getHeight(): Float32 {
        unsafe { edit_get_height(m_handle) }
    }
}
