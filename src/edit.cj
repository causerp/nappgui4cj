package nappgui4cj

foreign {
    func edit_create(): CPointer<Unit>

    func edit_multiline(): CPointer<Unit>

    func edit_OnFilter(edit: Edit, listener: Listener): Unit

    func edit_OnChange(edit: Edit, listener: Listener): Unit

    func edit_OnFocus(edit: Edit, listener: Listener): Unit

    func edit_min_width(edit: Edit, width: Float32): Unit

    func edit_min_height(edit: Edit, height: Float32): Unit

    func edit_text(edit: Edit, text: CString): Unit

    func edit_font(edit: Edit, font: CPointer<Unit>): Unit

    func edit_align(edit: Edit, align: UInt32): Unit

    func edit_passmode(edit: Edit, passmode: Bool): Unit

    func edit_editable(edit: Edit, is_editable: Bool): Unit

    func edit_autoselect(edit: Edit, autoselect: Bool): Unit

    func edit_select(edit: Edit, start: Int32, end: Int32): Unit

    func edit_tooltip(edit: Edit, text: CString): Unit

    func edit_color(edit: Edit, color: Color): Unit

    func edit_color_focus(edit: Edit, color: Color): Unit

    func edit_bgcolor(edit: Edit, color: Color): Unit

    func edit_bgcolor_focus(edit: Edit, color: Color): Unit

    func edit_phtext(edit: Edit, text: CString): Unit

    func edit_phcolor(edit: Edit, color: Color): Unit

    func edit_phstyle(edit: Edit, fstyle: UInt32): Unit

    func edit_vpadding(edit: Edit, padding: Float32): Unit

    func edit_copy(edit: Edit): Unit

    func edit_cut(edit: Edit): Unit

    func edit_paste(edit: Edit): Unit

    func edit_get_text(edit: Edit): CString

    func edit_get_height(edit: Edit): Float32
}

@C
public struct Edit {
    private var m_handle: CPointer<Unit>

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { edit_create() }
    }

    public static func createMultiline(): Edit {
        Edit(unsafe { edit_multiline() })
    }

    public func onFilter<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { edit_OnFilter(this, listener) }
    }

    public func onChange<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { edit_OnChange(this, listener) }
    }

    public func onFocus<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { edit_OnFocus(this, listener) }
    }

    public func setMinWidth(width: Float32): Unit {
        unsafe { edit_min_width(this, width) }
    }

    public func setMinHeight(height: Float32): Unit {
        unsafe { edit_min_height(this, height) }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            edit_text(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setFont(font: CPointer<Unit>): Unit {
        unsafe { edit_font(this, font) }
    }

    public func setAlign(align: Align): Unit {
        unsafe { edit_align(this, align.value) }
    }

    public func setPassMode(passmode: Bool): Unit {
        unsafe { edit_passmode(this, passmode) }
    }

    public func setEditable(isEditable: Bool): Unit {
        unsafe { edit_editable(this, isEditable) }
    }

    public func setAutoSelect(autoselect: Bool): Unit {
        unsafe { edit_autoselect(this, autoselect) }
    }

    public func setSelect(start: Int32, end: Int32): Unit {
        unsafe { edit_select(this, start, end) }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            edit_tooltip(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setColor(color: Color): Unit {
        unsafe { edit_color(this, color) }
    }

    public func setColorFocus(color: Color): Unit {
        unsafe { edit_color_focus(this, color) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { edit_bgcolor(this, color) }
    }

    public func setBgColorFocus(color: Color): Unit {
        unsafe { edit_bgcolor_focus(this, color) }
    }

    public func setPlaceholderText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            edit_phtext(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setPlaceholderColor(color: Color): Unit {
        unsafe { edit_phcolor(this, color) }
    }

    public func setPlaceholderStyle(fstyle: UInt32): Unit {
        unsafe { edit_phstyle(this, fstyle) }
    }

    public func setVPadding(padding: Float32): Unit {
        unsafe { edit_vpadding(this, padding) }
    }

    public func copy(): Unit {
        unsafe { edit_copy(this) }
    }

    public func cut(): Unit {
        unsafe { edit_cut(this) }
    }

    public func paste(): Unit {
        unsafe { edit_paste(this) }
    }

    public func getText(): String {
        unsafe { edit_get_text(this).toString() }
    }

    public func getHeight(): Float32 {
        unsafe { edit_get_height(this) }
    }
}
