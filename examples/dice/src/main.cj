package dice

import casino.*
import nappgui4cj.*
import std.random.Random

let rand = Random()

@C
struct App {
    var window: Window
    var view: View
    var face: VArray<UInt32, $6> = VArray<UInt32, $6>(repeat: 0)

    init(window: Window) {
        this.window = window
        this.view = View()
        face[0] = 1
        face[1] = 2
        face[2] = 3
        face[3] = 4
        face[4] = 5
        face[5] = 6
    }
}

@C
func onRedraw(appPtr: CPointer<App>, e: Event): Unit {
    unsafe {
        var app = appPtr.read()
        let paramsPtr = e.getParams<EvDraw>()
        let params = paramsPtr.read()

        let green = Color(102, 153, 26)
        let w = params.width / 3.0
        let h = params.height / 2.0
        let p = DefPadding
        let c = DefCorner
        let r = DefRadius

        params.ctx.clear(green)

        die_draw(params.ctx, 0.0, 0.0, w, h, p, c, r, app.face[0])
        die_draw(params.ctx, w, 0.0, w, h, p, c, r, app.face[1])
        die_draw(params.ctx, 2.0 * w, 0.0, w, h, p, c, r, app.face[2])
        die_draw(params.ctx, 0.0, h, w, h, p, c, r, app.face[3])
        die_draw(params.ctx, w, h, w, h, p, c, r, app.face[4])
        die_draw(params.ctx, 2.0 * w, h, w, h, p, c, r, app.face[5])
    }
}

@C
func onAcceptFocus(_: CPointer<App>, e: Event): Unit {
    unsafe {
        let result = e.getResult<Bool>()
        result.write(false)
    }
}

@C
func onMoved(appPtr: CPointer<App>, _: Event): Unit {
    unsafe {
        var app = appPtr.read()

        for (i in 0..6) {
            let j = Int64(rand.nextUInt32(6))
            let temp = app.face[i]
            app.face[i] = app.face[j]
            app.face[j] = temp
        }

        appPtr.write(app)
        app.view.update()
    }
}

@C
func createLayout(appPtr: CPointer<App>): Layout {
    unsafe {
        let layout = Layout(1, 2)

        let view = View()
        let slider = Slider()

        var app = appPtr.read()
        app.view = view
        appPtr.write(app)

        view.onDraw(appPtr, onRedraw)
        view.onAcceptFocus(appPtr, onAcceptFocus)
        slider.onMoved(appPtr, onMoved)

        layout.add(view, 0, 0)
        layout.add(slider, 0, 1)

        layout.setHSize(0, 600.0)
        layout.setVSize(0, 400.0)
        layout.setMargin(10.0)
        layout.setVMargin(0, 10.0)

        return layout
    }
}

@C
func createPanel(appPtr: CPointer<App>): Panel {
    unsafe {
        let panel = Panel()
        let layout = createLayout(appPtr)
        panel.setLayout(layout)
        return panel
    }
}

@C
func onClose(_: CPointer<App>, e: Event): Unit {
    if (e.getType() == GUIEvent.WndClose) {
        OSApp.finish()
    }
}

@C
func appCreate(): CPointer<App> {
    unsafe {
        let appPtr = Heap.calloc<App>()
        var app = App(Window.create(WindowFlag.Std))
        appPtr.write(app)

        app.window.setPanel(createPanel(appPtr))
        app.window.setTitle("Dice")
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
