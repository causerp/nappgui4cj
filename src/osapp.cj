package nappgui4cj

foreign {
    @When[os == "Windows"]
    func GetModuleHandleW(name: CPointer<Unit>): CPointer<Unit>

    func osapp_finish(): Unit

    func osmain_imp(
        argc: UInt32,
        argv: CPointer<CString>,
        instance: CPointer<Unit>,
        lframe: Float64,
        func_create: UIntNative,
        func_update: UIntNative,
        func_destroy: UIntNative,
        options: CString
    ): Unit
}

public class OSApp {
    public static func finish(): Unit {
        unsafe { osapp_finish() }
    }
}

/**
 * Entry point wrapper mimicking the 'osmain' macro from NAppGUI.
 * Params:
 *   onCreate: Pointer to the application creation function (OnCreate).
 *   onDestroy: Pointer to the application destruction function (OnDestroy).
 *   options: String options (passed as C string pointer).
 */
public func osmain<T>(
    onCreate!: AppCreateFunc<T>,
    onDestroy!: DestroyFunc<T>,
    options!: String = String.empty
): Unit where T <: CType {
    osmain_sync(
        lframe: 0.0,
        onCreate: CPointer<Unit>(onCreate).toUIntNative(),
        onUpdate: CPointer<Unit>().toUIntNative(),
        onDestroy: CPointer<Unit>(onDestroy).toUIntNative(),
        options: options
    )
}

public func osmain(
    onCreate!: CFunc<() -> UIntNative>,
    onDestroy!: CFunc<(UIntNative) -> Unit>,
    options!: String = String.empty
): Unit {
    osmain_sync(
        lframe: 0.0,
        onCreate: CPointer<Unit>(onCreate).toUIntNative(),
        onUpdate: CPointer<Unit>().toUIntNative(),
        onDestroy: CPointer<Unit>(onDestroy).toUIntNative(),
        options: options
    )
}

public func osmain_sync(
    lframe!: Float64 = 0.0,
    onCreate!: CFunc<() -> UIntNative>,
    onUpdate!: CFunc<(UIntNative, Float64, Float64) -> Unit> = CPointer(),
    onDestroy!: CFunc<(UIntNative) -> Unit>,
    options!: String = String.empty
): Unit {
    osmain_sync(
        lframe: lframe,
        onCreate: CPointer<Unit>(onCreate).toUIntNative(),
        onUpdate: CPointer<Unit>(onUpdate).toUIntNative(),
        onDestroy: CPointer<Unit>(onDestroy).toUIntNative(),
        options: options,
    )
}

public func osmain_sync<T>(
    lframe!: Float64 = 0.0,
    onCreate!: AppCreateFunc<T>,
    onUpdate!: AppUpdateFunc<T> = CPointer(),
    onDestroy!: DestroyFunc<T>,
    options!: String = String.empty
): Unit where T <: CType {
    osmain_sync(
        lframe: lframe,
        onCreate: CPointer<Unit>(onCreate).toUIntNative(),
        onUpdate: CPointer<Unit>(onUpdate).toUIntNative(),
        onDestroy: CPointer<Unit>(onDestroy).toUIntNative(),
        options: options,
    )
}

private func osmain_sync(
    lframe!: Float64,
    onCreate!: UIntNative,
    onUpdate!: UIntNative,
    onDestroy!: UIntNative,
    options!: String
): Unit {
    unsafe {
        @When[os == "Windows"]
        let instance = GetModuleHandleW(CPointer())

        @When[os != "Windows"]
        let instance = CPointer<Unit>()

        let optionsStrPtr = LibC.mallocCString(options)
        osmain_imp(
            0, // argc
            CPointer(), // argv
            instance,
            lframe,
            onCreate,
            onUpdate,
            onDestroy,
            optionsStrPtr
        )
        LibC.free(optionsStrPtr)
    }
}
