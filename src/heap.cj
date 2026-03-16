package nappgui4cj

foreign {
    func heap_malloc_imp(size: UInt32, name: CString, equal_size: Bool): CPointer<Unit>

    func heap_calloc_imp(size: UInt32, name: CString, equal_size: Bool): CPointer<Unit>

    func heap_free(mem: CPointer<CPointer<Unit>>, size: UInt32, name: CString): Unit
}

public struct Heap {
    public static func malloc<T>(
        count!: UInt32 = 1,
        name!: CString = CString(CPointer()),
        equal_size!: Bool = true
    ): CPointer<T> where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        let size = count * UInt32(sizeOf<T>())
        return CPointer<T>(unsafe { heap_malloc_imp(size, name, equal_size) })
    }

    public static func calloc<T>(
        count!: UInt32 = 1,
        name!: CString = CString(CPointer()),
        equal_size!: Bool = true
    ): CPointer<T> where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        let size = count * UInt32(sizeOf<T>())
        return CPointer<T>(unsafe { heap_calloc_imp(size, name, equal_size) })
    }

    public static func free<T>(
        mem: CPointer<CPointer<T>>,
        count!: UInt32 = 1,
        name!: CString = CString(CPointer())
    ): Unit where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        let size = count * UInt32(sizeOf<T>())
        unsafe { heap_free(CPointer<CPointer<Unit>>(mem), size, name) }
    }
}
