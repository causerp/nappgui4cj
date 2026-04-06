package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func popup_create(): CPointer<Unit>

    func popup_OnSelect(popup: CPointer<Unit>, listener: Listener): Unit

    func popup_tooltip(popup: CPointer<Unit>, text: CString): Unit

    func popup_add_elem(popup: CPointer<Unit>, text: CString, image: CPointer<Unit>): Unit

    func popup_set_elem(popup: CPointer<Unit>, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func popup_ins_elem(popup: CPointer<Unit>, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func popup_del_elem(popup: CPointer<Unit>, index: UInt32): Unit

    func popup_clear(popup: CPointer<Unit>): Unit

    func popup_count(popup: CPointer<Unit>): UInt32

    func popup_list_height(popup: CPointer<Unit>, elems: UInt32): Unit

    func popup_selected(popup: CPointer<Unit>, index: UInt32): Unit

    func popup_get_selected(popup: CPointer<Unit>): UInt32

    func popup_get_text(popup: CPointer<Unit>, index: UInt32): CString

    func popup_get_image(popup: CPointer<Unit>, index: UInt32): CPointer<Unit>
}

public class PopUp <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { popup_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): PopUp {
        PopUp(handle)
    }

    @EventHandler(popup_OnSelect)

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            popup_tooltip(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func addItem(id: ResId): Unit {
        addItem(id, None)
    }

    public func addItem(id: ResId, image: ?Image): Unit {
        unsafe { popup_add_elem(m_handle, id.cStr, image?.m_handle ?? CPointer()) }
    }

    public func addItem(text: String): Unit {
        addItem(text, None)
    }

    public func addItem(text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            popup_add_elem(m_handle, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func setItem(index: UInt32, text: String): Unit {
        setItem(index, text, None)
    }

    public func setItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            popup_set_elem(m_handle, index, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func insertItem(index: UInt32, text: String): Unit {
        insertItem(index, text, None)
    }

    public func insertItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            popup_ins_elem(m_handle, index, strPtr, image?.m_handle ?? CPointer())
            LibC.free(strPtr)
        }
    }

    public func deleteItem(index: UInt32): Unit {
        unsafe { popup_del_elem(m_handle, index) }
    }

    public func clear(): Unit {
        unsafe { popup_clear(m_handle) }
    }

    public func count(): UInt32 {
        unsafe { popup_count(m_handle) }
    }

    public func setListHeight(elems: UInt32): Unit {
        unsafe { popup_list_height(m_handle, elems) }
    }

    public func setSelected(index: UInt32): Unit {
        unsafe { popup_selected(m_handle, index) }
    }

    public func getSelected(): UInt32 {
        unsafe { popup_get_selected(m_handle) }
    }

    public func getText(index: UInt32): ?String {
        unsafe {
            let strPtr = popup_get_text(m_handle, index)
            if (strPtr.isNull()) {
                return None
            }
            return strPtr.toString()
        }
    }

    public func getImage(index: UInt32): ?Image {
        unsafe {
            let handle = popup_get_image(m_handle, index)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }
}
