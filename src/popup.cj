package nappgui4cj

foreign {
    func popup_create(): CPointer<Unit>

    func popup_OnSelect(popup: PopUp, listener: Listener): Unit

    func popup_tooltip(popup: PopUp, text: CString): Unit

    func popup_add_elem(popup: PopUp, text: CString, image: CPointer<Unit>): Unit

    func popup_set_elem(popup: PopUp, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func popup_ins_elem(popup: PopUp, index: UInt32, text: CString, image: CPointer<Unit>): Unit

    func popup_del_elem(popup: PopUp, index: UInt32): Unit

    func popup_clear(popup: PopUp): Unit

    func popup_count(popup: PopUp): UInt32

    func popup_list_height(popup: PopUp, elems: UInt32): Unit

    func popup_selected(popup: PopUp, index: UInt32): Unit

    func popup_get_selected(popup: PopUp): UInt32

    func popup_get_text(popup: PopUp, index: UInt32): CString

    func popup_get_image(popup: PopUp, index: UInt32): CPointer<Unit>
}

@C
public struct PopUp {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { popup_create() }
    }

    public func onSelect<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { popup_OnSelect(this, listener) }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            popup_tooltip(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func addItem(id: ResId, image: ?Image): Unit {
        unsafe {
            match (image) {
                case Some(image) => popup_add_elem(this, id.cStr, image.handle)
                case None => popup_add_elem(this, id.cStr, CPointer())
            }
        }
    }

    public func addItem(text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            match (image) {
                case Some(image) => popup_add_elem(this, strPtr, image.handle)
                case None => popup_add_elem(this, strPtr, CPointer())
            }
            LibC.free(strPtr)
        }
    }

    public func setItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            match (image) {
                case Some(image) => popup_set_elem(this, index, strPtr, image.handle)
                case None => popup_set_elem(this, index, strPtr, CPointer())
            }
            LibC.free(strPtr)
        }
    }

    public func insertItem(index: UInt32, text: String, image: ?Image): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            match (image) {
                case Some(image) => popup_ins_elem(this, index, strPtr, image.handle)
                case None => popup_ins_elem(this, index, strPtr, CPointer())
            }
            LibC.free(strPtr)
        }
    }

    public func deleteItem(index: UInt32): Unit {
        unsafe { popup_del_elem(this, index) }
    }

    public func clear(): Unit {
        unsafe { popup_clear(this) }
    }

    public func count(): UInt32 {
        unsafe { popup_count(this) }
    }

    public func setListHeight(elems: UInt32): Unit {
        unsafe { popup_list_height(this, elems) }
    }

    public func setSelected(index: UInt32): Unit {
        unsafe { popup_selected(this, index) }
    }

    public func getSelected(): UInt32 {
        unsafe { popup_get_selected(this) }
    }

    public func getText(index: UInt32): ?String {
        unsafe {
            let strPtr = popup_get_text(this, index)
            if (strPtr.isNull()) {
                return None
            }
            return strPtr.toString()
        }
    }

    public func getImage(index: UInt32): ?Image {
        unsafe {
            let handle = popup_get_image(this, index)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }
}
