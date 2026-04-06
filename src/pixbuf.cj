package nappgui4cj

foreign {
    func pixbuf_create(width: UInt32, height: UInt32, format: PixFormat): CPointer<Unit>

    func pixbuf_copy(pixbuf: CPointer<Unit>): CPointer<Unit>

    func pixbuf_trim(pixbuf: CPointer<Unit>, x: UInt32, y: UInt32, width: UInt32, height: UInt32): CPointer<Unit>

    func pixbuf_convert(pixbuf: CPointer<Unit>, palette: CPointer<Unit>, oformat: PixFormat): CPointer<Unit>

    func pixbuf_destroy(pixbuf: CPointer<CPointer<Unit>>): Unit

    func pixbuf_format(pixbuf: CPointer<Unit>): PixFormat

    func pixbuf_width(pixbuf: CPointer<Unit>): UInt32

    func pixbuf_height(pixbuf: CPointer<Unit>): UInt32

    func pixbuf_size(pixbuf: CPointer<Unit>): UInt32

    func pixbuf_dsize(pixbuf: CPointer<Unit>): UInt32

    func pixbuf_cdata(pixbuf: CPointer<Unit>): CPointer<Byte>

    func pixbuf_data(pixbuf: CPointer<Unit>): CPointer<Byte>

    func pixbuf_format_bpp(format: PixFormat): UInt32

    func pixbuf_get(pixbuf: CPointer<Unit>, x: UInt32, y: UInt32): UInt32

    func pixbuf_set(pixbuf: CPointer<Unit>, x: UInt32, y: UInt32, value: UInt32): Unit
}

public struct Pixbuf <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(width: UInt32, height: UInt32, format: PixFormat) {
        m_handle = unsafe { pixbuf_create(width, height, format) }
    }

    public mut func destroy(): Unit {
        unsafe { pixbuf_destroy(inout m_handle) }
        m_handle = CPointer()
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func clone(): Pixbuf {
        Pixbuf(unsafe { pixbuf_copy(m_handle) })
    }

    public func trim(x: UInt32, y: UInt32, width: UInt32, height: UInt32): Pixbuf {
        Pixbuf(unsafe { pixbuf_trim(m_handle, x, y, width, height) })
    }

    public func convert(palette: CPointer<Unit>, oformat: PixFormat): Pixbuf {
        Pixbuf(unsafe { pixbuf_convert(m_handle, palette, oformat) })
    }

    public func getFormat(): PixFormat {
        unsafe { pixbuf_format(m_handle) }
    }

    public func getWidth(): UInt32 {
        unsafe { pixbuf_width(m_handle) }
    }

    public func getHeight(): UInt32 {
        unsafe { pixbuf_height(m_handle) }
    }

    public func getSize(): UInt32 {
        unsafe { pixbuf_size(m_handle) }
    }

    public func getDataSize(): UInt32 {
        unsafe { pixbuf_dsize(m_handle) }
    }

    public func getConstData(): CPointer<Byte> {
        unsafe { pixbuf_cdata(m_handle) }
    }

    public func getData(): CPointer<Byte> {
        unsafe { pixbuf_data(m_handle) }
    }

    public static func getFormatBpp(format: PixFormat): UInt32 {
        unsafe { pixbuf_format_bpp(format) }
    }

    public func getPixel(x: UInt32, y: UInt32): UInt32 {
        unsafe { pixbuf_get(m_handle, x, y) }
    }

    public func setPixel(x: UInt32, y: UInt32, value: Color): Unit {
        unsafe { pixbuf_set(m_handle, x, y, value.toUInt32()) }
    }

    public func setPixel(x: UInt32, y: UInt32, value: UInt32): Unit {
        unsafe { pixbuf_set(m_handle, x, y, value) }
    }
}
