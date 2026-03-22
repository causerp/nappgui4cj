package nappgui4cj

foreign {
    // Constructors return raw pointers
    func font_create(family: CString, size: Float32, style: UInt32): CPointer<Unit>

    func font_system(size: Float32, style: UInt32): CPointer<Unit>

    func font_monospace(size: Float32, style: UInt32): CPointer<Unit>

    // Functional modifiers return new raw pointers
    func font_with_style(font: CPointer<Unit>, style: UInt32): CPointer<Unit>

    func font_with_width(font: CPointer<Unit>, width: Float32): CPointer<Unit>

    func font_with_xscale(font: CPointer<Unit>, scale: Float32): CPointer<Unit>

    func font_copy(font: CPointer<Unit>): CPointer<Unit>

    // Destructor takes pointer to pointer
    func font_destroy(font: CPointer<CPointer<Unit>>): Unit

    // Instance methods take the wrapper struct 'Font'
    func font_equals(font1: Font, font2: Font): Bool

    func font_family(font: Font): CString

    func font_size(font: Font): Float32

    func font_height(font: Font): Float32

    func font_width(font: Font): Float32

    func font_xscale(font: Font): Float32

    func font_ascent(font: Font): Float32

    func font_descent(font: Font): Float32

    func font_leading(font: Font): Float32

    func font_is_monospace(font: Font): Bool

    func font_style(font: Font): UInt32

    func font_units(font: Font): UInt32

    func font_extents(font: Font, text: CString, refwidth: Float32, width: CPointer<Float32>, height: CPointer<Float32>): Unit

    func font_native(font: Font): CPointer<Unit>

    // Static functions

    func font_regular_size(): Float32

    func font_small_size(): Float32

    func font_mini_size(): Float32

    func font_exists_family(family: CString): Bool
}

@C
public struct Font {
    private var m_handle: CPointer<Unit> = CPointer()

    public init() {}

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public static func create(family: String, size: Float32, style: UInt32): Font {
        unsafe {
            let strPtr = LibC.mallocCString(family)
            let handle = font_create(strPtr, size, style)
            LibC.free(strPtr)
            return Font(handle)
        }
    }

    public static func createSystem(size: Float32, style: UInt32): Font {
        Font(unsafe { font_system(size, style) })
    }

    public static func createMonospace(size: Float32, style: UInt32): Font {
        Font(unsafe { font_monospace(size, style) })
    }

    public func clone(): Font {
        Font(unsafe { font_copy(m_handle) })
    }

    public func withStyle(style: UInt32): Font {
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
        unsafe { font_equals(this, other) }
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
                let strPtr = font_family(this)
                match (strPtr.isNull()) {
                    case false => strPtr.toString()
                    case true => None
                }
            }
        }
    }

    public prop size: Float32 {
        get() {
            unsafe { font_size(this) }
        }
    }

    public prop height: Float32 {
        get() {
            unsafe { font_height(this) }
        }
    }

    public prop width: Float32 {
        get() {
            unsafe { font_width(this) }
        }
    }

    public prop xscale: Float32 {
        get() {
            unsafe { font_xscale(this) }
        }
    }

    public prop ascent: Float32 {
        get() {
            unsafe { font_ascent(this) }
        }
    }

    public prop descent: Float32 {
        get() {
            unsafe { font_descent(this) }
        }
    }

    public prop leading: Float32 {
        get() {
            unsafe { font_leading(this) }
        }
    }

    public prop isMonospace: Bool {
        get() {
            unsafe { font_is_monospace(this) }
        }
    }

    public prop style: UInt32 {
        get() {
            unsafe { font_style(this) }
        }
    }

    public prop units: UInt32 {
        get() {
            unsafe { font_units(this) }
        }
    }

    public func extents(text: String, refwidth: Float32): (Float32, Float32) {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            var w: Float32 = 0.0
            var h: Float32 = 0.0
            font_extents(this, strPtr, refwidth, inout w, inout h)
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

    public func native(): CPointer<Unit> {
        m_handle
    }
}
