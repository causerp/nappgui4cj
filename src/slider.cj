package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func slider_create(): CPointer<Unit>

    func slider_vertical(): CPointer<Unit>

    func slider_OnMoved(slider: CPointer<Unit>, listener: Listener): Unit

    func slider_length(slider: CPointer<Unit>, width: Float32): Unit

    func slider_tooltip(slider: CPointer<Unit>, text: CString): Unit

    func slider_steps(slider: CPointer<Unit>, steps: UInt32): Unit

    func slider_value(slider: CPointer<Unit>, value: Float32): Unit

    func slider_get_value(slider: CPointer<Unit>): Float32
}

public enum SliderType {
    | SlHorizontal
    | SlVertical
}

public class Slider <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(sliderType: SliderType) {
        m_handle = match (sliderType) {
            case SlHorizontal => unsafe { slider_create() }
            case SlVertical => unsafe { slider_vertical() }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): Slider {
        Slider(handle)
    }

    @EventHandler(slider_OnMoved)

    public func setLength(width: Float32): Unit {
        unsafe { slider_length(m_handle, width) }
    }

    public func setTooltip(text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            slider_tooltip(m_handle, strPtr)
            LibC.free(strPtr)
        }
    }

    public func setSteps(steps: UInt32): Unit {
        unsafe { slider_steps(m_handle, steps) }
    }

    public func setValue(value: Float32): Unit {
        unsafe { slider_value(m_handle, value) }
    }

    public func getValue(): Float32 {
        unsafe { slider_get_value(m_handle) }
    }
}
