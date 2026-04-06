package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func combo_create(): CPointer<Unit>

    func combo_OnFilter(combo: CPointer<Unit>, listener: Listener): Unit

    func combo_OnChange(combo: CPointer<Unit>, listener: Listener): Unit

    func combo_OnFocus(combo: CPointer<Unit>, listener: Listener): Unit

    func combo_OnSelect(combo: CPointer<Unit>, listener: Listener): Unit

    func combo_width(combo: CPointer<Unit>, width: Float32): Unit

    func combo_text(combo: CPointer<Unit>, text: CString): Unit

    func combo_align(combo: CPointer<Unit>, align: Align): Unit

    func combo_passmode(combo: CPointer<Unit>, passmode: Bool): Unit

    func combo_editable(combo: CPointer<Unit>, is_editable: Bool): Unit

    func combo_autoselect(combo: CPointer<Unit>, autoselect: Bool): Unit

    func combo_select(combo: CPointer<Unit>, start: Int32, end: Int32): Unit

    func combo_tooltip(combo: CPointer<Unit>, text: CString): Unit

    func combo_color(combo: CPointer<Unit>, color: UInt32): Unit

    func combo_color_focus(combo: CPointer<Unit>, color: UInt32): Unit

    func combo_bgcolor(combo: CPointer<Unit>, color: UInt32): Unit

    func combo_bgcolor_focus(combo: CPointer<Unit>, color: UInt32): Unit

    func combo_phtext(combo: CPointer<Unit>, text: CString): Unit

    func combo_phcolor(combo: CPointer<Unit>, color: UInt32): Unit

    func combo_phstyle(combo: CPointer<Unit>, fstyle: UInt32): Unit

    func combo_copy(combo: CPointer<Unit>): Unit

    func combo_cut(combo: CPointer<Unit>): Unit

    func combo_paste(combo: CPointer<Unit>): Unit

    func combo_add_elem(combo: CPointer<Unit>, text: CString, image: CPointer<Unit>): Unit

    func combo_set_elem(combo: CPointer<Unit>, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func combo_ins_elem(combo: CPointer<Unit>, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func combo_del_elem(combo: CPointer<Unit>, index: UInt32): Unit

    func combo_clear(combo: CPointer<Unit>): Unit

    func combo_count(combo: CPointer<Unit>): UInt32

    func combo_list_height(combo: CPointer<Unit>, elems: UInt32): Unit

    func combo_selected(combo: CPointer<Unit>, index: UInt32): Unit

    func combo_get_selected(combo: CPointer<Unit>): UInt32

    func combo_get_text(combo: CPointer<Unit>, index: UInt32): CString

    func combo_get_image(combo: CPointer<Unit>, index: UInt32): CPointer<Unit>
}

public class Combo <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { combo_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Combo {
        Combo(handle)
    }

    @EventHandler(combo_OnFilter)

    @EventHandler(combo_OnChange)

    @EventHandler(combo_OnFocus)

    @EventHandler(combo_OnSelect)

    public func setWidth(width: Float32): Unit {
        unsafe { combo_width(m_handle, width) }
    }

    public func setText(id: ResId): Unit {
        unsafe {
            combo_text(m_handle, id.cStr)
        }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            combo_text(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setAlign(align: Align): Unit {
        unsafe { combo_align(m_handle, align) }
    }

    public func setPassMode(passmode: Bool): Unit {
        unsafe { combo_passmode(m_handle, passmode) }
    }

    public func setEditable(isEditable: Bool): Unit {
        unsafe { combo_editable(m_handle, isEditable) }
    }

    public func setAutoSelect(autoselect: Bool): Unit {
        unsafe { combo_autoselect(m_handle, autoselect) }
    }

    public func select(start: Int32, end: Int32): Unit {
        unsafe { combo_select(m_handle, start, end) }
    }

    public func setTooltip(id: ResId): Unit {
        unsafe {
            combo_tooltip(m_handle, id.cStr)
        }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            combo_tooltip(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setColor(color: UInt32): Unit {
        unsafe { combo_color(m_handle, color) }
    }

    public func setColorFocus(color: UInt32): Unit {
        unsafe { combo_color_focus(m_handle, color) }
    }

    public func setBgColor(color: UInt32): Unit {
        unsafe { combo_bgcolor(m_handle, color) }
    }

    public func setBgColorFocus(color: UInt32): Unit {
        unsafe { combo_bgcolor_focus(m_handle, color) }
    }

    public func setPlaceholderText(id: ResId): Unit {
        unsafe {
            combo_phtext(m_handle, id.cStr)
        }
    }

    public func setPlaceholderText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            combo_phtext(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setPlaceholderColor(color: UInt32): Unit {
        unsafe { combo_phcolor(m_handle, color) }
    }

    public func setPlaceholderStyle(fstyle: UInt32): Unit {
        unsafe { combo_phstyle(m_handle, fstyle) }
    }

    public func copy(): Unit {
        unsafe { combo_copy(m_handle) }
    }

    public func cut(): Unit {
        unsafe { combo_cut(m_handle) }
    }

    public func paste(): Unit {
        unsafe { combo_paste(m_handle) }
    }

    public func addItem(id: ResId): Unit {
        addItem(id, None)
    }

    public func addItem(id: ResId, image: ?Image): Unit {
        unsafe { combo_add_elem(m_handle, id.cStr, image?.m_handle ?? CPointer()) }
    }

    public func addItem(text: String): Unit {
        addItem(text, None)
    }

    public func addItem(text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            combo_add_elem(m_handle, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func setItem(index: UInt32, text: String): Unit {
        setItem(index, text, None)
    }

    public func setItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            combo_set_elem(m_handle, index, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func insertItem(index: UInt32, text: String): Unit {
        insertItem(index, text, None)
    }

    public func insertItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            combo_ins_elem(m_handle, index, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func delItem(index: UInt32): Unit {
        unsafe { combo_del_elem(m_handle, index) }
    }

    public func clear(): Unit {
        unsafe { combo_clear(m_handle) }
    }

    public func count(): UInt32 {
        unsafe { combo_count(m_handle) }
    }

    public func setListHeight(elems: UInt32): Unit {
        unsafe { combo_list_height(m_handle, elems) }
    }

    public func setSelected(index: UInt32): Unit {
        unsafe { combo_selected(m_handle, index) }
    }

    public func getSelected(): UInt32 {
        unsafe { combo_get_selected(m_handle) }
    }

    public func getText(index: UInt32): ?String {
        unsafe {
            let strPtr = combo_get_text(m_handle, index)
            if (strPtr.isNull()) {
                return None
            }
            return strPtr.toString()
        }
    }

    public func getImage(index: UInt32): ?Image {
        unsafe {
            let handle = combo_get_image(m_handle, index)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }
}
