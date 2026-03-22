package nappgui4cj

foreign {
    func label_create(): CPointer<Unit>

    func label_text(label: Label, text: CString): Unit

    func label_OnClick(label: Label, listener: Listener): Unit

    func label_min_width(label: Label, width: Float32): Unit

    func label_size_text(label: Label, text: CString): Unit

    func label_font(label: Label, font: CPointer<Unit>): Unit

    func label_style_over(label: Label, fstyle: FStyle): Unit

    func label_multiline(label: Label, multiline: Bool): Unit

    func label_align(label: Label, align: Align): Unit

    func label_color(label: Label, color: Color): Unit

    func label_color_over(label: Label, color: Color): Unit

    func label_bgcolor(label: Label, color: Color): Unit

    func label_bgcolor_over(label: Label, color: Color): Unit

    func label_trim(label: Label, ellipsis: Ellipsis): Unit

    func label_get_text(label: Label): CString

    func label_get_font(label: Label): CPointer<Unit>
}

@C
public struct Label {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { label_create() }
    }

    public static func create(): CPointer<Unit> {
        unsafe { label_create() }
    }

    public func setText(id: ResId): Unit {
        unsafe {
            label_text(this, id.cStr)
        }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            label_text(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func onClick<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { label_OnClick(this, listener) }
    }

    public func setMinWidth(width: Float32): Unit {
        unsafe { label_min_width(this, width) }
    }

    public func sizeText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            label_size_text(this, strPtr)
            LibC.free(strPtr)
        }
    }

    // public func setFont(font: CPointer<Unit>): Unit {
    //     unsafe { label_font(this, font) }
    // }

    public func setStyleOver(fstyle: FStyle): Unit {
        unsafe { label_style_over(this, fstyle) }
    }

    public func setMultiline(multiline: Bool): Unit {
        unsafe { label_multiline(this, multiline) }
    }

    public func setAlign(align: Align): Unit {
        unsafe { label_align(this, align) }
    }

    public func setColor(color: Color): Unit {
        unsafe { label_color(this, color) }
    }

    public func setColorOver(color: Color): Unit {
        unsafe { label_color_over(this, color) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { label_bgcolor(this, color) }
    }

    public func setBgColorOver(color: Color): Unit {
        unsafe { label_bgcolor_over(this, color) }
    }

    public func setTrim(ellipsis: Ellipsis): Unit {
        unsafe { label_trim(this, ellipsis) }
    }

    public func getText(): String {
        unsafe { label_get_text(this).toString() }
    }

    // public func getFont(): CPointer<Unit> {
    //     unsafe { label_get_font(m_handle) }
    // }
}
