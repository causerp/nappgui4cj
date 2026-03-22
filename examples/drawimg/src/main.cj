package drawimg

import nappgui4cj.*
import std.math.FloatingPoint

class App <: Resource {
    private static var m_app: ?App = None

    var window: Window
    var expwin: ?Window = None
    var font: Font
    var view: View
    var iview: ImageView
    var res: UInt32 = 0
    var angle: Float32 = 0.0
    var scale: Float32 = 1.0
    var exp_path: String = ""
    var exp_bpp: UInt32 = 0
    var exp_alpha: Bool = false

    private init() {
        window = Window.create(WindowFlag.Std)
        font = Font.createSystem(25.0, 0)
        view = View()
        iview = ImageView()
        res = 0
        angle = 0.0
        scale = 1.0

        let panel = createPanel(this)

        window.setPanel(panel)
        window.setTitle("Drawing on an image")
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
                drawImg(app)
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

// Constants
let i_WIDTH: Array<UInt32> = [600, 300, 150, 75]
let i_HEIGHT: Array<UInt32> = [400, 200, 100, 50]
let i_SCALE: Array<Float32> = [1.0, 0.5, 0.25, 0.125]

// Helper functions

func drawContent(ctx: DCtx, t2d_global: T2Df, font: Font): Unit {
    let triangle: Array<V2Df> = [
        V2Df(472.0, 0.0),
        V2Df(600.0, 144.0),
        V2Df(344.0, 144.0)
    ]

    var pack = unsafe { resdrawimgResPack(CString(CPointer())) }
    let image1 = Image(pack, MONKEY_PNG)
    let image2 = Image(pack, ZOMBIE_PNG)

    var t2d_object = t2d_global.scale(0.5, 0.5)
    ctx.setMatrix(t2d_object)
    ctx.drawImage(image1, 688.0, 288.0)

    ctx.setLineColor(Color.RED)
    ctx.setLineWidth(3.0)
    ctx.setFillColor(Color.BLUE)

    t2d_object = t2d_global.rotate(Float32.getPI() / 4.0)
    ctx.setMatrix(t2d_object)
    ctx.drawRect(DrawOp.SkFill, 0.0, 0.0, 320.0, 200.0)

    ctx.setFillColor(Color.GREEN)
    ctx.setMatrix(t2d_global)
    ctx.drawCircle(DrawOp.SkFill, 300.0, 200.0, 100.0)

    ctx.setLineColor(Color.BLUE)
    ctx.setFillColor(Color.RED)
    ctx.drawPolygon(DrawOp.SkFill, triangle)

    t2d_object = t2d_global.scale(0.7, 0.7)
    ctx.setMatrix(t2d_object)
    ctx.drawImage(image2, 0.0, 0.0)

    ctx.setFont(font)
    ctx.setMatrix(t2d_global)
    ctx.setTextColor(Color.RED)
    ctx.drawText("Hello Drawings!", 200.0, 15.0)

    ctx.setLineColor(Color(0, 128, 0))
    ctx.drawLine(150.0, 350.0, 330.0, 350.0)
    ctx.setLineColor(Color.BLUE)
    ctx.drawLine(100.0, 370.0, 330.0, 370.0)
    ctx.setLineColor(Color(128, 0, 0))
    ctx.drawLine(20.0, 390.0, 330.0, 390.0)

    pack.destroy()
}

func drawImg(app: App): Unit {
    let w = i_WIDTH[Int64(app.res)]
    let h = i_HEIGHT[Int64(app.res)]
    let scale = i_SCALE[Int64(app.res)]

    var ctx = DCtx(w, h, PixFormat.RGB24)
    let t2d = T2Df().scale(scale, scale)

    ctx.clear(Color(200, 200, 200))
    drawContent(ctx, t2d, app.font)

    var image = ctx.toImage()
    app.iview.setImage(image)
    image.destroy()
}

func exportPng(): Unit {
    let w: UInt32 = 640
    let h: UInt32 = 400
    let wi = w / 4

    var palette = Palette.create(4)
    palette.setColor(0, Color(255, 0, 0, 255))
    palette.setColor(1, Color(0, 255, 0, 170))
    palette.setColor(2, Color(0, 0, 255, 85))
    palette.setColor(3, Color(255, 255, 255, 1))

    var pixbuf = Pixbuf.create(w, h, PixFormat.Index2)

    for (i in 0..w) {
        var idx: UInt32 = 3
        if (i < wi) {
            idx = 0
        } else if (i < 2 * wi) {
            idx = 1
        } else if (i < 3 * wi) {
            idx = 2
        }

        for (j in 0..h) {
            pixbuf.setPixel(i, j, idx)
        }
    }

    var image = Image(pixbuf, palette)
    image.setCodec(Codec.GIF)
    image.toFile("/home/fran/Desktop/export.gif")
    pixbuf.destroy()
    palette.destroy()
    image.destroy()
}

func createExportLayout(): Layout {
    let layout = Layout(2, 1)
    let edit = Edit()
    let button = Button.createPush()
    button.setText("Open")
    layout.add(edit, 0, 0)
    layout.add(button, 1, 0)
    return layout
}

func createBppLayout(): Layout {
    let layout = Layout(1, 5)
    let button1 = Button.createRadio()
    let button2 = Button.createRadio()
    let button3 = Button.createRadio()
    let button4 = Button.createRadio()
    let button5 = Button.createRadio()

    button1.setText("1 bpp (2 colors)")
    button2.setText("2 bpp (4 colors)")
    button3.setText("4 bpp (16 colors)")
    button4.setText("8 bpp (32 colors)")
    button5.setText("RGB (True color)")

    layout.add(button1, 0, 0)
    layout.add(button2, 0, 1)
    layout.add(button3, 0, 2)
    layout.add(button4, 0, 3)
    layout.add(button5, 0, 4)
    return layout
}

func createExportWindow(app: App): Window {
    let window = Window.create(WindowFlag.Title | WindowFlag.Close)
    let panel = Panel()
    let layout1 = Layout(3, 4)
    let layout2 = createExportLayout()
    let layout3 = createBppLayout()

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let popup = PopUp()
    let button1 = Button.createCheck()
    let button2 = Button.createPush()
    let button3 = Button.createPush()

    label1.setText("File name:")
    label2.setText("Format:")
    label3.setText("Pixel Depth (bpp):")
    label4.setText("Transparent background:")
    button2.setText("Ok")
    button3.setText("Cancel")

    button2.onClick(onExportOk)
    button3.onClick(onExportCancel)

    layout1.add(label1, 0, 0)
    layout1.add(label2, 0, 1)
    layout1.add(label3, 0, 2)
    layout1.add(label4, 0, 3)
    layout1.add(layout2, 1, 0)
    layout1.add(popup, 1, 1)
    layout1.add(layout3, 1, 2)
    layout1.add(button1, 1, 3)
    layout1.add(button2, 2, 0)
    layout1.add(button3, 2, 1)

    panel.setLayout(layout1)
    window.setPanel(panel)
    window.setTitle("Image export")
    return window
}

func createImgLayout(app: App): Layout {
    let layout = Layout(7, 1)
    let label = Label()
    let button1 = Button.createRadio()
    let button2 = Button.createRadio()
    let button3 = Button.createRadio()
    let button4 = Button.createRadio()
    let button5 = Button.createPush()

    label.setText("Image context:")
    button1.setText("600x400")
    button2.setText("300x200")
    button3.setText("150x100")
    button4.setText("75x50")
    button5.setText("Export...")

    button1.setState(GUIState.On)
    button1.onClick(onResolution)
    button5.onClick(onExport)

    layout.add(label, 0, 0)
    layout.add(button1, 1, 0)
    layout.add(button2, 2, 0)
    layout.add(button3, 3, 0)
    layout.add(button4, 4, 0)
    layout.add(button5, 6, 0)

    layout.setHMargin(0, 5.0)
    layout.setHMargin(1, 10.0)
    layout.setHMargin(2, 10.0)
    layout.setHMargin(3, 10.0)
    layout.hExpand(5)

    return layout
}

func createWinLayout(app: App): Layout {
    let layout = Layout(5, 1)
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let slider1 = Slider()
    let slider2 = Slider()

    label1.setText("Window context: 600x400")
    label2.setText("Angle:")
    label3.setText("Scale:")

    slider1.setValue(0.5)
    slider2.setValue(0.5)

    slider1.onMoved(onAngle)
    slider2.onMoved(onScale)

    layout.add(label1, 0, 0)
    layout.add(label2, 1, 0)
    layout.add(label3, 3, 0)
    layout.add(slider1, 2, 0)
    layout.add(slider2, 4, 0)

    layout.setHMargin(0, 10.0)
    layout.setHMargin(2, 10.0)
    layout.hExpand2(2, 4, 0.5)

    return layout
}

func createPanel(app: App): Panel {
    let panel = Panel()
    let layout1 = Layout(2, 2)
    let layout2 = createWinLayout(app)
    let layout3 = createImgLayout(app)

    app.view.setSize(S2Df(600.0, 400.0))
    app.iview.setSize(S2Df(600.0, 400.0))

    app.view.onDraw(onDraw)
    app.iview.setScale(GUIScale.Aspect)

    layout1.add(layout2, 0, 0)
    layout1.add(app.view, 0, 1)
    layout1.add(app.iview, 1, 1)
    layout1.add(layout3, 1, 0)

    layout1.setMargin(10.0)
    layout1.setHMargin(0, 5.0)
    layout1.setVMargin(0, 5.0)

    panel.setLayout(layout1)
    return panel
}

// Event Handlers

@C
func onDraw(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvDraw>()

    var t2d = T2Df().rotate(app.angle).scale(app.scale, 1.0)
    params.ctx.clear(Color(200, 200, 200))
    drawContent(params.ctx, t2d, app.font)
}

@C
func onResolution(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvButton>()
    app.res = params.index
    drawImg(app)
}

@C
func onAngle(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvSlider>()
    app.angle = (params.pos - 0.5) * Float32.getPI()
    app.view.update()
}

@C
func onScale(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvSlider>()
    app.scale = params.pos + 0.5
    app.view.update()
}

@C
func onExport(_: CPointer<Unit>, _: Event): Unit {
    let app = App.get()
    var expwin = createExportWindow(app)
    app.expwin = expwin

    let p0 = app.window.getOrigin()
    let s0 = app.window.getSize()
    let s1 = expwin.getSize()
    let p1 = V2Df(p0.x + (s0.width - s1.width) / 2.0, p0.y + (s0.height - s1.height) / 2.0)

    expwin.setOrigin(p1)
    let res = expwin.runModal(app.window)

    if (res == 1) {
        exportPng()
    }

    expwin.destroy()
    app.expwin = None
}

@C
func onExportOk(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    app.expwin?.stopModal(1)
}

@C
func onExportCancel(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    app.expwin?.stopModal(0)
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
