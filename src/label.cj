package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func label_create(): CPointer<Unit>

    func label_text(label: CPointer<Unit>, text: CString): Unit

    func label_OnClick(label: CPointer<Unit>, listener: Listener): Unit

    func label_width(label: CPointer<Unit>, width: Float32): Unit

    func label_size_text(label: CPointer<Unit>, text: CString): Unit

    func label_font(label: CPointer<Unit>, font: CPointer<Unit>): Unit

    func label_style_over(label: CPointer<Unit>, fstyle: FStyle): Unit

    func label_multiline(label: CPointer<Unit>, multiline: Bool): Unit

    func label_align(label: CPointer<Unit>, align: Align): Unit

    func label_color(label: CPointer<Unit>, color: Color): Unit

    func label_color_over(label: CPointer<Unit>, color: Color): Unit

    func label_bgcolor(label: CPointer<Unit>, color: Color): Unit

    func label_bgcolor_over(label: CPointer<Unit>, color: Color): Unit

    func label_trim(label: CPointer<Unit>, ellipsis: Ellipsis): Unit

    func label_get_text(label: CPointer<Unit>): CString

    func label_get_font(label: CPointer<Unit>): CPointer<Unit>
}

public class Label <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { label_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Label {
        Label(handle)
    }

    public func setText(id: ResId): Unit {
        unsafe {
            label_text(m_handle, id.cStr)
        }
    }

    public func setText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            label_text(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    @EventHandler(label_OnClick)

    public func setWidth(width: Float32): Unit {
        unsafe { label_width(m_handle, width) }
    }

    public func sizeText(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            label_size_text(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setFont(font: Font): Unit {
        unsafe { label_font(m_handle, font.m_handle) }
    }

    public func setStyleOver(fstyle: FStyle): Unit {
        unsafe { label_style_over(m_handle, fstyle) }
    }

    public func setMultiline(multiline: Bool): Unit {
        unsafe { label_multiline(m_handle, multiline) }
    }

    public func setAlign(align: Align): Unit {
        unsafe { label_align(m_handle, align) }
    }

    public func setColor(color: Color): Unit {
        unsafe { label_color(m_handle, color) }
    }

    public func setColorOver(color: Color): Unit {
        unsafe { label_color_over(m_handle, color) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { label_bgcolor(m_handle, color) }
    }

    public func setBgColorOver(color: Color): Unit {
        unsafe { label_bgcolor_over(m_handle, color) }
    }

    public func setTrim(ellipsis: Ellipsis): Unit {
        unsafe { label_trim(m_handle, ellipsis) }
    }

    public func getText(): String {
        unsafe { label_get_text(m_handle).toString() }
    }

    public func getFont(): Font {
        unsafe { Font(label_get_font(m_handle)) }
    }
}
