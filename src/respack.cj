package nappgui4cj

import cenum.CEnum

foreign {
    func respack_embedded(name: CString): CPointer<Unit>

    func respack_packed(name: CString, locale: CString): CPointer<Unit>

    func respack_add_msg(pack: CPointer<Unit>, msg: CString): Unit

    func respack_add_cdata(pack: CPointer<Unit>, resType: ResType, data: CPointer<UInt8>, data_size: UInt32): Unit

    func respack_object_imp(pack: CPointer<Unit>, id: CString, func_create: CPointer<Unit>, func_destroy: CPointer<Unit>): CPointer<Unit>

    func respack_aobj_imp(packs: CPointer<Unit>, id: CString, func_create: CPointer<Unit>, func_destroy: CPointer<Unit>,
        is_resid: CPointer<Bool>): CPointer<Unit>

    func respack_atext(packs: CPointer<Unit>, id: CString, is_resid: CPointer<Bool>): CPointer<Unit>

    func respack_afile(packs: CPointer<Unit>, id: CString, size: CPointer<UInt32>, is_resid: CPointer<Bool>): CPointer<Unit>

    func respack_destroy(pack: CPointer<CPointer<Unit>>): Unit

    func respack_text(pack: CPointer<Unit>, id: CString): CString

    func respack_file(pack: CPointer<Unit>, id: CString, size: CPointer<UInt32>): CPointer<UInt8>
}

@CEnum[public ResType UInt32](
    Str = 0
    Image
    File
)

// inout VArray parameters can only be called in @C functions and not from inside classes.

@C
public func resPackAddMsg(pack: CPointer<Unit>, msg: CPointer<UInt8>): Unit {
    unsafe { respack_add_msg(pack, CString(msg)) }
}

@C
public func resPackAddCData(pack: CPointer<Unit>, resType: ResType, data: CPointer<UInt8>, dataSize: UInt32): Unit {
    unsafe { respack_add_cdata(pack, resType, data, dataSize) }
}

public enum ResPackType {
    | ResEmbedded(String)
    | ResPacked(String, String)
}

public struct ResPack <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(name: String) {
        this(ResEmbedded(name))
    }

    public init(resPackType: ResPackType) {
        unsafe {
            match (resPackType) {
                case ResEmbedded(name) =>
                    let namePtr = LibC.mallocCString(name)
                    m_handle = respack_embedded(namePtr)
                    LibC.free(namePtr)
                case ResPacked(name, locale) =>
                    let namePtr = LibC.mallocCString(name)
                    let localePtr = LibC.mallocCString(locale)
                    m_handle = respack_packed(namePtr, localePtr)
                    LibC.free(namePtr)
                    LibC.free(localePtr)
            }
        }
    }

    public mut func destroy(): Unit {
        unsafe {
            var handle = m_handle
            respack_destroy(inout handle)
            m_handle = handle
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }


    // typedef void *(*FPtr_from_data)(const byte_t *data, const uint32_t size);
    // typedef void (*FPtr_destroy)(void **item);


    public func objectImp(id: ResId, funcCreate: CPointer<Unit>, funcDestroy: CPointer<Unit>): CPointer<Unit> {
        unsafe {
            let obj = respack_object_imp(m_handle, id.cStr, funcCreate, funcDestroy)
            obj
        }
    }

    public func getText(id: ResId): ?String {
        unsafe {
            let strPtr = respack_text(m_handle, id.cStr)
            return match (strPtr.isNull()) {
                case false => strPtr.toString()
                case true => None
            }
        }
    }

    public func getFile(id: ResId): ?(dataPtr: CPointer<UInt8>, size: UInt32) {
        unsafe {
            var dataSize = 0u32
            let dataPtr = respack_file(m_handle, id.cStr, inout dataSize)
            return match (dataPtr.isNull() || dataSize <= 0) {
                case false => (dataPtr, dataSize)
                case true => None
            }
        }
    }

    public func getFileAsArray(id: ResId): ?Array<Byte> {
        unsafe {
            var dataSize = 0u32
            let dataPtr = respack_file(m_handle, id.cStr, inout dataSize)
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

    // Static wrappers for functions operating on ArrPt(ResPack)
    // public static func aobjImp(packs: CPointer<Unit>, id: String, funcCreate: CPointer<Unit>, funcDestroy: CPointer<Unit>, isResid: CPointer<Bool>): CPointer<Unit> {
    //     unsafe {
    //         let idPtr = LibC.mallocCString(id)
    //         let obj = respack_aobj_imp(packs, idPtr, funcCreate, funcDestroy, isResid)
    //         LibC.free(idPtr)
    //         obj
    //     }
    // }

    // public static func atext(packs: CPointer<Unit>, id: String, isResid: CPointer<Bool>): ?String {
    //     unsafe {
    //         let idPtr = LibC.mallocCString(id)
    //         let strPtr = respack_atext(packs, idPtr, isResid)
    //         LibC.free(idPtr)
    //         return match (strPtr.isNull()) {
    //             case false => strPtr.toString()
    //             case true => None
    //         }
    //     }
    // }

    // public static func afile(packs: CPointer<Unit>, id: String, size: Box<UInt32>, isResid: CPointer<Bool>): ?CPointer<UInt8> {
    //     unsafe {
    //         var dataSize = 0u32
    //         let idPtr = LibC.mallocCString(id)
    //         let dataPtr = respack_afile(packs, idPtr, inout dataSize, isResid)
    //         LibC.free(idPtr)
    //         size.value = dataSize
    //         return match (dataPtr.isNull()) {
    //             case false => dataPtr
    //             case true => None
    //         }
    //     }
    // }
}
