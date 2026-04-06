package guihello

import nappgui4cj.*

private class App <: Resource {
    private static var m_app: ?App = None

    var window: Window
    var layout: Layout

    private init() {
        window = Window(WindowFlag.Std | WindowFlag.Esc | WindowFlag.Return)
        layout = Layout(2, 1)

        let panel = createPanel(this)

        window.setPanel(panel)
        window.setTitle("NAppGUI GUI Basics")
        window.setOrigin(V2Df(500.0, 200.0))
        window.onClose(maOnClose)
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

private func setPanel(app: App, index: UInt32): Unit {
    let defbutton = Box<?Button>(None)
    var valign = Align.Top
    let panel: ?Panel = match (index) {
        case 0 => labelsSingleLine()
        case 1 => labelsMultiLine()
        case 2 => labelsMouseOver()
        case 3 => buttonsBasics(defbutton)
        case 4 => popupCombo()
        case 5 => listboxes()
        case 6 =>
            // formBasic(app.window)
            println("Case 6: formBasic")
            None
        case 7 =>
            // seltext(app.window)
            println("Case 7: seltext")
            None
        case 8 =>
            // editor(app.window)
            println("Case 8: editor")
            None
        case 9 => sliders()
        case 10 => tabstops()
        case 11 => textviews()
        case 12 => tableView()
        case 13 => splitPanel()
        case 14 =>
            // modalWindows(app.window)
            println("Case 14: modalWindows")
            None
        case 15 =>
            // flyoutWindow(app.window)
            println("Case 15: flyoutWindow")
            None
        case 16 =>
            // editpad()
            println("Case 16: editpad")
            None
        case 17 => buttonpad()
        case 18 =>
            // hotkeys(app.window)
            println("Case 18: hotkeys")
            None
        case 19 =>
            // guibind()
            println("Case 19: guibind")
            None
        case 20 => layoutbind()
        case 21 => basicLayout()
        case 22 =>
            valign = Align.Justify
            sublayouts()
        case 23 => subpanels()
        case 24 =>
            // multilayouts()
            println("Case 24: multilayouts")
            None
        case 25 => scrollpanel()
        case 26 => dynlayPanel()
        case 27 =>
            // dynmenuPanel(app.window)
            println("Case 27: dynmenuPanel")
            None
        case 28 =>
            // ipInput(app.window)
            println("Case 28: ipInput")
            None
        case 29 =>
            // fontXScale()
            println("Case 29: fontXScale")
            None
        case 30 =>
            // fontUnitsDemo()
            println("Case 30: fontUnitsDemo")
            None
        case 31 =>
            // reduce(app.window)
            println("Case 31: reduce")
            None
        case 32 =>
            // commonWindows(app.window)
            println("Case 32: commonWindows")
            None
        case _ =>
            println("Unknown case")
            None
    }

    if (let Some(panel) <- panel) {
        app.layout.replace(panel, 1, 0)
        app.layout.setVAlign(1, 0, valign)
    }
    if (!app.window.isNull()) {
        app.window.setDefaultButton(defbutton.value)
    }
}

private func modalWindow(parent: Window, message: String): Unit {
    var window = Window(WindowFlag.Std | WindowFlag.Esc | WindowFlag.Return)
    let panel = Panel()
    let layout = Layout(1, 1)
    let label = Label()

    label.setText(message)
    layout.add(label, 0, 0)
    layout.setMargin(10.0)
    panel.setLayout(layout)

    window.setPanel(panel)
    window.setTitle("Message")

    let p0 = parent.getOrigin()
    let s1 = parent.getSize()
    let s2 = window.getSize()

    let p1 = V2Df(p0.x + (s1.width - s2.width) / 2.0, p0.y + (s1.height - s2.height) / 2.0)
    window.setOrigin(p1)

    window.runModal(parent)
    window.destroy()
}

private func createPanel(app: App): Panel {
    let panel = Panel()

    let list = ListBox()
    list.setSize(S2Df(180.0, 256.0))

    list.addItem("Labels single line")
    list.addItem("Labels multi line")
    list.addItem("Labels mouse sensitive")
    list.addItem("Buttons")
    list.addItem("PopUp Combo")
    list.addItem("ListBoxes")
    list.addItem("Form")
    list.addItem("Text select")
    list.addItem("Text editor")
    list.addItem("Sliders")
    list.addItem("Tabstops")
    list.addItem("TextViews")
    list.addItem("TableView")
    list.addItem("SplitViews")
    list.addItem("Modal Windows")
    list.addItem("Flyout Windows")
    list.addItem("Editbox padding")
    list.addItem("Button padding")
    list.addItem("Hotkeys")
    list.addItem("Data Binding")
    list.addItem("Struct Binding")
    list.addItem("Basic Layout")
    list.addItem("SubLayouts")
    list.addItem("Subpanels")
    list.addItem("Multi-Layouts")
    list.addItem("Scroll panel")
    list.addItem("Dynamic layouts")
    list.addItem("Dynamic menus")
    list.addItem("IP Input")
    list.addItem("Font x-scale")
    list.addItem("Font units")
    list.addItem("Reduce components")
    list.addItem("Common windows")

    list.select(0, true)
    list.onSelect(maOnSelect)

    app.layout.add(list, 0, 0)
    setPanel(app, 0)

    panel.setLayout(app.layout)

    // Layout settings
    app.layout.setVAlign(0, 0, Align.Top)
    app.layout.setVAlign(1, 0, Align.Top)
    app.layout.setMargin(10.0)
    app.layout.setHMargin(0, 10.0)

    return panel
}

// Event Handlers

@C
func maOnSelect(_: CPointer<Unit>, e: Event): Unit {
    let index = e.getParams<EvButton>()?.index ?? UInt32.Max
    if (index != UInt32.Max) {
        let app = App.get()
        setPanel(app, index)
        app.window.update()
    }
}

@C
func maOnClose(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvWinClose>() ?? return
    let app = App.get()

    match {
        case params.origin == GUIClose.Esc =>
            modalWindow(app.window, "Pressed [ESC] key. Press [ESC] again or [RETURN] to exit.")
            OSApp.finish()
        case params.origin == GUIClose.Intro =>
            modalWindow(app.window, "Pressed [RETURN] key. Press [ESC] or [RETURN] again to continue.")
            e.setResult(false) // Cancel close
        case params.origin == GUIClose.Button => OSApp.finish()
        case params.origin == GUIClose.Deact => ()
        case _ => ()
    }
}

@C
func appCreate(): UIntNative {
    GUI.respack(resguihelloResPack)
    GUI.language("")
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
