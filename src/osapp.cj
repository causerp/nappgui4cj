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
        func_create: CPointer<Unit>,
        func_update: CPointer<Unit>,
        func_destroy: CPointer<Unit>,
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
    onCreate!: CFunc<() -> CPointer<T>>,
    onDestroy!: CFunc<(CPointer<CPointer<T>>) -> Unit>,
    options!: String = String.empty
): Unit where T <: CType {
    osmain_sync(
        onCreate: onCreate,
        onUpdate: CPointer(),
        onDestroy: onDestroy,
        options: options
    )
}

public func osmain_sync<T>(
    lframe!: Float64 = 0.0,
    onCreate!: CFunc<() -> CPointer<T>>,
    onUpdate!: CFunc<(CPointer<CPointer<T>>, Float64, Float64) -> Unit> = CPointer(),
    onDestroy!: CFunc<(CPointer<CPointer<T>>) -> Unit>,
    options!: String = String.empty
): Unit where T <: CType {
    unsafe {
        let optionsStrPtr = LibC.mallocCString(options)

        @When[os == "Windows"]
        let instance = GetModuleHandleW(CPointer())

        @When[os != "Windows"]
        let instance = CPointer<Unit>()

        osmain_imp(
            0, // argc
            CPointer(), // argv
            instance,
            lframe,
            CPointer(onCreate),
            CPointer(onUpdate),
            CPointer(onDestroy),
            optionsStrPtr
        )

        LibC.free(optionsStrPtr)
    }
}
