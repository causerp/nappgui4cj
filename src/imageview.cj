package nappgui4cj

foreign {
    func imageview_create(): CPointer<Unit>

    func imageview_size(view: ImageView, size: S2Df): Unit

    func imageview_scale(view: ImageView, scale: GUIScale): Unit

    func imageview_image(view: ImageView, image: CPointer<Unit>): Unit

    func imageview_OnClick(view: ImageView, listener: Listener): Unit

    func imageview_OnOverDraw(view: ImageView, listener: Listener): Unit

    func imageview_get_image(view: ImageView): CPointer<Unit>
}

@C
public struct ImageView {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { imageview_create() }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { imageview_size(this, size) }
    }

    public func setScale(scale: GUIScale): Unit {
        unsafe { imageview_scale(this, scale) }
    }

    public func clearImage(): Unit {
        unsafe { imageview_image(this, CPointer()) }
    }

    public func setImage(image: Image): Unit {
        unsafe { imageview_image(this, image.handle) }
    }

    public func setImage(id: ResId): Unit {
        unsafe {
            imageview_image(this, CPointer(id.cStr.getChars()))
        }
    }

    public func onClick<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { imageview_OnClick(this, listener) }
    }

    public func onOverDraw<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { imageview_OnOverDraw(this, listener) }
    }

    public func getImage(): ?Image {
        unsafe {
            let handle = imageview_get_image(this)
            if (handle.isNull()) {
                return None
            }
            return Image(handle)
        }
    }
}
