package nappgui4cj

foreign {
    func gui_start(): Unit

    func gui_finish(): Unit

    func gui_respack(func_respack: CFunc<(CString) -> ResPack>): Unit

    func gui_language(lang: CString): Unit

    func gui_text(id: CString): CString

    func gui_image(id: CString): CPointer<Unit>

    func gui_file(id: CString, size: CPointer<UInt32>): CPointer<Byte>

    func gui_dark_mode(): Bool

    func gui_alt_color(light_color: Color, dark_color: Color): Color

    func gui_label_color(): Color

    func gui_view_color(): Color

    func gui_line_color(): Color

    func gui_link_color(): Color

    func gui_border_color(): Color

    func gui_resolution(): S2Df

    func gui_mouse_pos(): V2Df

    func gui_update(): Unit

    func gui_OnThemeChanged(listener: Listener): Unit

    func gui_update_transitions(prtime: Float64, crtime: Float64): Unit

    func gui_OnNotification(listener: Listener): Unit

    func gui_OnIdle(listener: Listener): Unit

    func gui_info_window(fatal: Bool, msg: CString, caption: CString, detail: CString, file: CString, line: UInt32,
        buttons: CPointer<Unit>, defindex: UInt32): UInt32

    func evbind_object_imp(e: Event, type_: CString): CPointer<Unit>

    func evbind_modify_imp(e: Event, type_: CString, size: UInt16, mname: CString, mtype: CString, moffset: UInt16,
        msize: UInt16): Bool
}

public struct GUI {
    public static func start(): Unit {
        unsafe { gui_start() }
    }

    public static func finish(): Unit {
        unsafe { gui_finish() }
    }

    public static func respack(function: CFunc<(CString) -> ResPack>): Unit {
        unsafe { gui_respack(function) }
    }

    public static func language(lang: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(lang)
            gui_language(strPtr)
            LibC.free(strPtr)
        }
    }

    public static func text(id: ResId): ?String {
        unsafe {
            let strPtr = gui_text(id.cStr)
            let res = match (strPtr.isNull()) {
                case false => strPtr.toString()
                case true => None<String>
            }
            return res
        }
    }

    public static func image(id: ResId): ?Image {
        unsafe {
            let handle = gui_image(id.cStr)
            let res = match (handle.isNull()) {
                case false => Image(handle)
                case true => None<Image>
            }
            return res
        }
    }

    public static func file(id: ResId, size: Box<UInt32>): CPointer<Byte> {
        unsafe {
            var dataSize = 0u32
            let dataPtr = gui_file(id.cStr, inout dataSize)
            size.value = dataSize
            return dataPtr
        }
    }

    public static func darkMode(): Bool {
        unsafe { gui_dark_mode() }
    }

    public static func altColor(light: Color, dark: Color): Color {
        unsafe { gui_alt_color(light, dark) }
    }

    public static func labelColor(): Color {
        unsafe { gui_label_color() }
    }

    public static func viewColor(): Color {
        unsafe { gui_view_color() }
    }

    public static func lineColor(): Color {
        unsafe { gui_line_color() }
    }

    public static func linkColor(): Color {
        unsafe { gui_link_color() }
    }

    public static func borderColor(): Color {
        unsafe { gui_border_color() }
    }

    public static func resolution(): S2Df {
        unsafe { gui_resolution() }
    }

    public static func mousePos(): V2Df {
        unsafe { gui_mouse_pos() }
    }

    public static func update(): Unit {
        unsafe { gui_update() }
    }

    public static func onThemeChanged(listener: Listener): Unit {
        unsafe { gui_OnThemeChanged(listener) }
    }

    public static func updateTransitions(prtime: Float64, crtime: Float64): Unit {
        unsafe { gui_update_transitions(prtime, crtime) }
    }

    public static func onNotification(listener: Listener): Unit {
        unsafe { gui_OnNotification(listener) }
    }

    public static func onIdle(listener: Listener): Unit {
        unsafe { gui_OnIdle(listener) }
    }

    public static func infoWindow(fatal: Bool, msg: String, caption: String, detail: String, file: String, line: UInt32,
        buttons: CPointer<Unit>, defindex: UInt32): UInt32 {
        unsafe {
            let msgPtr = LibC.mallocCString(msg)
            let capPtr = LibC.mallocCString(caption)
            let detPtr = LibC.mallocCString(detail)
            let filePtr = LibC.mallocCString(file)

            let ret = gui_info_window(fatal, msgPtr, capPtr, detPtr, filePtr, line, buttons, defindex)

            LibC.free(msgPtr)
            LibC.free(capPtr)
            LibC.free(detPtr)
            LibC.free(filePtr)
            return ret
        }
    }
}
