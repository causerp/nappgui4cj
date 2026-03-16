package nappgui4cj

foreign {
    func image_from_pixels(width: UInt32, height: UInt32, format: UInt32, data: CPointer<Byte>, palette: CPointer<Color>, palsize: UInt32): Image

    func image_from_pixbuf(pixbuf: CPointer<Unit>, palette: CPointer<Unit>): Image

    func image_from_file(pathname: CString, error: CPointer<Unit>): Image

    func image_from_data(data: CPointer<Byte>, size: UInt32): Image

    func image_from_resource(pack: CPointer<Unit>, id: UInt32): Image

    func image_copy(image: Image): Image

    func image_trim(image: Image, x: UInt32, y: UInt32, width: UInt32, height: UInt32): Image

    // Using Float32 for real32_t
    func image_rotate(image: Image, angle: Float32, nsize: Bool, background: Color, t2d: CPointer<Unit>): Image

    func image_scale(image: Image, nwidth: UInt32, nheight: UInt32): Image

    func image_read(stm: CPointer<Unit>): Image

    func image_to_file(image: Image, pathname: CString, error: CPointer<Unit>): Bool

    func image_write(stm: CPointer<Unit>, image: Image): Unit

    func image_destroy(image: CPointer<Image>): Unit

    func image_format(image: Image): UInt32

    func image_width(image: Image): UInt32

    func image_height(image: Image): UInt32

    func image_mem(image: Image): UInt32

    func image_pixels(image: Image, format: UInt32): CPointer<Unit>

    func image_codec(image: Image, codec: UInt32): Bool

    func image_get_codec(image: Image): UInt32

    func image_num_frames(image: Image): UInt32

    func image_frame_length(image: Image, findex: UInt32): Float32

    func image_data_imp(image: Image, data: CPointer<CPointer<Unit>>, func_destroy_data: CPointer<Unit>): Unit

    func image_get_data_imp(image: Image): CPointer<Unit>

    func image_native(image: Image): CPointer<Unit>
}

@C
public struct Image {
    var handle: CPointer<Unit> = CPointer<Unit>()

    // Internal constructor from handle
    public init(handle: CPointer<Unit>) {
        this.handle = handle
    }

    // // create from file
    // public init(path: String) {
    //     unsafe {
    //         let strPtr = LibC.mallocCString(path)
    //         // Ignoring error pointer for now (passing null)
    //         m_handle = image_from_file(strPtr, CPointer<Unit>())
    //         LibC.free(strPtr)
    //     }
    // }

    // Static factory methods matching the C API

    // public static func fromPixels(width: UInt32, height: UInt32, format: UInt32, data: CPointer<Byte>, palette: CPointer<Color>, palsize: UInt32): Image {
    //     unsafe { Image(image_from_pixels(width, height, format, data, palette, palsize)) }
    // }

    // public static func fromData(data: CPointer<Byte>, size: UInt32): Image {
    //     unsafe { Image(image_from_data(data, size)) }
    // }

    // public static func fromResource(pack: CPointer<Unit>, id: UInt32): Image {
    //     unsafe { Image(image_from_resource(pack, id)) }
    // }

    // public func copy(): Image {
    //     unsafe { Image(image_copy(this)) }
    // }

    // public func trim(x: UInt32, y: UInt32, width: UInt32, height: UInt32): Image {
    //     unsafe { Image(image_trim(this, x, y, width, height)) }
    // }

    // public func rotate(angle: Float32, nsize: Bool, background: Color, t2d: CPointer<Unit>): Image {
    //     unsafe { Image(image_rotate(this, angle, nsize, background, t2d)) }
    // }

    // public func scale(nwidth: UInt32, nheight: UInt32): Image {
    //     unsafe { Image(image_scale(this, nwidth, nheight)) }
    // }

    public func toFile(path: String): Bool {
        unsafe {
            let strPtr = LibC.mallocCString(path)
            // Ignoring error pointer
            let result = image_to_file(this, strPtr, CPointer<Unit>())
            LibC.free(strPtr)
            return result
        }
    }

    public func format(): UInt32 {
        unsafe { image_format(this) }
    }

    public func width(): UInt32 {
        unsafe { image_width(this) }
    }

    public func height(): UInt32 {
        unsafe { image_height(this) }
    }

    public func memSize(): UInt32 {
        unsafe { image_mem(this) }
    }

    public func pixels(format: UInt32): CPointer<Unit> {
        unsafe { image_pixels(this, format) }
    }

    public func numFrames(): UInt32 {
        unsafe { image_num_frames(this) }
    }

    public func frameLength(findex: UInt32): Float32 {
        unsafe { image_frame_length(this, findex) }
    }

    public func native(): CPointer<Unit> {
        unsafe { image_native(this) }
    }

    // Note: Destruction is likely handled by the GUI framework when the Image object
    // is associated with a widget (e.g., ImageView), or manually if created standalone.
    // Typically in these wrappers, we do not implement a destructor (free) here
    // unless specifically managing lifecycle directly.
}
