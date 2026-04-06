package nappgui4cj

public type AppCreateFunc<T> = CFunc<() -> CPointer<T>>

public type AppUpdateFunc<T> = CFunc<(app: CPointer<T>, prtime: Float64, ctime: Float64) -> Unit>

public type DestroyFunc<T> = CFunc<(item: CPointer<CPointer<T>>) -> Unit>

public type EventHandlerFunc<T> = CFunc<(obj: CPointer<T>, e: Event) -> Unit>

public type FromDataFunc<T> = CFunc<(data: CPointer<Byte>, size: UInt32) -> CPointer<T>>

public type ResPackFunc = CFunc<(locale: CString) -> CPointer<Unit>>
