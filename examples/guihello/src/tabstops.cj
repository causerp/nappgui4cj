package guihello

import nappgui4cj.*

private class AppData {
    private static var m_data: ?AppData = None

    var buttons: Array<Button> = Array<Button>(2, repeat: Button(CPointer()))
    var popups: Array<PopUp> = Array<PopUp>(2, repeat: PopUp(CPointer()))
    var updowns: Array<UpDown> = Array<UpDown>(2, repeat: UpDown(CPointer()))
    var views: Array<View> = Array<View>(2, repeat: View(CPointer()))
    var texts: Array<TextView> = Array<TextView>(2, repeat: TextView(CPointer()))
    var focus: Array<Bool> = Array<Bool>(2, repeat: false)
    var tempString: CString = CString(CPointer())

    private init() {
        tempString = CString(CPointer())
    }

    func destroy(): Unit {
        unsafe {
            if (!tempString.isNull()) {
                LibC.free(tempString)
            }
        }
    }

    static func get(recreate!: Bool = false): AppData {
        if (recreate) {
            m_data?.destroy()
            m_data = None
        }
        match (m_data) {
            case Some(data) => return data
            case None =>
                let data = AppData()
                m_data = data
                return data
        }
    }

    func setTempText(str: String): Unit {
        unsafe {
            if (!tempString.isNull()) {
                LibC.free(tempString)
            }
            tempString = LibC.mallocCString(str)
        }
    }
}

@C
func tsOnDraw(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvDraw>() ?? return
    let data = AppData.get()
    let viewPtr = e.getSenderPtr<Unit>()
    var focused: Bool = false
    if (viewPtr.toUIntNative() == data.views[0].handle.toUIntNative()) {
        focused = data.focus[0]
    } else {
        focused = data.focus[1]
    }
    let color = match (focused) {
        case true => Color.RED
        case false => Color.CYAN
    }
    params.ctx.clear(color)
}

@C
func tsOnFocus(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<Bool>() ?? return
    let data = AppData.get()
    let view = View(e.getSenderPtr())
    view.update()
    if (view.handle.toUIntNative() == data.views[0].handle.toUIntNative()) {
        data.focus[0] = params
    } else {
        data.focus[1] = params
    }
}

@C
func tsOnClick(_: CPointer<Unit>, e: Event): Unit {
    let data = AppData.get()
    let buttonPtr = e.getSenderPtr<Unit>()
    var text: ?TextView = None
    if (buttonPtr.toUIntNative() == data.buttons[0].handle.toUIntNative()) {
        text = data.texts[0]
    } else {
        text = data.texts[1]
    }
    text?.writef("Button click\n")
}

@C
func tsOnSelect(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    let popupPtr = e.getSenderPtr<Unit>()
    var text: ?TextView = None
    if (popupPtr.toUIntNative() == data.popups[0].handle.toUIntNative()) {
        text = data.texts[0]
    } else {
        text = data.texts[1]
    }
    text?.writef("PopUp select ${params.index}\n")
}

@C
func tsOnChange(_: CPointer<Unit>, e: Event): Unit {
    if (let Some(params) <- e.getParams<EvText>()) {
        e.setResult<Bool>(params.text.toString() == "VALID_TEXT")
    }
}

@C
func tsOnUpDown(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    let updownPtr = e.getSenderPtr<Unit>()
    var text: ?TextView = None
    if (updownPtr.toUIntNative() == data.updowns[0].handle.toUIntNative()) {
        text = data.texts[0]
    } else {
        text = data.texts[1]
    }
    text?.writef("UpDown ${params.index}\n")
}

@C
func tsOnTableData(_: CPointer<Unit>, e: Event): Unit {
    let data = AppData.get()
    let etype = e.getType()
    if (etype == GUIEvent.TblNRows) {
        e.setResult<UInt32>(10)
    } else if (etype == GUIEvent.TblCell) {
        let pos = e.getParams<EvTbPos>() ?? return
        var cell = EvTbCell()
        cell.align = Align.Left
        let cellText = match (pos.col) {
            case 0 => "Data (0, ${pos.row})"
            case 1 => "Data (1, ${pos.row})"
            case _ => String.empty
        }
        data.setTempText(cellText)
        cell.text = data.tempString
        e.setResult(cell)
    }
}

