package nappgui4cj

foreign {
    func array_create(esize: UInt16, typeName: CString): CPointer<Unit>

    func array_copy(array: CPointer<Unit>, func_copy: CPointer<Unit>, typeName: CPointer<Byte>): CPointer<Unit>

    func array_copy_ptr(array: CPointer<Unit>, func_copy: CPointer<Unit>, typeName: CPointer<Byte>): CPointer<Unit>

    func array_read(stream: CPointer<Unit>, esize: UInt16, func_read_init: CPointer<Unit>, typeName: CPointer<Byte>): CPointer<Unit>

    func array_read_ex(stream: CPointer<Unit>, esize: UInt16, func_read_init: CPointer<Unit>, data: CPointer<Unit>,
        typeName: CPointer<Byte>): CPointer<Unit>

    func array_read_ptr(stream: CPointer<Unit>, func_read: CPointer<Unit>, typeName: CPointer<Byte>): CPointer<Unit>

    func array_read_ptr_ex(stream: CPointer<Unit>, func_read: CPointer<Unit>, data: CPointer<Unit>,
        typeName: CPointer<Byte>): CPointer<Unit>

    func array_destroy(array: CPointer<CPointer<Unit>>, func_remove: CPointer<Unit>, typeName: CPointer<Byte>): Unit

    func array_destopt(array: CPointer<CPointer<Unit>>, func_remove: CPointer<Unit>, typeName: CPointer<Byte>): Unit

    func array_destroy_ptr(array: CPointer<CPointer<Unit>>, func_destroy: CPointer<Unit>, typeName: CPointer<Byte>): Unit

    func array_destopt_ptr(array: CPointer<CPointer<Unit>>, func_destroy: CPointer<Unit>, typeName: CPointer<Byte>): Unit

    func array_clear(array: CPointer<Unit>, func_remove: CPointer<Unit>): Unit

    func array_clear_ptr(array: CPointer<Unit>, func_destroy: CPointer<Unit>): Unit

    func array_write(stream: CPointer<Unit>, array: CPointer<Unit>, func_write: CPointer<Unit>): Unit

    func array_write_ex(stream: CPointer<Unit>, array: CPointer<Unit>, func_write: CPointer<Unit>, data: CPointer<Unit>): Unit

    func array_write_ptr(stream: CPointer<Unit>, array: CPointer<Unit>, func_write: CPointer<Unit>): Unit

    func array_write_ptr_ex(stream: CPointer<Unit>, array: CPointer<Unit>, func_write: CPointer<Unit>,
        data: CPointer<Unit>): Unit

    func array_size(array: CPointer<Unit>): UInt32

    func array_esize(array: CPointer<Unit>): UInt32

    func array_mem(array: CPointer<Unit>): UInt32

    func array_get(array: CPointer<Unit>, pos: UInt32): CPointer<Byte>

    func array_get_last(array: CPointer<Unit>): CPointer<Byte>

    func array_all(array: CPointer<Unit>): CPointer<Byte>

    func array_insert(array: CPointer<Unit>, pos: UInt32, n: UInt32): CPointer<Byte>

    func array_insert0(array: CPointer<Unit>, pos: UInt32, n: UInt32): CPointer<Byte>

    func array_join(dest: CPointer<Unit>, src: CPointer<Unit>, func_copy: CPointer<Unit>): Unit

    func array_join_ptr(dest: CPointer<Unit>, src: CPointer<Unit>, func_copy: CPointer<Unit>): Unit

    func array_delete(array: CPointer<Unit>, pos: UInt32, n: UInt32, func_remove: CPointer<Unit>): Unit

    func array_delete_ptr(array: CPointer<Unit>, pos: UInt32, n: UInt32, func_destroy: CPointer<Unit>): Unit

    func array_pop(array: CPointer<Unit>, func_remove: CPointer<Unit>): Unit

    func array_pop_ptr(array: CPointer<Unit>, func_destroy: CPointer<Unit>): Unit

    func array_sort(array: CPointer<Unit>, func_compare: CPointer<Unit>): Unit

    func array_sort_ex(array: CPointer<Unit>, func_compare: CPointer<Unit>, data: CPointer<Unit>): Unit

    func array_sort_ptr(array: CPointer<Unit>, func_compare: CPointer<Unit>): Unit

    func array_sort_ptr_ex(array: CPointer<Unit>, func_compare: CPointer<Unit>, data: CPointer<Unit>): Unit

    func array_find_ptr(array: CPointer<Unit>, elem: CPointer<Unit>): UInt32

    func array_search(array: CPointer<Unit>, func_compare: CPointer<Unit>, key: CPointer<Unit>, pos: CPointer<UInt32>): CPointer<Byte>

    func array_search_ptr(array: CPointer<Unit>, func_compare: CPointer<Unit>, key: CPointer<Unit>,
        pos: CPointer<UInt32>): CPointer<Byte>

    func array_bsearch(array: CPointer<Unit>, func_compare: CPointer<Unit>, key: CPointer<Unit>, pos: CPointer<UInt32>): CPointer<Byte>

    func array_bsearch_ptr(array: CPointer<Unit>, func_compare: CPointer<Unit>, key: CPointer<Unit>,
        pos: CPointer<UInt32>): CPointer<Byte>
}

