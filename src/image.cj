package nappgui4cj

foreign {
    func image_from_pixels(width: UInt32, height: UInt32, format: UInt32, data: CPointer<Byte>,
        palette: CPointer<Color>, palsize: UInt32): CPointer<Unit>

    func image_from_pixbuf(pixbuf: CPointer<Unit>, palette: CPointer<Unit>): CPointer<Unit>

    func image_from_file(pathname: CString, error: CPointer<Unit>): CPointer<Unit>

    func image_from_data(data: CPointer<Byte>, size: UInt32): CPointer<Unit>

    func image_from_resource(pack: CPointer<Unit>, id: ResId): CPointer<Unit>

    func image_copy(image: CPointer<Unit>): CPointer<Unit>

    func image_trim(image: CPointer<Unit>, x: UInt32, y: UInt32, width: UInt32, height: UInt32): CPointer<Unit>

    func image_rotate(image: CPointer<Unit>, angle: Float32, nsize: Bool, background: Color, t2d: CPointer<Unit>): CPointer<Unit>

    func image_scale(image: CPointer<Unit>, nwidth: UInt32, nheight: UInt32): CPointer<Unit>

    func image_read(stm: CPointer<Unit>): CPointer<Unit>

    func image_to_file(image: CPointer<Unit>, pathname: CString, error: CPointer<Unit>): Bool

    func image_write(stm: CPointer<Unit>, image: CPointer<Unit>): Unit

    func image_destroy(image: CPointer<CPointer<Unit>>): Unit

    func image_format(image: CPointer<Unit>): UInt32

    func image_width(image: CPointer<Unit>): UInt32

    func image_height(image: CPointer<Unit>): UInt32

    func image_mem(image: CPointer<Unit>): UInt32

    func image_pixels(image: CPointer<Unit>, format: UInt32): CPointer<Unit>

    func image_codec(image: CPointer<Unit>, codec: UInt32): Bool

    func image_get_codec(image: CPointer<Unit>): UInt32

    func image_num_frames(image: CPointer<Unit>): UInt32

    func image_frame_length(image: CPointer<Unit>, findex: UInt32): Float32

    func image_data_imp(image: CPointer<Unit>, data: CPointer<CPointer<Unit>>, func_destroy_data: CPointer<Unit>): Unit

    func image_get_data_imp(image: CPointer<Unit>): CPointer<Unit>

    func image_native(image: CPointer<Unit>): CPointer<Unit>
}

public struct Image <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(path: String) {
        unsafe {
            let strPtr = LibC.mallocCString(path)
            m_handle = image_from_file(strPtr, CPointer<Unit>())
            LibC.free(strPtr)
        }
    }

    public init(width: UInt32, height: UInt32, format: UInt32, data: CPointer<Byte>, palette: CPointer<Color>,
        palsize: UInt32) {
        m_handle = unsafe { image_from_pixels(width, height, format, data, palette, palsize) }
    }

    public init(pixbuf: Pixbuf, palette: Palette) {
        m_handle = unsafe { image_from_pixbuf(pixbuf.m_handle, palette.m_handle) }
    }

    public init(data: CPointer<Byte>, size: UInt32) {
        m_handle = unsafe { image_from_data(data, size) }
    }

    public init(pack: ResPack, id: ResId) {
        m_handle = unsafe { image_from_resource(pack.m_handle, id) }
    }

    public mut func destroy(): Unit {
        unsafe { image_destroy(inout m_handle) }
        m_handle = CPointer()
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func clone(): Image {
        unsafe { Image(image_copy(m_handle)) }
    }

    public func trim(x: UInt32, y: UInt32, width: UInt32, height: UInt32): Image {
        unsafe { Image(image_trim(m_handle, x, y, width, height)) }
    }

    public func rotate(angle: Float32, nsize: Bool, background: Color, t2d: CPointer<Unit>): Image {
        unsafe { Image(image_rotate(m_handle, angle, nsize, background, t2d)) }
    }

    public func scale(nwidth: UInt32, nheight: UInt32): Image {
        unsafe { Image(image_scale(m_handle, nwidth, nheight)) }
    }

    public func toFile(path: String): Bool {
        unsafe {
            let strPtr = LibC.mallocCString(path)
            let result = image_to_file(m_handle, strPtr, CPointer<Unit>())
            LibC.free(strPtr)
            return result
        }
    }

    public func setCodec(codec: Codec): Bool {
        unsafe { image_codec(m_handle, codec.value) }
    }

    public func getCodec(): Codec {
        unsafe { Codec(image_get_codec(m_handle)) }
    }

    public func format(): UInt32 {
        unsafe { image_format(m_handle) }
    }

    public func width(): UInt32 {
        unsafe { image_width(m_handle) }
    }

    public func height(): UInt32 {
        unsafe { image_height(m_handle) }
    }

    public func memSize(): UInt32 {
        unsafe { image_mem(m_handle) }
    }

    public func pixels(format: UInt32): CPointer<Unit> {
        unsafe { image_pixels(m_handle, format) }
    }

    public func numFrames(): UInt32 {
        unsafe { image_num_frames(m_handle) }
    }

    public func frameLength(findex: UInt32): Float32 {
        unsafe { image_frame_length(m_handle, findex) }
    }

    public func native(): CPointer<Unit> {
        unsafe { image_native(m_handle) }
    }
}
