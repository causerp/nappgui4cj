package dice

import casino.*
import nappgui4cj.*
import std.random.Random

let rand = Random()

class App <: Resource {
    private static var m_app: ?App = None

    var window: Window
    var view: View
    var face: VArray<UInt32, $6> = VArray<UInt32, $6>(repeat: 0)

    private init() {
        this.window = Window.create(WindowFlag.Std)
        this.view = View()

        face[0] = 1
        face[1] = 2
        face[2] = 3
        face[3] = 4
        face[4] = 5
        face[5] = 6

        window.setPanel(createPanel(this))
        window.setTitle("Dice")
        window.setOrigin(V2Df(500.0, 200.0))
        window.onClose(onClose)
        window.show()
    }

    static func get(): App {
        match (m_app) {
            case Some(app) => return app
            case None =>
                let app = App()
                m_app = app
                return app
        }
    }

    static func destroy(): Unit {
        m_app?.close()
        m_app = None
    }

    public func isClosed(): Bool {
        window.isNull()
    }

    public func close(): Unit {
        if (!window.isNull()) {
            window.destroy()
        }
    }
}

@C
func onRedraw(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvDraw>()

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

@C
func onAcceptFocus(_: CPointer<Unit>, e: Event): Unit {
    e.setResult<Bool>(false)
}

@C
func onMoved(_: CPointer<Unit>, _: Event): Unit {
    let app = App.get()
    for (i in 0..6) {
        let j = Int64(rand.nextUInt32(6))
        let temp = app.face[i]
        app.face[i] = app.face[j]
        app.face[j] = temp
    }
    app.view.update()
}

func createLayout(app: App): Layout {
    app.view.onDraw(onRedraw)
    app.view.onAcceptFocus(onAcceptFocus)

    let slider = Slider()
    slider.onMoved(onMoved)

    let layout = Layout(1, 2)
    layout.add(app.view, 0, 0)
    layout.add(slider, 0, 1)
    layout.setHSize(0, 600.0)
    layout.setVSize(0, 400.0)
    layout.setMargin(10.0)
    layout.setVMargin(0, 10.0)

    return layout
}

func createPanel(app: App): Panel {
    let panel = Panel()
    let layout = createLayout(app)
    panel.setLayout(layout)
    return panel
}

@C
func onClose(_: CPointer<Unit>, e: Event): Unit {
    if (e.getType() == GUIEvent.WndClose) {
        OSApp.finish()
    }
}

@C
func appCreate(): UIntNative {
    App.get()
    return 1
}

@C
func appDestroy(_: UIntNative): Unit {
    App.destroy()
}

main(): Int64 {
    osmain(onCreate: appCreate, onDestroy: appDestroy)
    return 0
}