struct NArray<T> <: NappObject where T <: CType {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(esize: UInt16, typeName!: ?String = None) {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            m_handle = array_create(esize, typeNamePtr)
            LibC.free(typeNamePtr)
        }
    }

    // public mut func destroy(func_remove: CPointer<Unit>, typeName: String): Unit {
    //     unsafe {
    //         let strPtr = match (typeName) {
    //             case Some(typeName) => LibC.mallocCString(typeName)
    //             case None => CString(CPointer())
    //         }
    //         m_handle = array_destroy(inout m_handle, strPtr)
    //         LibC.free(strPtr)
    //     }
    //     let typePtr = unsafe { typeName.CPointer() }
    //     unsafe { array_destroy(inout m_handle, func_remove, typePtr) }
    //     m_handle = CPointer()
    // }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func size(): UInt32 {
        unsafe { array_size(m_handle) }
    }

    public func elementSize(): UInt32 {
        unsafe { array_esize(m_handle) }
    }

    public func memorySize(): UInt32 {
        unsafe { array_mem(m_handle) }
    }

    public func get<T>(pos: UInt32): T where T <: CType {
        unsafe {
            let ptr = CPointer<T>(array_get(m_handle, pos))
            return ptr.read()
        }
    }

    public func getLast<T>(): T where T <: CType {
        unsafe {
            let ptr = CPointer<T>(array_get_last(m_handle))
            return ptr.read()
        }
    }

    public func all(): CPointer<Byte> {
        unsafe { array_all(m_handle) }
    }

    public func insert(pos: UInt32, n: UInt32): CPointer<Byte> {
        unsafe { array_insert(m_handle, pos, n) }
    }

    public func insert0(pos: UInt32, n: UInt32): CPointer<Byte> {
        unsafe { array_insert0(m_handle, pos, n) }
    }

    public func delete(pos: UInt32, n: UInt32, func_remove: CPointer<Unit>): Unit {
        unsafe { array_delete(m_handle, pos, n, func_remove) }
    }

    public func deletePtr(pos: UInt32, n: UInt32, func_destroy: CPointer<Unit>): Unit {
        unsafe { array_delete_ptr(m_handle, pos, n, func_destroy) }
    }

    public func clear(func_remove: CPointer<Unit>): Unit {
        unsafe { array_clear(m_handle, func_remove) }
    }

    public func clearPtr(func_destroy: CPointer<Unit>): Unit {
        unsafe { array_clear_ptr(m_handle, func_destroy) }
    }

    public func sort(func_compare: CPointer<Unit>): Unit {
        unsafe { array_sort(m_handle, func_compare) }
    }

    public func sortPtr(func_compare: CPointer<Unit>): Unit {
        unsafe { array_sort_ptr(m_handle, func_compare) }
    }

    public func join<T>(src: NArray<T>, func_copy: CPointer<Unit>): Unit where T <: CType {
        unsafe { array_join(m_handle, src.m_handle, func_copy) }
    }

    public func joinPtr<T>(src: NArray<T>, func_copy: CPointer<Unit>): Unit where T <: CType {
        unsafe { array_join_ptr(m_handle, src.m_handle, func_copy) }
    }

    public func findPtr(elem: CPointer<Unit>): UInt32 {
        unsafe { array_find_ptr(m_handle, elem) }
    }

    public func toArray<T>(): Array<T> where T <: CType {
        unsafe {
            var dataSize = array_size(m_handle)
            let dataPtr = array_all(m_handle)
            return match (dataPtr.isNull()) {
                case false =>
                    let arr = Array<T>(Int64(dataSize), repeat: zeroValue<T>())
                    let rawData = acquireArrayRawData(arr)
                    let numBytes = UIntNative(dataSize) * sizeOf<T>()
                    memcpy_s(CPointer(rawData.pointer), numBytes, dataPtr, numBytes)
                    releaseArrayRawData(rawData)
                    arr
                case true => []
            }
        }
    }
}
