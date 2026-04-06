package colorview

import nappgui4cj.*
import std.collection.{ArrayList, enumerate}

// Constants
const ITEM_WIDTH: Float32 = 64.0
const VER_MARGIN: Float32 = 10.0
const HOR_MARGIN: Float32 = 15.0

class ViewItem {
    var name: String
    var color: Color

    init(name: String, color: Color) {
        this.name = name
        this.color = color
    }
}

class App <: Resource {
    private static var m_app: ?App = None

    var window: Window
    var view: View
    var items: ArrayList<ViewItem>
    var numCols: UInt32 = 1
    var font: Font

    private init() {
        window = Window(WindowFlag.StdRes)
        view = View()
        font = Font(FntSystem, Font.regularSize, FStyle.Normal)
        items = getColors()
    }

    private func initialize(): Unit {
        let panel = createPanel(this)
        window.setPanel(panel)
        window.setTitle("Color View")
        window.setOrigin(V2Df(500.0, 200.0))
        window.setClientSize(S2Df(500.0, 300.0))
        window.onClose(onClose)
        window.show()
    }

    static func get(): App {
        match (m_app) {
            case Some(app) => return app
            case None =>
                let app = App()
                m_app = app
                app.initialize()
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

    // Initialize the color list
    private static func getColors(): ArrayList<ViewItem> {
        let list = ArrayList<ViewItem>()

        list.add(ViewItem("Label", GUI.labelColor()))
        list.add(ViewItem("View", GUI.viewColor()))
        list.add(ViewItem("Line", GUI.lineColor()))
        list.add(ViewItem("Border", GUI.borderColor()))
        list.add(ViewItem("Link", GUI.linkColor()))
        list.add(ViewItem("Alt1", GUI.altColor(Color(192, 255, 255), Color(48, 112, 112))))
        list.add(ViewItem("Alt2", GUI.altColor(Color(255, 192, 255), Color(128, 48, 112))))
        list.add(ViewItem("Alt3", GUI.altColor(Color(255, 255, 192), Color(112, 112, 48))))
        list.add(ViewItem("Black", Color.BLACK))
        list.add(ViewItem("White", Color.WHITE))
        list.add(ViewItem("Red", Color.RED))
        list.add(ViewItem("Green", Color.GREEN))
        list.add(ViewItem("Blue", Color.BLUE))
        list.add(ViewItem("Yellow", Color.YELLOW))
        list.add(ViewItem("Cyan", Color.CYAN))
        list.add(ViewItem("Magenta", Color.MAGENTA))
        list.add(ViewItem("Silver", Color(192, 192, 192)))
        list.add(ViewItem("Gray", Color(128, 128, 128)))
        list.add(ViewItem("Maroon", Color(128, 0, 0)))
        list.add(ViewItem("Olive", Color(128, 128, 0)))
        list.add(ViewItem("DGreen", Color(0, 128, 0)))
        list.add(ViewItem("Teal", Color(0, 128, 128)))
        list.add(ViewItem("Navy", Color(0, 0, 128)))
        list.add(ViewItem("Purple", Color(128, 0, 128)))

        return list
    }
}

@C
func onDraw(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvDraw>() ?? return
    let app = App.get()

    let ctx = params.ctx
    let width = params.width
    let height = params.height

    ctx.setFont(app.font)
    ctx.setTextAlign(Align.Center, Align.Bottom)

    let cwidth = (width - 2.0 * HOR_MARGIN) / Float32(app.numCols)
    let cheight = ITEM_WIDTH + app.font.height

    for ((index, item) in app.items |> enumerate) {
        let row = UInt32(index) / app.numCols
        let col = UInt32(index) % app.numCols

        let x = HOR_MARGIN + Float32(col) * cwidth
        let y = Float32(row) * cheight + Float32(row + 1) * VER_MARGIN

        // Draw color rectangle
        // Centered horizontally
        let rx = x + (cwidth - ITEM_WIDTH) / 2.0
        // Placed at the bottom of the cell (Text is at top because Align is Bottom)
        let ry = y + cheight - ITEM_WIDTH

        ctx.setFillColor(item.color)
        ctx.drawRect(DrawOp.Fill, rx, ry, ITEM_WIDTH, ITEM_WIDTH)

        // Draw text
        ctx.setTextColor(GUI.labelColor())
        let tx = x + cwidth / 2.0
        // Draw at top of cell (y). Since alignment is Bottom, the text sits just above y.
        ctx.drawText(item.name, tx, y)
    }
}

@C
func onSize(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvSize>() ?? return
    let app = App.get()

    let view = app.view
    let minWidth = ITEM_WIDTH + 2.0 * HOR_MARGIN
    var cwidth: Float32 = 0.0
    var cheight: Float32 = 0.0

    cwidth = params.width

    if (cwidth < minWidth) {
        cwidth = minWidth
        app.numCols = 1
    } else {
        let n = UInt32(app.items.size)
        app.numCols = UInt32((cwidth - HOR_MARGIN) / (ITEM_WIDTH + HOR_MARGIN))
        if (app.numCols < 1) {
            app.numCols = 1
        }

        var numRows = n / app.numCols
        if (n % app.numCols > 0) {
            numRows += 1
        }

        cheight = Float32(numRows) * (ITEM_WIDTH + app.font.height + VER_MARGIN) + VER_MARGIN
        if (cheight < params.height) {
            cheight = params.height
        }
    }

    view.setContentSize(S2Df(cwidth, cheight), S2Df(1.0, 1.0))
    view.update()
}

func createPanel(app: App): Panel {
    app.view.setSize(S2Df(300.0, 200.0))
    app.view.onDraw(onDraw)
    app.view.onSize(onSize)

    let panel = Panel()
    let layout = Layout(1, 1)
    layout.add(app.view, 0, 0)
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
