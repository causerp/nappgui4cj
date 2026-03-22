package nappgui4cj

foreign {
    func listener_imp(object: CPointer<Unit>, func_event_handler: CFunc<(CPointer<Unit>, CPointer<Unit>) -> Unit>): CPointer<Unit>

    func listener_destroy(listener: CPointer<CPointer<Unit>>): Unit

    @FastNative
    func event_type(event: CPointer<Unit>): GUIEvent

    func event_sender_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func event_params_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func event_result_imp(event: CPointer<Unit>, typeName: CString): CPointer<Unit>
}

public type EventHandlerFunc<T> = CFunc<(CPointer<T>, Event) -> Unit>

@C
public struct Listener {
    var handle: CPointer<Unit> = CPointer()

    private init(obj: CPointer<Unit>, eventHandler: CFunc<(CPointer<Unit>, CPointer<Unit>) -> Unit>) {
        handle = unsafe { listener_imp(obj, eventHandler) }
    }

    public static func create<T>(obj: CPointer<T>, eventHandler: EventHandlerFunc<T>): Listener where T <: CType {
        return Listener(CPointer(obj), CPointer(eventHandler))
    }
}

@C
public struct Event {
    var handle: CPointer<Unit> = CPointer()

    public func getType(): GUIEvent {
        unsafe { event_type(handle) }
    }

    public func getSender<T>(typeName!: CString = CString(CPointer())): T where T <: CType {
        unsafe {
            let ptr = event_sender_imp(handle, typeName)
            return CPointer<T>(ptr).read()
        }
    }

    public func getSenderPtr<T>(typeName!: CString = CString(CPointer())): CPointer<T> where T <: CType {
        unsafe {
            let ptr = event_sender_imp(handle, typeName)
            return CPointer<T>(ptr)
        }
    }

    public func getParams<T>(typeName!: CString = CString(CPointer())): T where T <: CType {
        unsafe {
            let ptr = event_params_imp(handle, typeName)
            return CPointer<T>(ptr).read()
        }
    }

    public func getParamsPtr<T>(typeName!: CString = CString(CPointer())): CPointer<T> where T <: CType {
        unsafe {
            let ptr = event_params_imp(handle, typeName)
            return CPointer<T>(ptr)
        }
    }

    public func getResult<T>(typeName!: CString = CString(CPointer())): T where T <: CType {
        unsafe {
            let ptr = event_result_imp(handle, typeName)
            return CPointer<T>(ptr).read()
        }
    }

    public func getResultPtr<T>(typeName!: CString = CString(CPointer())): CPointer<T> where T <: CType {
        unsafe {
            let ptr = event_result_imp(handle, typeName)
            return CPointer<T>(ptr)
        }
    }

    public func setResult<T>(value: T, typeName!: CString = CString(CPointer())): Unit where T <: CType {
        unsafe {
            let ptr = CPointer<T>(event_result_imp(handle, typeName))
            if (ptr.isNotNull()) {
                ptr.write(value)
            }
        }
    }
}
