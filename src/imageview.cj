package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func imageview_create(): CPointer<Unit>

    func imageview_size(view: CPointer<Unit>, size: S2Df): Unit

    func imageview_scale(view: CPointer<Unit>, scale: GUIScale): Unit

    func imageview_image(view: CPointer<Unit>, image: CPointer<Unit>): Unit

    func imageview_OnClick(view: CPointer<Unit>, listener: Listener): Unit

    func imageview_OnOverDraw(view: CPointer<Unit>, listener: Listener): Unit

    func imageview_get_image(view: CPointer<Unit>): CPointer<Unit>
}

public class ImageView <: GuiControl {
    var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { imageview_create() }
    }

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): ImageView {
        ImageView(handle)
    }

    public func setSize(size: S2Df): Unit {
        unsafe { imageview_size(m_handle, size) }
    }

    public func setScale(scale: GUIScale): Unit {
        unsafe { imageview_scale(m_handle, scale) }
    }

    public func clearImage(): Unit {
        unsafe { imageview_image(m_handle, CPointer()) }
    }

    public func setImage(image: Image): Unit {
        unsafe { imageview_image(m_handle, image.m_handle) }
    }

    public func setImage(id: ResId): Unit {
        unsafe {
            imageview_image(m_handle, CPointer(id.cStr.getChars()))
        }
    }

    @EventHandler(imageview_OnClick)

    @EventHandler(imageview_OnOverDraw)

    public func getImage(): ?Image {
        unsafe {
            let handle = imageview_get_image(m_handle)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }
}
