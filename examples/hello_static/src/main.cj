package hello_static

import nappgui4cj.*

@C
struct App {
    var window: Window
    var text: TextView
    var clicks: UInt32 = 0

    init(window: Window) {
        this.window = window
        this.text = TextView()
    }
}

@C
func onButton(appPtr: CPointer<App>, _: Event): Unit {
    unsafe {
        var app = appPtr.read()
        app.text.writef("Button click (${app.clicks})\n")
        app.clicks++
        appPtr.write(app)
    }
}

@C
func onClose(_: CPointer<App>, e: Event): Unit {
    if (e.getType() == GUIEvent.WndClose) {
        OSApp.finish()
    }
}

@C
func createPanel(appPtr: CPointer<App>): Panel {
    unsafe {
        let panel = Panel()
        let layout = Layout(1, 3)

        let label = Label()
        label.setText("Hello!, I'm a label")

        let button = Button.createPush()
        button.setText("Click Me!")
        button.onClick(appPtr, onButton)

        var app = appPtr.read()

        layout.add(label, 0, 0)
        layout.add(button, 0, 1)
        layout.add(app.text, 0, 2)

        layout.setHSize(0, 250.0)
        layout.setVSize(2, 100.0)
        layout.setMargin(5.0)
        layout.setVMargin(0, 5.0)
        layout.setVMargin(1, 5.0)

        panel.setLayout(layout)
        return panel
    }
}

@C
func appCreate(): CPointer<App> {
    unsafe {
        let appPtr = Heap.calloc<App>()
        var app = App(Window.create(WindowFlag.Std))
        appPtr.write(app)

        app.window.setPanel(createPanel(appPtr))
        app.window.setTitle("static binary")
        app.window.setOrigin(V2Df(500.0, 200.0))
        app.window.onClose(appPtr, onClose)

        app.window.show()

        return appPtr
    }
}

@C
func appDestroy(appPtrPtr: CPointer<CPointer<App>>): Unit {
    unsafe {
        var app = appPtrPtr.read().read()
        app.window.destroy()
        Heap.free(appPtrPtr)
    }
}

main(): Int64 {
    osmain(onCreate: appCreate, onDestroy: appDestroy)
    return 0
}