private func createLayout(index: Int64): Layout {
    let data = AppData.get()

    let layout1 = Layout(6, 1)
    let layout2 = Layout(4, 1)
    let mainLayout = Layout(1, 2)

    let button = Button(BtnPush)
    let popup = PopUp()
    let edit = Edit()
    let combo = Combo()
    let list = ListBox()
    let slider = Slider(SlHorizontal)
    let updown = UpDown()
    let view = View(ViCustom(false, true))
    let text = TextView()
    let table = TableView()

    button.setText("This is a button")
    button.onClick(tsOnClick)

    popup.addItem("Option 1")
    popup.addItem("Option 2")
    popup.onSelect(tsOnSelect)

    edit.setText("VALID_TEXT")
    edit.onChange(tsOnChange)

    combo.setText("ComboBox")

    updown.onClick(tsOnUpDown)

    view.onDraw(tsOnDraw)
    view.onFocus(tsOnFocus)

    text.writef("Hello text!\n")

    list.addItem("Elem 1")
    list.addItem("Elem 2")

    table.addColumnText()
    table.addColumnText()
    table.columnWidth(0, 100.0)
    table.headerTitle(0, "Column 0")
    table.columnWidth(1, 100.0)
    table.headerTitle(1, "Column 1")
    table.onData(tsOnTableData)
    table.update()

    data.buttons[index] = button
    data.popups[index] = popup
    data.texts[index] = text
    data.views[index] = view
    data.updowns[index] = updown

    // Layout 1 (Row 0)
    layout1.add(button, 0, 0)
    layout1.add(popup, 1, 0)
    layout1.add(edit, 2, 0)
    layout1.add(combo, 3, 0)
    layout1.add(slider, 4, 0)
    layout1.add(updown, 5, 0)

    // Layout 2 (Row 1)
    layout2.add(view, 0, 0)
    layout2.add(text, 1, 0)
    layout2.add(list, 2, 0)
    layout2.add(table, 3, 0)

    // If index == 0, controls are in TabList (true). If index == 1, they are not (false).
    let inTabList = (index == 0)

    layout1.setTabStop(0, 0, inTabList) // Button
    layout1.setTabStop(1, 0, inTabList) // PopUp
    layout1.setTabStop(2, 0, inTabList) // Edit
    layout1.setTabStop(3, 0, inTabList) // Combo
    layout1.setTabStop(4, 0, inTabList) // Slider
    layout1.setTabStop(5, 0, false) // UpDown

    layout2.setTabStop(0, 0, inTabList) // View
    layout2.setTabStop(1, 0, inTabList) // TextView
    layout2.setTabStop(2, 0, inTabList) // ListView
    layout2.setTabStop(3, 0, inTabList) // TableView

    layout1.setHMargin(0, 10.0)
    layout1.setHMargin(1, 10.0)
    layout1.setHMargin(2, 10.0)
    layout1.setHMargin(3, 10.0)
    layout1.setHMargin(4, 10.0)

    layout2.setHMargin(0, 10.0)
    layout2.setHMargin(1, 10.0)
    layout2.setHMargin(2, 10.0)

    mainLayout.setVMargin(0, 10.0)

    mainLayout.add(layout1, 0, 0)
    mainLayout.add(layout2, 0, 1)

    mainLayout.setHAlign(0, 0, Align.Left)
    mainLayout.setHAlign(0, 1, Align.Left)

    return mainLayout
}

func tabstops(): Panel {
    let panel = Panel()
    let _ = AppData.get(recreate: true)

    let layout = Layout(1, 4)

    let layout1 = createLayout(0)
    let layout2 = createLayout(1)

    let label1 = Label()
    let label2 = Label()

    label1.setText("Controls in the TabList")
    label2.setText("Controls NOT in the TabList")

    layout.add(label1, 0, 0)
    layout.add(layout1, 0, 1)
    layout.add(label2, 0, 2)
    layout.add(layout2, 0, 3)

    layout.setVMargin(0, 10.0)
    layout.setVMargin(1, 10.0)
    layout.setVMargin(2, 10.0)

    panel.setLayout(layout)
    return panel
}
