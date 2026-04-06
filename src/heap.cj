package nappgui4cj

foreign {
    func heap_malloc_imp(size: UInt32, name: CString, equal_size: Bool): CPointer<Unit>

    func heap_calloc_imp(size: UInt32, name: CString, equal_size: Bool): CPointer<Unit>

    func heap_free(mem: CPointer<CPointer<Unit>>, size: UInt32, name: CString): Unit
}

public struct Heap {
    public static func malloc<T>(
        count!: UInt32 = 1,
        name!: ?String = None,
        equal_size!: Bool = true
    ): CPointer<T> where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        unsafe {
            let size = count * UInt32(sizeOf<T>())
            let namePtr = match (name) {
                case Some(name) => LibC.mallocCString(name)
                case None => CString(CPointer())
            }
            let ptr = heap_malloc_imp(size, namePtr, equal_size)
            LibC.free(namePtr)
            return CPointer<T>(ptr)
        }
    }

    public static func calloc<T>(
        count!: UInt32 = 1,
        name!: ?String = None,
        equal_size!: Bool = true
    ): CPointer<T> where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        unsafe {
            let size = count * UInt32(sizeOf<T>())
            let namePtr = match (name) {
                case Some(name) => LibC.mallocCString(name)
                case None => CString(CPointer())
            }
            let ptr = heap_calloc_imp(size, namePtr, equal_size)
            LibC.free(namePtr)
            return CPointer<T>(ptr)
        }
    }

    public static func free<T>(
        mem: CPointer<T>,
        count!: UInt32 = 1,
        name!: ?String = None
    ): Unit where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        unsafe {
            var ptr = CPointer<Unit>(mem)
            let size = count * UInt32(sizeOf<T>())
            let namePtr = match (name) {
                case Some(name) => LibC.mallocCString(name)
                case None => CString(CPointer())
            }
            heap_free(inout ptr, size, namePtr)
            LibC.free(namePtr)
        }
    }
}
