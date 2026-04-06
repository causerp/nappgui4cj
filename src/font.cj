package nappgui4cj

foreign {
    func font_create(family: CString, size: Float32, style: FStyle): CPointer<Unit>

    func font_system(size: Float32, style: FStyle): CPointer<Unit>

    func font_monospace(size: Float32, style: FStyle): CPointer<Unit>

    func font_with_style(font: CPointer<Unit>, style: FStyle): CPointer<Unit>

    func font_with_width(font: CPointer<Unit>, width: Float32): CPointer<Unit>

    func font_with_xscale(font: CPointer<Unit>, scale: Float32): CPointer<Unit>

    func font_copy(font: CPointer<Unit>): CPointer<Unit>

    func font_destroy(font: CPointer<CPointer<Unit>>): Unit

    func font_equals(font1: CPointer<Unit>, font2: CPointer<Unit>): Bool

    func font_family(font: CPointer<Unit>): CString

    func font_size(font: CPointer<Unit>): Float32

    func font_height(font: CPointer<Unit>): Float32

    func font_width(font: CPointer<Unit>): Float32

    func font_xscale(font: CPointer<Unit>): Float32

    func font_ascent(font: CPointer<Unit>): Float32

    func font_descent(font: CPointer<Unit>): Float32

    func font_leading(font: CPointer<Unit>): Float32

    func font_is_monospace(font: CPointer<Unit>): Bool

    func font_style(font: CPointer<Unit>): FStyle

    func font_units(font: CPointer<Unit>): UInt32

    func font_extents(font: CPointer<Unit>, text: CString, refwidth: Float32, width: CPointer<Float32>, height: CPointer<Float32>): Unit

    func font_native(font: CPointer<Unit>): CPointer<Unit>

    func font_regular_size(): Float32

    func font_small_size(): Float32

    func font_mini_size(): Float32

    func font_exists_family(family: CString): Bool
}

public enum FontType {
    | FntNormal(String)
    | FntSystem
    | FntMonospace
}

public struct Font <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(fontType: FontType, size: Float32, style: FStyle) {
        m_handle = match (fontType) {
            case FntNormal(family) => unsafe {
                let strPtr = LibC.mallocCString(family)
                let handle = font_create(strPtr, size, style)
                LibC.free(strPtr)
                handle
            }
            case FntSystem => unsafe { font_system(size, style) }
            case FntMonospace => unsafe { font_monospace(size, style) }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func clone(): Font {
        Font(unsafe { font_copy(m_handle) })
    }

    public func withStyle(style: FStyle): Font {
        Font(unsafe { font_with_style(m_handle, style) })
    }

    public func withWidth(width: Float32): Font {
        Font(unsafe { font_with_width(m_handle, width) })
    }

    public func withXScale(scale: Float32): Font {
        Font(unsafe { font_with_xscale(m_handle, scale) })
    }

    public mut func destroy(): Unit {
        unsafe { font_destroy(inout m_handle) }
    }

    public func isNull(): Bool {
        m_handle.isNull()
    }

    public func equals(other: Font): Bool {
        unsafe { font_equals(m_handle, other.m_handle) }
    }

    public static prop regularSize: Float32 {
        get() {
            unsafe { font_regular_size() }
        }
    }

    public static prop smallSize: Float32 {
        get() {
            unsafe { font_small_size() }
        }
    }

    public static prop miniSize: Float32 {
        get() {
            unsafe { font_mini_size() }
        }
    }

    public prop family: ?String {
        get() {
            unsafe {
                let strPtr = font_family(m_handle)
                match (strPtr.isNull()) {
                    case false => strPtr.toString()
                    case true => None
                }
            }
        }
    }

    public prop size: Float32 {
        get() {
            unsafe { font_size(m_handle) }
        }
    }

    public prop height: Float32 {
        get() {
            unsafe { font_height(m_handle) }
        }
    }

    public prop width: Float32 {
        get() {
            unsafe { font_width(m_handle) }
        }
    }

    public prop xscale: Float32 {
        get() {
            unsafe { font_xscale(m_handle) }
        }
    }

    public prop ascent: Float32 {
        get() {
            unsafe { font_ascent(m_handle) }
        }
    }

    public prop descent: Float32 {
        get() {
            unsafe { font_descent(m_handle) }
        }
    }

    public prop leading: Float32 {
        get() {
            unsafe { font_leading(m_handle) }
        }
    }

    public prop isMonospace: Bool {
        get() {
            unsafe { font_is_monospace(m_handle) }
        }
    }

    public prop style: FStyle {
        get() {
            unsafe { font_style(m_handle) }
        }
    }

    public prop units: UInt32 {
        get() {
            unsafe { font_units(m_handle) }
        }
    }

    public func extents(text: String, refwidth: Float32): (Float32, Float32) {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            var w: Float32 = 0.0
            var h: Float32 = 0.0
            font_extents(m_handle, strPtr, refwidth, inout w, inout h)
            LibC.free(strPtr)
            return (w, h)
        }
    }

    public static func existsFamily(family: String): Bool {
        unsafe {
            let strPtr = LibC.mallocCString(family)
            let res = font_exists_family(strPtr)
            LibC.free(strPtr)
            return res
        }
    }
}
