package nappgui4cj

import cenum.CEnum

foreign {
    func respack_embedded(name: CString): CPointer<Unit>

    func respack_packed(name: CString, locale: CString): CPointer<Unit>

    func respack_add_msg(pack: ResPack, msg: CString): Unit

    func respack_add_cdata(pack: ResPack, resType: ResType, data: CPointer<UInt8>, data_size: UInt32): Unit

    func respack_object_imp(pack: ResPack, id: CString, func_create: CPointer<Unit>, func_destroy: CPointer<Unit>): CPointer<Unit>

    func respack_aobj_imp(packs: CPointer<Unit>, id: CString, func_create: CPointer<Unit>, func_destroy: CPointer<Unit>,
        is_resid: CPointer<Bool>): CPointer<Unit>

    func respack_atext(packs: CPointer<Unit>, id: CString, is_resid: CPointer<Bool>): CPointer<Unit>

    func respack_afile(packs: CPointer<Unit>, id: CString, size: CPointer<UInt32>, is_resid: CPointer<Bool>): CPointer<Unit>

    // Public API
    func respack_destroy(pack: CPointer<CPointer<Unit>>): Unit

    func respack_text(pack: ResPack, id: CString): CString

    func respack_file(pack: ResPack, id: CString, size: CPointer<UInt32>): CPointer<UInt8>
}

@CEnum[public ResType UInt32](
    Str = 0
    Image
    File
)

// inout VArray parameters can only be called in @C functions and not from inside classes.

@C
public func resPackAddMsg(pack: ResPack, msg: CPointer<UInt8>): Unit {
    unsafe { respack_add_msg(pack, CString(msg)) }
}

@C
public func resPackAddCData(pack: ResPack, resType: ResType, data: CPointer<UInt8>, dataSize: UInt32): Unit {
    unsafe { respack_add_cdata(pack, resType, data, dataSize) }
}

@C
public struct ResPack {
    private var m_handle: CPointer<Unit>

    private init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public static func createEmbedded(name: String): ResPack {
        unsafe {
            let namePtr = LibC.mallocCString(name)
            let handle = respack_embedded(namePtr)
            LibC.free(namePtr)
            return ResPack(handle)
        }
    }

    public static func createPacked(name: String, locale: String): ResPack {
        unsafe {
            let namePtr = LibC.mallocCString(name)
            let localePtr = LibC.mallocCString(locale)
            let handle = respack_packed(namePtr, localePtr)
            LibC.free(namePtr)
            LibC.free(localePtr)
            return ResPack(handle)
        }
    }

    public mut func destroy(): Unit {
        unsafe {
            var handle = m_handle
            respack_destroy(inout handle)
            m_handle = handle
        }
    }

    public func objectImp(id: ResId, funcCreate: CPointer<Unit>, funcDestroy: CPointer<Unit>): CPointer<Unit> {
        unsafe {
            let obj = respack_object_imp(this, id.cStr, funcCreate, funcDestroy)
            obj
        }
    }

    public func text(id: ResId): ?String {
        unsafe {
            let strPtr = respack_text(this, id.cStr)
            return match (strPtr.isNull()) {
                case false => strPtr.toString()
                case true => None
            }
        }
    }

    public func file(id: ResId, size: Box<UInt32>): ?CPointer<UInt8> {
        unsafe {
            var dataSize = 0u32
            let dataPtr = respack_file(this, id.cStr, inout dataSize)
            size.value = dataSize
            return match (dataPtr.isNull()) {
                case false => dataPtr
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
