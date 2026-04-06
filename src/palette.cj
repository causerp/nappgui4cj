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

    func palette_size(palette: CPointer<Unit>): UInt32

    func palette_colors(palette: CPointer<Unit>): CPointer<Color>
}

public enum PaletteType {
    | PalNormal(UInt32)
    | PalCGA2(Bool, Bool)
    | PalEGA4
    | PalRGB8
    | PalGray1
    | PalGray2
    | PalGray4
    | PalGray8
    | PalBinary(UInt32, UInt32)
}

public struct Palette <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(size: UInt32) {
        m_handle = unsafe { palette_create(size) }
    }

    public init(mode!: Bool, intense!: Bool) {
        m_handle = unsafe { palette_cga2(mode, intense) }
    }

    public init(zero!: Color, one!: Color) {
        m_handle = unsafe { palette_binary(zero, one) }
    }

    public init(paletteType: PaletteType) {
        m_handle = match (paletteType) {
            case PalNormal(size) => unsafe { palette_create(size) }
            case PalCGA2(mode, intense) => unsafe { palette_cga2(mode, intense) }
            case PalEGA4 => unsafe { palette_ega4() }
            case PalRGB8 => unsafe { palette_rgb8() }
            case PalGray1 => unsafe { palette_gray1() }
            case PalGray2 => unsafe { palette_gray2() }
            case PalGray4 => unsafe { palette_gray4() }
            case PalGray8 => unsafe { palette_gray8() }
            case PalBinary(zero, one) => unsafe { palette_binary(Color(zero), Color(one)) }
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public mut func destroy(): Unit {
        unsafe { palette_destroy(inout m_handle) }
        m_handle = CPointer()
    }

    public func size(): UInt32 {
        unsafe { palette_size(m_handle) }
    }

    public func colors(): CPointer<Color> {
        unsafe { palette_colors(m_handle) }
    }

    public func setColor(index: Int64, color: Color): Unit {
        if (index >= 0 && index < Int64(size())) {
            unsafe {
                let ptr = palette_colors(m_handle)
                ptr.write(index, color)
            }
        }
    }
}
