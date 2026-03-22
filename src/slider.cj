package nappgui4cj

foreign {
    func slider_create(): CPointer<Unit>

    func slider_vertical(): CPointer<Unit>

    func slider_OnMoved(slider: Slider, listener: Listener): Unit

    func slider_min_width(slider: Slider, width: Float32): Unit

    func slider_tooltip(slider: Slider, text: CString): Unit

    func slider_steps(slider: Slider, steps: UInt32): Unit

    func slider_value(slider: Slider, value: Float32): Unit

    func slider_get_value(slider: Slider): Float32
}

@C
public struct Slider {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = unsafe { slider_create() }
    }

    public init(vertical: Bool) {
        if (vertical) {
            m_handle = unsafe { slider_vertical() }
        } else {
            m_handle = unsafe { slider_create() }
        }
    }

    public static func create(): CPointer<Unit> {
        unsafe { slider_create() }
    }

    public static func vertical(): CPointer<Unit> {
        unsafe { slider_vertical() }
    }

    public func onMoved<T>(function: EventHandlerFunc<T>, obj!: CPointer<T> = CPointer()): Unit where T <: CType {
        let listener = Listener.create<T>(obj, function)
        unsafe { slider_OnMoved(this, listener) }
    }

    public func setMinWidth(width: Float32): Unit {
        unsafe { slider_min_width(this, width) }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            slider_tooltip(this, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setSteps(steps: UInt32): Unit {
        unsafe { slider_steps(this, steps) }
    }

    public func setValue(value: Float32): Unit {
        unsafe { slider_value(this, value) }
    }

    public func getValue(): Float32 {
        unsafe { slider_get_value(this) }
    }
}
