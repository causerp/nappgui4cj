package nappgui4cj

import nappgui4cj.macros.StaticEventHandler

foreign {
    func gui_start(): Unit

    func gui_finish(): Unit

    func gui_respack(func_respack: ResPackFunc): Unit

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

    func gui_device(): Device

    func gui_resolution(): S2Df

    func gui_workarea(): R2Df

    func gui_mouse_pos(): V2Df

    func gui_update(): Unit

    func gui_OnThemeChanged(listener: Listener): Unit

    func gui_update_transitions(prtime: Float64, crtime: Float64): Unit

    func gui_OnNotification(listener: Listener): Unit

    func gui_OnIdle(listener: Listener): Unit

    func gui_info_window(fatal: Bool, msg: CString, caption: CString, detail: CString, file: CString, line: UInt32,
        buttons: CPointer<Unit>, defindex: UInt32): UInt32

    func evbind_object_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func evbind_modify_imp(event: CPointer<Unit>, typeName: CString, size: UInt16, mname: CString, mtype: CString, moffset: UInt16,
        msize: UInt16): Bool
}

public struct GUI {
    public static func start(): Unit {
        unsafe { gui_start() }
    }

    public static func finish(): Unit {
        unsafe { gui_finish() }
    }

    public static func respack(function: ResPackFunc): Unit {
        unsafe { gui_respack(function) }
    }

    public static func language(lang: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(lang)
            gui_language(strPtr)
            LibC.free(strPtr)
        }
    }

    public static func getText(id: ResId): ?String {
        unsafe {
            let strPtr = gui_text(id.cStr)
            return match (strPtr.isNull()) {
                case false => strPtr.toString()
                case true => None<String>
            }
        }
    }

    public static func getImage(id: ResId): ?Image {
        unsafe {
            let handle = gui_image(id.cStr)
            return match (handle.isNull()) {
                case false => Image(handle)
                case true => None<Image>
            }
        }
    }

    public static func getFile(id: ResId): ?(CPointer<Byte>, UInt32) {
        unsafe {
            var dataSize = 0u32
            let dataPtr = gui_file(id.cStr, inout dataSize)
            return match (dataPtr.isNull()) {
                case false => (dataPtr, dataSize)
                case true => None
            }
        }
    }

    public static func getFileAsArray(id: ResId): ?Array<Byte> {
        unsafe {
            var dataSize = 0u32
            let dataPtr = gui_file(id.cStr, inout dataSize)
            return match (dataPtr.isNull()) {
                case false =>
                    let arr = Array<Byte>(Int64(dataSize), repeat: 0)
                    let rawData = acquireArrayRawData(arr)
                    memcpy_s(rawData.pointer, UIntNative(dataSize), dataPtr, UIntNative(dataSize))
                    releaseArrayRawData(rawData)
                    arr
                case true => None
            }
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

    public static func device(): Device {
        unsafe { gui_device() }
    }

    public static func resolution(): S2Df {
        unsafe { gui_resolution() }
    }

    public static func workarea(): R2Df {
        unsafe { gui_workarea() }
    }

    public static func mousePos(): V2Df {
        unsafe { gui_mouse_pos() }
    }

    public static func update(): Unit {
        unsafe { gui_update() }
    }

    @StaticEventHandler(gui_OnThemeChanged)

    public static func updateTransitions(prtime: Float64, crtime: Float64): Unit {
        unsafe { gui_update_transitions(prtime, crtime) }
    }

    @StaticEventHandler(gui_OnNotification)

    @StaticEventHandler(gui_OnIdle)

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
