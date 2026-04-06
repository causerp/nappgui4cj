package nappgui4cj

foreign {
    func dbind_imp(typeName: CString, size: UInt16, mname: CString, mtypeName: CString, moffset: UInt16, msize: UInt16): DBindSt

    func dbind_enum_imp(typeName: CString, name: CString, value: UInt32, alias: CString): DBindSt

    func dbind_binary_imp(typeName: CString, func_mem: CPointer<Unit>, func_copy: CPointer<Unit>,
        func_read: CPointer<Unit>, func_write: CPointer<Unit>, func_destroy: CPointer<Unit>): DBindSt

    func dbind_alias_imp(typeName: CString, alias: CString, type_size: UInt16, alias_size: UInt16): DBindSt

    func dbind_unreg_imp(typeName: CString): DBindSt

    func dbind_create_imp(typeName: CString): CPointer<Unit>

    func dbind_copy_imp(obj: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func dbind_init_imp(obj: CPointer<Unit>, typeName: CString): Unit

    func dbind_remove_imp(obj: CPointer<Unit>, typeName: CString): Unit

    func dbind_destroy_imp(obj: CPointer<CPointer<Unit>>, typeName: CString): Unit

    func dbind_destopt_imp(obj: CPointer<CPointer<Unit>>, typeName: CString): Unit

    func dbind_cmp_imp(obj1: CPointer<Unit>, obj2: CPointer<Unit>, typeName: CString): Int32

    func dbind_equ_imp(obj1: CPointer<Unit>, obj2: CPointer<Unit>, typeName: CString): Bool

    func dbind_sizeof_imp(obj: CPointer<Unit>, typeName: CString): UInt32

    func dbind_read_imp(stm: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func dbind_write_imp(stm: CPointer<Unit>, obj: CPointer<Unit>, typeName: CString): Unit

    func dbind_default_imp(typeName: CString, mname: CString, value: CPointer<Unit>): Unit

    func dbind_range_imp(typeName: CString, mname: CString, min: CPointer<Unit>, max: CPointer<Unit>): Unit

    func dbind_precision_imp(typeName: CString, mname: CString, prec: CPointer<Unit>): Unit

    func dbind_increment_imp(typeName: CString, mname: CString, incr: CPointer<Unit>): Unit

    func dbind_suffix_imp(typeName: CString, mname: CString, suffix: CString): Unit
}

public struct DBind {
    public static func bind(
        typeName!: String,
        typeSize!: UInt16,
        memberName!: String,
        membertypeName!: String,
        memberOffset!: UInt16,
        memberSize!: UInt16
    ): DBindSt {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let mPtr = LibC.mallocCString(memberName)
            let mtPtr = LibC.mallocCString(membertypeName)
            let res = dbind_imp(tPtr, typeSize, mPtr, mtPtr, memberOffset, memberSize)
            LibC.free(tPtr)
            LibC.free(mPtr)
            LibC.free(mtPtr)
            return res
        }
    }

    public static func enumVal(typeName: String, enumName: String, value: UInt32, alias: String): DBindSt {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let nPtr = LibC.mallocCString(enumName)
            let aPtr = LibC.mallocCString(alias)
            let res = dbind_enum_imp(tPtr, nPtr, value, aPtr)
            LibC.free(tPtr)
            LibC.free(nPtr)
            LibC.free(aPtr)
            return res
        }
    }

    public static func binary(typeName: String, funcMem: CPointer<Unit>, funcCopy: CPointer<Unit>,
        funcRead: CPointer<Unit>, funcWrite: CPointer<Unit>, funcDestroy: CPointer<Unit>): DBindSt {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = dbind_binary_imp(tPtr, funcMem, funcCopy, funcRead, funcWrite, funcDestroy)
            LibC.free(tPtr)
            return res
        }
    }

    public static func alias<T, A>(typeName: String, aliasName: String): DBindSt where T <: CType, A <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let aPtr = LibC.mallocCString(aliasName)
            let res = dbind_alias_imp(tPtr, aPtr, UInt16(sizeOf<T>()), UInt16(sizeOf<A>()))
            LibC.free(tPtr)
            LibC.free(aPtr)
            return res
        }
    }

    public static func unreg(typeName: String): DBindSt {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = dbind_unreg_imp(tPtr)
            LibC.free(tPtr)
            return res
        }
    }

    // ============================================================================
    // Object Lifecycle
    // ============================================================================

    public static func create<T>(typeName: String): CPointer<T> where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = CPointer<T>(dbind_create_imp(tPtr))
            LibC.free(tPtr)
            return res
        }
    }

    public static func copy<T>(obj: CPointer<T>, typeName: String): CPointer<T> where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = CPointer<T>(dbind_copy_imp(CPointer(obj), tPtr))
            LibC.free(tPtr)
            return res
        }
    }

    public static func initialize<T>(obj: CPointer<T>, typeName: String): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            dbind_init_imp(CPointer(obj), tPtr)
            LibC.free(tPtr)
        }
    }

    public static func remove<T>(obj: CPointer<T>, typeName: String): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            dbind_remove_imp(CPointer(obj), tPtr)
            LibC.free(tPtr)
        }
    }

    public static func destroy<T>(obj: CPointer<CPointer<T>>, typeName: String): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            dbind_destroy_imp(CPointer(obj), tPtr)
            LibC.free(tPtr)
        }
    }

    public static func destopt<T>(obj: CPointer<CPointer<T>>, typeName: String): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            dbind_destopt_imp(CPointer(obj), tPtr)
            LibC.free(tPtr)
        }
    }

    // ============================================================================
    // Object Comparison
    // ============================================================================

    public static func cmp<T>(obj1: CPointer<T>, obj2: CPointer<T>, typeName: String): Int32 where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = dbind_cmp_imp(CPointer(obj1), CPointer(obj2), tPtr)
            LibC.free(tPtr)
            return res
        }
    }

    public static func equ<T>(obj1: CPointer<T>, obj2: CPointer<T>, typeName: String): Bool where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = dbind_equ_imp(CPointer(obj1), CPointer(obj2), tPtr)
            LibC.free(tPtr)
            return res
        }
    }

    public static func sizeOf<T>(obj: CPointer<T>, typeName: String): UInt32 where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = dbind_sizeof_imp(CPointer(obj), tPtr)
            LibC.free(tPtr)
            return res
        }
    }

    // ============================================================================
    // Serialization
    // ============================================================================

    public static func read<T>(stm: CPointer<Unit>, typeName: String): CPointer<T> where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let res = CPointer<T>(dbind_read_imp(stm, tPtr))
            LibC.free(tPtr)
            return res
        }
    }

    public static func write<T>(stm: CPointer<Unit>, obj: CPointer<T>, typeName: String): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            dbind_write_imp(stm, CPointer(obj), tPtr)
            LibC.free(tPtr)
        }
    }

    // ============================================================================
    // Member Property Configuration
    // ============================================================================

    // public static func defaultVal<T>(typeName: String, memberName: String, value: CPointer<T>): Unit where T <: CType {
    //     unsafe {
    //         let tPtr = LibC.mallocCString(typeName)
    //         let mPtr = LibC.mallocCString(memberName)
    //         dbind_default_imp(tPtr, mPtr, value)
    //         LibC.free(tPtr)
    //         LibC.free(mPtr)
    //     }
    // }

    public static func range<T>(typeName: String, memberName: String, min: T, max: T): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let mPtr = LibC.mallocCString(memberName)
            let pMin = LibC.malloc<T>()
            let pMax = LibC.malloc<T>()
            pMin.write(min)
            pMax.write(max)
            dbind_range_imp(tPtr, mPtr, CPointer(pMin), CPointer(pMax))
            LibC.free(tPtr)
            LibC.free(mPtr)
            LibC.free(pMin)
            LibC.free(pMax)
        }
    }

    // public static func precision<T>(typeName: String, memberName: String, prec: CPointer<T>): Unit where T <: CType {
    //     unsafe {
    //         let tPtr = LibC.mallocCString(typeName)
    //         let mPtr = LibC.mallocCString(memberName)
    //         dbind_precision_imp(tPtr, mPtr, prec)
    //         LibC.free(tPtr)
    //         LibC.free(mPtr)
    //     }
    // }

    public static func increment<T>(typeName: String, memberName: String, incr: T): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let mPtr = LibC.mallocCString(memberName)
            let pInc = LibC.malloc<T>()
            pInc.write(incr)
            dbind_increment_imp(tPtr, mPtr, CPointer(pInc))
            LibC.free(tPtr)
            LibC.free(mPtr)
            LibC.free(pInc)
        }
    }

    public static func suffix(typeName: String, memberName: String, suffix: String): Unit {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let mPtr = LibC.mallocCString(memberName)
            let sPtr = LibC.mallocCString(suffix)
            dbind_suffix_imp(tPtr, mPtr, sPtr)
            LibC.free(tPtr)
            LibC.free(mPtr)
            LibC.free(sPtr)
        }
    }
}
