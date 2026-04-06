package hello_static

import nappgui4cj.*

class App <: Resource {
    private static var m_app: ?App = None

    var window: Window
    var text: TextView
    var clicks: UInt32 = 0

    private init() {
        window = Window(WindowFlag.Std)
        text = TextView()

        window.setPanel(createPanel(this))
        window.setTitle("static binary")
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
func onButton(_: CPointer<Unit>, _: Event): Unit {
    let app = App.get()
    app.text.writef("Button click (${app.clicks})\n")
    app.clicks++
}

@C
func onClose(_: CPointer<Unit>, e: Event): Unit {
    if (e.getType() == GUIEvent.WndClose) {
        OSApp.finish()
    }
}

func createPanel(app: App): Panel {
    let label = Label()
    label.setText("Hello!, I'm a label")

    let button = Button(BtnPush)
    button.setText("Click Me!")
    button.onClick(onButton)

    let layout = Layout(1, 3)
    layout.add(label, 0, 0)
    layout.add(button, 0, 1)
    layout.add(app.text, 0, 2)
    layout.setHSize(0, 250.0)
    layout.setVSize(2, 100.0)
    layout.setMargin(5.0)
    layout.setVMargin(0, 5.0)
    layout.setVMargin(1, 5.0)

    let panel = Panel()
    panel.setLayout(layout)
    return panel
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
