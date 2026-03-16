package die

import casino.*
import nappgui4cj.*

@C
struct App {
    var window: Window
    var view: View
    var padding: Float32 = 0.2
    var corner: Float32 = 0.1
    var radius: Float32 = 0.5
    var face: UInt32 = 5

    init(window: Window) {
        this.window = window
        this.view = View()
    }
}

@C
func onDraw(appPtr: CPointer<App>, e: Event): Unit {
    unsafe {
        let app = appPtr.read()
        let paramsPtr = e.getParams<EvDraw>()
        let params = paramsPtr.read()

        let green = Color(102, 153, 26)
        params.ctx.clear(green)
        die_draw(
            params.ctx,
            0.0,
            0.0,
            params.width,
            params.height,
            app.padding,
            app.corner,
            app.radius,
            app.face
        )
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
func onFace(appPtr: CPointer<App>, e: Event): Unit {
    unsafe {
        var app = appPtr.read()
        let paramsPtr = e.getParams<EvButton>()
        let params = paramsPtr.read()

        // EvButton index is 0-based, die face is 1-based
        app.face = params.index + 1
        appPtr.write(app)
        app.view.update()
    }
}

@C
func onPadding(appPtr: CPointer<App>, e: Event): Unit {
    unsafe {
        var app = appPtr.read()
        let paramsPtr = e.getParams<EvSlider>()
        let params = paramsPtr.read()

        app.padding = params.pos
        appPtr.write(app)
        app.view.update()
    }
}

@C
func onCorner(appPtr: CPointer<App>, e: Event): Unit {
    unsafe {
        var app = appPtr.read()
        let paramsPtr = e.getParams<EvSlider>()
        let params = paramsPtr.read()

        app.corner = params.pos
        appPtr.write(app)
        app.view.update()
    }
}

@C
func onRadius(appPtr: CPointer<App>, e: Event): Unit {
    unsafe {
        var app = appPtr.read()
        let paramsPtr = e.getParams<EvSlider>()
        let params = paramsPtr.read()

        app.radius = params.pos
        appPtr.write(app)
        app.view.update()
    }
}

@C
func onLang(_: CPointer<App>, e: Event): Unit {
    unsafe {
        let paramsPtr = e.getParams<EvButton>()
        let params = paramsPtr.read()

        if (params.index == 0) {
            GUI.language("en_us")
        } else {
            GUI.language("es_es")
        }
    }
}

@C
func createLayout(appPtr: CPointer<App>): Layout {
    unsafe {
        // Main Layout: 2 columns, 1 row
        let layout = Layout(2, 1)

        // Sub Layout: 2 columns, 6 rows (Controls)
        let layout1 = Layout(2, 6)

        // Create controls
        let label1 = Label()
        let label2 = Label()
        let label3 = Label()
        let label4 = Label()
        let label5 = Label()
        let label6 = Label()
        let popup1 = PopUp()
        let popup2 = PopUp()
        let slider1 = Slider()
        let slider2 = Slider()
        let slider3 = Slider()
        let img = ImageView()

        // Setup App View
        var app = appPtr.read()

        app.view.setSize(S2Df(200.0, 200.0))
        app.view.onDraw(appPtr, onDraw)
        app.view.onAcceptFocus(appPtr, onAcceptFocus)

        // Setup Labels
        label1.setText(TEXT_LANG)
        label2.setText(TEXT_FACE)
        label3.setText(TEXT_PADDING)
        label4.setText(TEXT_CORNER)
        label5.setText(TEXT_RADIUS)
        label6.setText(TEXT_INFO)
        label6.setMultiline(true)

        // Setup Language PopUp
        popup1.addItem(TEXT_ENGLISH, GUI.image(USA_PNG))
        popup1.addItem(TEXT_SPANISH, GUI.image(SPAIN_PNG))
        popup1.onSelect(appPtr, onLang)

        // Setup Face PopUp
        popup2.addItem(TEXT_ONE, None)
        popup2.addItem(TEXT_TWO, None)
        popup2.addItem(TEXT_THREE, None)
        popup2.addItem(TEXT_FOUR, None)
        popup2.addItem(TEXT_FIVE, None)
        popup2.addItem(TEXT_SIX, None)
        popup2.onSelect(appPtr, onFace)
        // Set initial selection
        popup2.setSelected(app.face - 1)

        // Setup Sliders
        slider1.setValue(app.padding)
        slider2.setValue(app.corner)
        slider3.setValue(app.radius)

        slider1.onMoved(appPtr, onPadding)
        slider2.onMoved(appPtr, onCorner)
        slider3.onMoved(appPtr, onRadius)

        // Setup Image
        img.setImage(CARDS_PNG)

        // Layout Composition
        // Column 0, Row 0: Main View
        layout.add(app.view, 0, 0)

        // Sub Layout Population (layout1)
        // Column 0 (Labels)
        layout1.add(label1, 0, 0)
        layout1.add(label2, 0, 1)
        layout1.add(label3, 0, 2)
        layout1.add(label4, 0, 3)
        layout1.add(label5, 0, 4)
        layout1.add(img, 0, 5)

        // Column 1 (Controls)
        layout1.add(popup1, 1, 0)
        layout1.add(popup2, 1, 1)
        layout1.add(slider1, 1, 2)
        layout1.add(slider2, 1, 3)
        layout1.add(slider3, 1, 4)
        layout1.add(label6, 1, 5)

        // Add SubLayout to Main Layout
        // Column 1, Row 0
        layout.add(layout1, 1, 0)

        // Layout Styling
        layout.setMargin(10.0)
        layout1.setHSize(1, 150.0)
        layout.setHMargin(0, 10.0)

        layout1.setHMargin(0, 5.0)
        layout1.setVMargin(0, 5.0)
        layout1.setVMargin(1, 5.0)
        layout1.setVMargin(2, 5.0)
        layout1.setVMargin(3, 5.0)
        layout1.setVMargin(4, 5.0)

        layout.hExpand(0) // Expand the view column
        layout.setVAlign(1, 0, Align.Top)

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
        // Initialize resources and default language
        GUI.respack(resdieResPack)
        GUI.language("")

        let appPtr = Heap.calloc<App>()
        var app = App(Window.create(WindowFlag.StdRes))
        appPtr.write(app)

        app.window.setPanel(createPanel(appPtr))
        app.window.setTitle(TEXT_TITLE)
        app.window.setOrigin(V2Df(200.0, 200.0))
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
