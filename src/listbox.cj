package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func listbox_create(): CPointer<Unit>

    func listbox_OnDown(listbox: CPointer<Unit>, listener: Listener): Unit

    func listbox_OnSelect(listbox: CPointer<Unit>, listener: Listener): Unit

    func listbox_size(listbox: CPointer<Unit>, size: S2Df): Unit

    func listbox_checkbox(listbox: CPointer<Unit>, show: Bool): Unit

    func listbox_multisel(listbox: CPointer<Unit>, multisel: Bool): Unit

    func listbox_add_elem(listbox: CPointer<Unit>, text: CString, image: CPointer<Unit>): Unit

    func listbox_set_elem(listbox: CPointer<Unit>, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func listbox_del_elem(listbox: CPointer<Unit>, index: UInt32): Unit

    func listbox_font(listbox: CPointer<Unit>, font: CPointer<Unit>): Unit

    func listbox_clear(listbox: CPointer<Unit>): Unit

    func listbox_color(listbox: CPointer<Unit>, index: UInt32, color: Color): Unit

    func listbox_select(listbox: CPointer<Unit>, index: UInt32, select: Bool): Unit

    func listbox_check(listbox: CPointer<Unit>, index: UInt32, check: Bool): Unit

    func listbox_count(listbox: CPointer<Unit>): UInt32

    func listbox_get_text(listbox: CPointer<Unit>, index: UInt32): CString

    func listbox_get_image(listbox: CPointer<Unit>, index: UInt32): CPointer<Unit>

    func listbox_get_selected(listbox: CPointer<Unit>): UInt32

    func listbox_get_row_height(listbox: CPointer<Unit>): Float32

    func listbox_selected(listbox: CPointer<Unit>, index: UInt32): Bool

    func listbox_checked(listbox: CPointer<Unit>, index: UInt32): Bool
}

public class ListBox <: GuiControl {
    var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { listbox_create() }
    }

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): ListBox {
        ListBox(handle)
    }

    @EventHandler(listbox_OnDown)

    @EventHandler(listbox_OnSelect)

    public func setSize(size: S2Df): Unit {
        unsafe { listbox_size(m_handle, size) }
    }

    public func setCheckbox(show: Bool): Unit {
        unsafe { listbox_checkbox(m_handle, show) }
    }

    public func setMultisel(multisel: Bool): Unit {
        unsafe { listbox_multisel(m_handle, multisel) }
    }

    public func addItem(text: String): Unit {
        addItem(text, None)
    }

    public func addItem(text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            listbox_add_elem(m_handle, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func setItem(index: UInt32, text: String): Unit {
        setItem(index, text, None)
    }

    public func setItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            listbox_set_elem(m_handle, index, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func delItem(index: UInt32): Unit {
        unsafe { listbox_del_elem(m_handle, index) }
    }

    public func setFont(font: CPointer<Unit>): Unit {
        unsafe { listbox_font(m_handle, font) }
    }

    public func clear(): Unit {
        unsafe { listbox_clear(m_handle) }
    }

    public func setColor(index: UInt32, color: Color): Unit {
        unsafe { listbox_color(m_handle, index, color) }
    }

    public func select(index: UInt32, select: Bool): Unit {
        unsafe { listbox_select(m_handle, index, select) }
    }

    public func check(index: UInt32, check: Bool): Unit {
        unsafe { listbox_check(m_handle, index, check) }
    }

    public func count(): UInt32 {
        unsafe { listbox_count(m_handle) }
    }

    public func getText(index: UInt32): String {
        unsafe { listbox_get_text(m_handle, index).toString() }
    }

    public func getImage(index: UInt32): ?Image {
        unsafe {
            let handle = listbox_get_image(m_handle, index)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }

    public func getSelected(): UInt32 {
        unsafe { listbox_get_selected(m_handle) }
    }

    public func getRowHeight(): Float32 {
        unsafe { listbox_get_row_height(m_handle) }
    }

    public func isSelected(index: UInt32): Bool {
        unsafe { listbox_selected(m_handle, index) }
    }

    public func isChecked(index: UInt32): Bool {
        unsafe { listbox_checked(m_handle, index) }
    }
}
