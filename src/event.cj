package nappgui4cj

foreign {
    func listener_imp(object: CPointer<Unit>, func_event_handler: EventHandlerFunc<Unit>): CPointer<Unit>

    func listener_destroy(listener: CPointer<CPointer<Unit>>): Unit

    @FastNative
    func event_type(event: CPointer<Unit>): GUIEvent

    func event_sender_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func event_params_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func event_result_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>
}

@C
public struct Listener {
    var handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        this.handle = handle
    }

    public static func create<T>(obj: CPointer<T>, eventHandler: EventHandlerFunc<T>): Listener where T <: CType {
        return Listener(unsafe { listener_imp(CPointer(obj), CPointer(eventHandler)) })
    }
}

@C
public struct Event {
    var handle: CPointer<Unit> = CPointer()

    public func getType(): GUIEvent {
        unsafe { event_type(handle) }
    }

    public func getSender<T>(typeName!: ?String = None): ?T where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_sender_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return match (ptr.isNotNull()) {
                case true => CPointer<T>(ptr).read()
                case false => None<T>
            }
        }
    }

    public func getSenderPtr<T>(typeName!: ?String = None): CPointer<T> where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_sender_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return CPointer<T>(ptr)
        }
    }

    public func getParams<T>(typeName!: ?String = None): ?T where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_params_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return match (ptr.isNotNull()) {
                case true => CPointer<T>(ptr).read()
                case false => None<T>
            }
        }
    }

    public func getParamsPtr<T>(typeName!: ?String = None): CPointer<T> where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_params_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return CPointer<T>(ptr)
        }
    }

    public func getResult<T>(typeName!: ?String = None): ?T where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_result_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return match (ptr.isNotNull()) {
                case true => CPointer<T>(ptr).read()
                case false => None<T>
            }
        }
    }

    public func getResultPtr<T>(typeName!: ?String = None): CPointer<T> where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_result_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return CPointer<T>(ptr)
        }
    }

    public func setResult<T>(value: T, typeName!: ?String = None): Unit where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = event_result_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            if (ptr.isNotNull()) {
                CPointer<T>(ptr).write(value)
            }
        }
    }

    public func getBindObj<T>(typeName!: String): ?T where T <: CType {
        unsafe {
            let typeNamePtr = LibC.mallocCString(typeName)
            let ptr = evbind_object_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return match (ptr.isNotNull()) {
                case true => CPointer<T>(ptr).read()
                case false => None
            }
        }
    }

    public func getBindObjPtr<T>(typeName!: ?String = None): CPointer<T> where T <: CType {
        unsafe {
            let typeNamePtr = match (typeName) {
                case Some(typeName) => LibC.mallocCString(typeName)
                case None => CString(CPointer())
            }
            let ptr = evbind_object_imp(handle, typeNamePtr)
            LibC.free(typeNamePtr)
            return CPointer<T>(ptr)
        }
    }

    public func hasBindModify(
        typeName!: String,
        typeSize!: UInt16,
        memberName!: String,
        membertypeName!: String,
        memberOffset!: UInt16,
        memberSize!: UInt16
    ): Bool {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let mPtr = LibC.mallocCString(memberName)
            let mtPtr = LibC.mallocCString(membertypeName)
            let res = evbind_modify_imp(handle, tPtr, typeSize, mPtr, mtPtr, memberOffset, memberSize)
            LibC.free(tPtr)
            LibC.free(mPtr)
            LibC.free(mtPtr)
            return res
        }
    }
}
