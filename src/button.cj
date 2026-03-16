package nappgui4cj

foreign {
    func button_push(): CPointer<Unit>

    func button_check(): CPointer<Unit>

    func button_check3(): CPointer<Unit>

    func button_radio(): CPointer<Unit>

    func button_flat(): CPointer<Unit>

    func button_flatgle(): CPointer<Unit>

    func button_OnClick(button: Button, listener: Listener): Unit

    func button_min_width(button: Button, width: Float32): Unit

    func button_text(button: Button, text: CString): Unit

    func button_text_alt(button: Button, text: CString): Unit

    func button_tooltip(button: Button, text: CString): Unit

    func button_font(button: Button, font: CPointer<Unit>): Unit

    func button_image(button: Button, image: CPointer<Unit>): Unit

    func button_image_alt(button: Button, image: CPointer<Unit>): Unit

    func button_state(button: Button, state: GUIState): Unit

    func button_tag(button: Button, tag: UInt32): Unit

    func button_hpadding(button: Button, padding: Float32): Unit

    func button_vpadding(button: Button, padding: Float32): Unit

    func button_get_state(button: Button): GUIState

    func button_get_text(button: Button): CString

    func button_get_font(button: Button): CPointer<Unit>

    func button_get_image(button: Button): CPointer<Unit>

    func button_get_image_alt(button: Button): CPointer<Unit>

    func button_get_tag(button: Button): UInt32

    func button_get_height(button: Button): Float32
}

@C
public struct Button {
    private var m_handle: CPointer<Unit>

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public static func createPush(): Button {
        Button(unsafe { button_push() })
    }

    public static func createCheck(): Button {
        Button(unsafe { button_check() })
    }

    public static func createCheck3(): Button {
        Button(unsafe { button_check3() })
    }

    public static func createRadio(): Button {
        Button(unsafe { button_radio() })
    }

    public static func createFlat(): Button {
        Button(unsafe { button_flat() })
    }

    public static func createFlatgle(): Button {
        Button(unsafe { button_flatgle() })
    }

    public func onClick<T>(obj: CPointer<T>, function: EventHandlerFunc<T>): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { button_OnClick(this, listener) }
    }

    public func setMinWidth(width: Float32): Unit {
        unsafe { button_min_width(this, width) }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            button_text(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setTextAlt(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            button_text_alt(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            button_tooltip(this, strPtr)
            LibC.free(strPtr)
        }
    }

    // public func setFont(font: CPointer<Unit>): Unit {
    //     unsafe { button_font(this, font) }
    // }

    // public func setImage(image: CPointer<Unit>): Unit {
    //     unsafe { button_image(this, image) }
    // }

    // public func setImageAlt(image: CPointer<Unit>): Unit {
    //     unsafe { button_image_alt(this, image) }
    // }

    public func setState(state: GUIState): Unit {
        unsafe { button_state(this, state) }
    }

    public func setTag(tag: UInt32): Unit {
        unsafe { button_tag(this, tag) }
    }

    public func setHPadding(padding: Float32): Unit {
        unsafe { button_hpadding(this, padding) }
    }

    public func setVPadding(padding: Float32): Unit {
        unsafe { button_vpadding(this, padding) }
    }

    public func getState(): GUIState {
        unsafe { button_get_state(this) }
    }

    public func getText(): String {
        unsafe { button_get_text(this).toString() }
    }

    // public func getFont(): CPointer<Unit> {
    //     unsafe { button_get_font(this) }
    // }

    // public func getImage(): CPointer<Unit> {
    //     unsafe { button_get_image(this) }
    // }

    // public func getImageAlt(): CPointer<Unit> {
    //     unsafe { button_get_image_alt(this) }
    // }

    public func getTag(): UInt32 {
        unsafe { button_get_tag(this) }
    }

    public func getHeight(): Float32 {
        unsafe { button_get_height(this) }
    }
}
