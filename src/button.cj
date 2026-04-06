package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func button_push(): CPointer<Unit>

    func button_check(): CPointer<Unit>

    func button_check3(): CPointer<Unit>

    func button_radio(): CPointer<Unit>

    func button_flat(): CPointer<Unit>

    func button_flatgle(): CPointer<Unit>

    func button_OnClick(button: CPointer<Unit>, listener: Listener): Unit

    func button_width(button: CPointer<Unit>, width: Float32): Unit

    func button_text(button: CPointer<Unit>, text: CString): Unit

    func button_text_alt(button: CPointer<Unit>, text: CString): Unit

    func button_tooltip(button: CPointer<Unit>, text: CString): Unit

    func button_font(button: CPointer<Unit>, font: CPointer<Unit>): Unit

    func button_image(button: CPointer<Unit>, image: CPointer<Unit>): Unit

    func button_image_alt(button: CPointer<Unit>, image: CPointer<Unit>): Unit

    func button_state(button: CPointer<Unit>, state: GUIState): Unit

    func button_tag(button: CPointer<Unit>, tag: UInt32): Unit

    func button_hpadding(button: CPointer<Unit>, padding: Float32): Unit

    func button_vpadding(button: CPointer<Unit>, padding: Float32): Unit

    func button_get_state(button: CPointer<Unit>): GUIState

    func button_get_text(button: CPointer<Unit>): CString

    func button_get_font(button: CPointer<Unit>): CPointer<Unit>

    func button_get_image(button: CPointer<Unit>): CPointer<Unit>

    func button_get_image_alt(button: CPointer<Unit>): CPointer<Unit>

    func button_get_tag(button: CPointer<Unit>): UInt32

    func button_get_height(button: CPointer<Unit>): Float32
}

public enum ButtonType {
    | BtnPush
    | BtnCheck
    | BtnCheck3
    | BtnRadio
    | BtnFlat
    | BtnFlatgle
}

public class Button <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(buttonType: ButtonType) {
        m_handle = match (buttonType) {
            case BtnPush => unsafe { button_push() }
            case BtnCheck => unsafe { button_check() }
            case BtnCheck3 => unsafe { button_check3() }
            case BtnRadio => unsafe { button_radio() }
            case BtnFlat => unsafe { button_flat() }
            case BtnFlatgle => unsafe { button_flatgle() }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Button {
        Button(handle)
    }

    @EventHandler(button_OnClick)

    public func setWidth(width: Float32): Unit {
        unsafe { button_width(m_handle, width) }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            button_text(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setTextAlt(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            button_text_alt(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            button_tooltip(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setFont(font: Font): Unit {
        unsafe { button_font(m_handle, font.m_handle) }
    }

    public func setImage(image: ?Image): Unit {
        unsafe { button_image(m_handle, image?.m_handle ?? CPointer()) }
    }

    public func setImageAlt(image: ?Image): Unit {
        unsafe { button_image_alt(m_handle, image?.m_handle ?? CPointer()) }
    }

    public func setState(state: GUIState): Unit {
        unsafe { button_state(m_handle, state) }
    }

    public func setTag(tag: UInt32): Unit {
        unsafe { button_tag(m_handle, tag) }
    }

    public func setHPadding(padding: Float32): Unit {
        unsafe { button_hpadding(m_handle, padding) }
    }

    public func setVPadding(padding: Float32): Unit {
        unsafe { button_vpadding(m_handle, padding) }
    }

    public func getState(): GUIState {
        unsafe { button_get_state(m_handle) }
    }

    public func getText(): String {
        unsafe { button_get_text(m_handle).toString() }
    }

    public func getFont(): Font {
        unsafe { Font(button_get_font(m_handle)) }
    }

    public func getImage(): ?Image {
        unsafe {
            let handle = button_get_image(m_handle)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }

    public func getImageAlt(): ?Image {
        unsafe {
            let handle = button_get_image_alt(m_handle)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }

    public func getTag(): UInt32 {
        unsafe { button_get_tag(m_handle) }
    }

    public func getHeight(): Float32 {
        unsafe { button_get_height(m_handle) }
    }
}
