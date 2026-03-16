package nappgui4cj

// inout VArray parameters can only be called in @C functions and not from inside structs.

@C
public func resIdCreate(cStrPtr: CPointer<UInt8>): ResId {
    unsafe { ResId(cStrPtr) }
}

@C
public struct ResId {
    public let cStr: CString

    init(cStrPtr: CPointer<UInt8>) {
        cStr = CString(cStrPtr)
    }
}
