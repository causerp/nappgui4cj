package nappgui4cj

foreign {
    func palette_create(size: UInt32): CPointer<Unit>

    func palette_cga2(mode: Bool, intense: Bool): CPointer<Unit>

    func palette_ega4(): CPointer<Unit>

    func palette_rgb8(): CPointer<Unit>

    func palette_gray1(): CPointer<Unit>

    func palette_gray2(): CPointer<Unit>

    func palette_gray4(): CPointer<Unit>

    func palette_gray8(): CPointer<Unit>

    func palette_binary(zero: Color, one: Color): CPointer<Unit>

    func palette_destroy(palette: CPointer<CPointer<Unit>>): Unit

    func palette_size(palette: Palette): UInt32

    func palette_colors(palette: Palette): CPointer<Color>
}

@C
public struct Palette {
    private var m_handle: CPointer<Unit> = CPointer()

    public init() {}

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public static func create(size: UInt32): Palette {
        Palette(unsafe { palette_create(size) })
    }

    public static func cga2(mode: Bool, intense: Bool): Palette {
        Palette(unsafe { palette_cga2(mode, intense) })
    }

    public static func ega4(): Palette {
        Palette(unsafe { palette_ega4() })
    }

    public static func rgb8(): Palette {
        Palette(unsafe { palette_rgb8() })
    }

    public static func gray1(): Palette {
        Palette(unsafe { palette_gray1() })
    }

    public static func gray2(): Palette {
        Palette(unsafe { palette_gray2() })
    }

    public static func gray4(): Palette {
        Palette(unsafe { palette_gray4() })
    }

    public static func gray8(): Palette {
        Palette(unsafe { palette_gray8() })
    }

    public static func binary(zero: Color, one: Color): Palette {
        Palette(unsafe { palette_binary(zero, one) })
    }

    public mut func destroy(): Unit {
        unsafe { palette_destroy(inout m_handle) }
        m_handle = CPointer()
    }

    public func size(): UInt32 {
        unsafe { palette_size(this) }
    }

    public func colors(): CPointer<Color> {
        unsafe { palette_colors(this) }
    }

    public func setColor(index: Int64, color: Color): Unit {
        if (index >= 0 && index < Int64(size())) {
            unsafe {
                let ptr = palette_colors(this)
                ptr.write(index, color)
            }
        }
    }
}
