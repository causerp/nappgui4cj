package nappgui4cj

foreign {
    func pixbuf_create(width: UInt32, height: UInt32, format: UInt32): CPointer<Unit>

    func pixbuf_copy(pixbuf: Pixbuf): CPointer<Unit>

    func pixbuf_trim(pixbuf: Pixbuf, x: UInt32, y: UInt32, width: UInt32, height: UInt32): CPointer<Unit>

    func pixbuf_convert(pixbuf: Pixbuf, palette: CPointer<Unit>, oformat: UInt32): CPointer<Unit>

    func pixbuf_destroy(pixbuf: CPointer<CPointer<Unit>>): Unit

    func pixbuf_format(pixbuf: Pixbuf): UInt32

    func pixbuf_width(pixbuf: Pixbuf): UInt32

    func pixbuf_height(pixbuf: Pixbuf): UInt32

    func pixbuf_size(pixbuf: Pixbuf): UInt32

    func pixbuf_dsize(pixbuf: Pixbuf): UInt32

    func pixbuf_cdata(pixbuf: Pixbuf): CPointer<Byte>

    func pixbuf_data(pixbuf: Pixbuf): CPointer<Byte>

    func pixbuf_format_bpp(format: UInt32): UInt32

    func pixbuf_get(pixbuf: Pixbuf, x: UInt32, y: UInt32): UInt32

    func pixbuf_set(pixbuf: Pixbuf, x: UInt32, y: UInt32, value: UInt32): Unit
}

@C
public struct Pixbuf {
    private var m_handle: CPointer<Unit> = CPointer()

    public init() {}

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public static func create(width: UInt32, height: UInt32, format: PixFormat): Pixbuf {
        Pixbuf(unsafe { pixbuf_create(width, height, format.value) })
    }

    public func copy(): Pixbuf {
        Pixbuf(unsafe { pixbuf_copy(this) })
    }

    public func trim(x: UInt32, y: UInt32, width: UInt32, height: UInt32): Pixbuf {
        Pixbuf(unsafe { pixbuf_trim(this, x, y, width, height) })
    }

    public func convert(palette: CPointer<Unit>, oformat: PixFormat): Pixbuf {
        Pixbuf(unsafe { pixbuf_convert(this, palette, oformat.value) })
    }

    public mut func destroy(): Unit {
        unsafe { pixbuf_destroy(inout m_handle) }
        m_handle = CPointer()
    }

    public func getFormat(): PixFormat {
        unsafe { PixFormat(pixbuf_format(this)) }
    }

    public func getWidth(): UInt32 {
        unsafe { pixbuf_width(this) }
    }

    public func getHeight(): UInt32 {
        unsafe { pixbuf_height(this) }
    }

    public func getSize(): UInt32 {
        unsafe { pixbuf_size(this) }
    }

    public func getDataSize(): UInt32 {
        unsafe { pixbuf_dsize(this) }
    }

    public func getConstData(): CPointer<Byte> {
        unsafe { pixbuf_cdata(this) }
    }

    public func getData(): CPointer<Byte> {
        unsafe { pixbuf_data(this) }
    }

    public static func getFormatBpp(format: PixFormat): UInt32 {
        unsafe { pixbuf_format_bpp(format.value) }
    }

    public func getPixel(x: UInt32, y: UInt32): UInt32 {
        unsafe { pixbuf_get(this, x, y) }
    }

    public func setPixel(x: UInt32, y: UInt32, value: UInt32): Unit {
        unsafe { pixbuf_set(this, x, y, value) }
    }
}
