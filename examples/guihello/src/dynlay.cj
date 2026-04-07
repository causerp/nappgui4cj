package guihello

import nappgui4cj.*
import std.random.Random

private let rand = Random()

private class AppData {
    private static var m_data: ?AppData = None

    var topLayout: Layout
    var bottomLayout: Layout
    var hmargin: UInt32 = 5
    var vmargin: UInt32 = 0
    var bgcolor: Array<Color>
    var skcolor: Array<Color>

    private init() {
        topLayout = Layout(5, 3)
        bottomLayout = Layout(1, 3)

        bgcolor = [
            GUI.altColor(Color(255, 232, 232), Color(128, 0, 0)),
            GUI.altColor(Color(232, 255, 232), Color(0, 128, 0)),
            GUI.altColor(Color(232, 232, 255), Color(0, 0, 128))
        ]

        skcolor = [
            GUI.altColor(Color(255, 85, 0), Color(255, 0, 0)),
            GUI.altColor(Color(5, 163, 0), Color(0, 255, 0)),
            GUI.altColor(Color(109, 0, 163), Color(0, 0, 255))
        ]
    }

    static func get(recreate!: Bool = false): AppData {
        if (recreate) {
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
}

private func topLayoutMargins(): Unit {
    let app = AppData.get()
    let ncols = app.topLayout.numCols()
    let nrows = app.topLayout.numRows()

    if (ncols > 2) {
        for (i in 0..ncols - 2) {
            app.topLayout.setHMargin(i, Float32(app.hmargin))
        }
    }

    if (nrows > 1) {
        for (i in 0..nrows - 1) {
            app.topLayout.setVMargin(i, Float32(app.vmargin))
        }
    }
}

private func bottomLayoutMargins(): Unit {
    let app = AppData.get()
    let nrows = app.bottomLayout.numRows()

    if (nrows > 1) {
        for (i in 0..nrows - 1) {
            app.bottomLayout.setVMargin(i, 5.0)
        }
    }
}

@C
private func onVMargin(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let app = AppData.get()
    if (params.index == 1 && app.vmargin > 0) {
        app.vmargin -= 1
    } else if (params.index == 0) {
        app.vmargin += 1
    }
    topLayoutMargins()
    app.topLayout.update()
}

@C
private func onHMargin(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let app = AppData.get()
    if (params.index == 1 && app.hmargin > 0) {
        app.hmargin -= 1
    } else if (params.index == 0) {
        app.hmargin += 1
    }
    topLayoutMargins()
    app.topLayout.update()
}

private func controlLayout1(): Layout {
    let layout = Layout(5, 1)
    let label1 = Label()
    let label2 = Label()
    let updown1 = UpDown()
    let updown2 = UpDown()

    label1.setText("V-Margin:")
    label2.setText("H-Margin:")

    updown1.onClick(onVMargin)
    updown2.onClick(onHMargin)

    layout.add(label1, 0, 0)
    layout.add(updown1, 1, 0)
    layout.add(label2, 2, 0)
    layout.add(updown2, 3, 0)

    layout.setHMargin(0, 5.0)
    layout.setHMargin(1, 5.0)
    layout.setHMargin(2, 5.0)

    layout.setHAlign(1, 0, Align.Left)
    layout.setHAlign(3, 0, Align.Left)

    layout.hExpand(4)

    return layout
}

@C
private func onSlider(_: CPointer<Unit>, e: Event): Unit {
    let app = AppData.get()
    let slider = Slider(e.getSenderPtr())
    let tag = slider.getTag()
    let col = tag & 0x0000FFFF
    let row = (tag & 0xFFFF0000) >> 16
    let ncols = app.topLayout.numCols()

    if (ncols > col + 1) {
        let params = e.getParams<EvSlider>() ?? return
        let progress = app.topLayout.getProgress(col + 1, row) ?? return ()
        progress.setValue(params.pos)
    }
}

private func fillCell(layout: Layout, col: UInt32, row: UInt32): Unit {
    match (col % 5) {
        case 0 =>
            let label = Label()
            label.setText("Label (${col}, ${row})")
            layout.add(label, col, row)
        case 1 =>
            let button = Button(BtnPush)
            button.setText("Button (${col}, ${row})")
            layout.add(button, col, row)
        case 2 =>
            let slider = Slider(SlHorizontal)
            let pos = rand.nextFloat32()
            let tag = (row << 16) | col
            slider.setValue(pos)
            slider.onMoved(onSlider)
            slider.setTag(tag)
            layout.add(slider, col, row)
        case 3 =>
            let slider = layout.getSlider(col - 1, row) ?? return
            let pos = slider.getValue()
            let progress = Progress()
            progress.setValue(pos)
            layout.add(progress, col, row)
        case 4 =>
            let popup = PopUp()
            for (i in 0..5) {
                popup.addItem("Item (${col}, ${row}) - ${i}")
            }
            layout.add(popup, col, row)
        case _ => ()
    }
}

private func fillRow(layout: Layout, row: UInt32): Unit {
    let cols = layout.numCols()
    for (i in 0..cols - 1) {
        fillCell(layout, i, row)
    }
}

private func fillCol(layout: Layout, col: UInt32): Unit {
    let rows = layout.numRows()
    for (i in 0..rows) {
        fillCell(layout, col, i)
    }
}

private func getImage(row: UInt32): ?Image {
    match (row % 6) {
        case 0 => return GUI.getImage(FOLDER64_PNG)
        case 1 => return GUI.getImage(DISK64_PNG)
        case 2 => return GUI.getImage(SEARCH64_PNG)
        case 3 => return GUI.getImage(EDIT64_PNG)
        case 4 => return GUI.getImage(PLUS64_PNG)
        case 5 => return GUI.getImage(ERROR64_PNG)
        case _ => return GUI.getImage(FOLDER64_PNG)
    }
}

private func getTitleText(row: UInt32): String {
    match (row % 6) {
        case 0 => return "Title: Folder"
        case 1 => return "Title: Disk"
        case 2 => return "Title: Search"
        case 3 => return "Title: Edit"
        case 4 => return "Title: Plus"
        case 5 => return "Title: Error"
        case _ => return ""
    }
}

private func getDescText(row: UInt32): String {
    match (row % 6) {
        case 0 => return "Desc: This is a folder icon"
        case 1 => return "Desc: This is a disk icon"
        case 2 => return "Desc: This is a search icon"
        case 3 => return "Desc: This is a edit icon"
        case 4 => return "Desc: This is a plus icon"
        case 5 => return "Desc: This is a error icon"
        case _ => return ""
    }
}

private func getPriceText(row: UInt32): String {
    match (row % 6) {
        case 0 => return "Price: 45.12€"
        case 1 => return "Price: 12.34€"
        case 2 => return "Price: 66.19€"
        case 3 => return "Price: 22.65€"
        case 4 => return "Price: 99.99€"
        case 5 => return "Price: 32.56€"
        case _ => return ""
    }
}

private func getStockText(row: UInt32): String {
    match (row % 6) {
        case 0 => return "Stock: 25"
        case 1 => return "Stock: 18"
        case 2 => return "Stock: 10"
        case 3 => return "Stock: 22"
        case 4 => return "Stock:  7"
        case 5 => return "Stock:  0"
        case _ => return ""
    }
}

private func fillSublayout(layout: Layout, row: UInt32): Unit {
    let app = AppData.get()
    let layout1 = Layout(3, 1)
    let layout2 = Layout(1, 4)
    let view = ImageView()
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()

    if (let Some(image) <- getImage(row)) {
        view.setImage(image)
    }
    layout1.add(view, 0, 0)

    label1.setText(getTitleText(row))
    label2.setText(getDescText(row))
    label3.setText(getPriceText(row))
    label4.setText(getStockText(row))

    layout2.add(label1, 0, 0)
    layout2.add(label2, 0, 1)
    layout2.add(label3, 0, 2)
    layout2.add(label4, 0, 3)

    layout1.add(layout2, 1, 0)

    layout1.setVAlign(0, 0, Align.Top)
    layout1.setVAlign(1, 0, Align.Top)
    layout1.setHMargin(0, 10.0)
    layout1.hExpand(2)
    layout1.setMargin(10.0)

    layout1.setBgColor(app.bgcolor[Int64(row) % 3])
    layout1.setSkColor(app.skcolor[Int64(row) % 3])

    layout.add(layout1, 0, row)
}

@C
private func onTopAddCol(_: CPointer<Unit>, _: Event): Unit {
    let app = AppData.get()
    let ncols = app.topLayout.numCols()

    app.topLayout.insertCol(ncols - 1)
    fillCol(app.topLayout, ncols - 1)
    topLayoutMargins()
    app.topLayout.update()
}

@C
private func onTopDelCol(_: CPointer<Unit>, _: Event): Unit {
    let app = AppData.get()
    let ncols = app.topLayout.numCols()

    if (ncols > 3) {
        app.topLayout.removeCol(ncols - 2)
        topLayoutMargins()
        app.topLayout.update()
    }
}

@C
private func onTopAddRow(_: CPointer<Unit>, _: Event): Unit {
    let app = AppData.get()
    let nrows = app.topLayout.numRows()

    app.topLayout.insertRow(nrows)
    fillRow(app.topLayout, nrows)
    topLayoutMargins()
    app.topLayout.update()
}

@C
private func onTopDelRow(_: CPointer<Unit>, _: Event): Unit {
    let app = AppData.get()
    let nrows = app.topLayout.numRows()

    if (nrows > 2) {
        app.topLayout.removeRow(nrows - 1)
        topLayoutMargins()
        app.topLayout.update()
    }
}

@C
private func onTopAddLayout(_: CPointer<Unit>, _: Event): Unit {
    let app = AppData.get()
    let nrows = app.bottomLayout.numRows()

    app.bottomLayout.insertRow(nrows)
    fillSublayout(app.bottomLayout, nrows)
    bottomLayoutMargins()
    app.bottomLayout.update()
}

@C
private func onTopDelLayout(_: CPointer<Unit>, _: Event): Unit {
    let app = AppData.get()
    let nrows = app.bottomLayout.numRows()

    if (nrows > 1) {
        app.bottomLayout.removeRow(nrows - 1)
        bottomLayoutMargins()
        app.bottomLayout.update()
    }
}

private func controlLayout2(): Layout {
    let layout = Layout(7, 1)
    let label1 = Label()
    let label2 = Label()
    let button1 = Button(BtnPush)
    let button2 = Button(BtnPush)
    let button3 = Button(BtnPush)
    let button4 = Button(BtnPush)

    label1.setText("Top columns")
    label2.setText("Top rows")
    button1.setText("Add")
    button2.setText("Remove")
    button3.setText("Add")
    button4.setText("Remove")

    button1.onClick(onTopAddCol)
    button2.onClick(onTopDelCol)
    button3.onClick(onTopAddRow)
    button4.onClick(onTopDelRow)

    layout.add(label1, 0, 0)
    layout.add(button1, 1, 0)
    layout.add(button2, 2, 0)
    layout.add(label2, 3, 0)
    layout.add(button3, 4, 0)
    layout.add(button4, 5, 0)

    layout.setHMargin(0, 5.0)
    layout.setHMargin(1, 5.0)
    layout.setHMargin(2, 5.0)
    layout.setHMargin(3, 5.0)
    layout.setHMargin(4, 5.0)

    layout.setHAlign(1, 0, Align.Left)
    layout.setHAlign(2, 0, Align.Left)
    layout.setHAlign(4, 0, Align.Left)
    layout.setHAlign(5, 0, Align.Left)

    layout.hExpand(6)

    return layout
}

private func controlLayout3(): Layout {
    let layout = Layout(4, 1)
    let label = Label()
    let button1 = Button(BtnPush)
    let button2 = Button(BtnPush)

    label.setText("Bottom sublayouts")
    button1.setText("Add")
    button2.setText("Remove")

    button1.onClick(onTopAddLayout)
    button2.onClick(onTopDelLayout)

    layout.add(label, 0, 0)
    layout.add(button1, 1, 0)
    layout.add(button2, 2, 0)

    layout.setHMargin(0, 5.0)
    layout.setHMargin(1, 5.0)

    layout.setHAlign(1, 0, Align.Left)
    layout.setHAlign(2, 0, Align.Left)

    layout.hExpand(3)

    return layout
}

private func controlLayout(): Layout {
    let layout = Layout(1, 3)
    let layout1 = controlLayout1()
    let layout2 = controlLayout2()
    let layout3 = controlLayout3()

    layout.add(layout1, 0, 0)
    layout.add(layout2, 0, 1)
    layout.add(layout3, 0, 2)

    layout.setVMargin(0, 3.0)
    layout.setVMargin(1, 3.0)

    return layout
}

private func buildTopLayout(): Layout {
    let app = AppData.get()
    fillRow(app.topLayout, 0)
    fillRow(app.topLayout, 1)
    fillRow(app.topLayout, 2)
    app.topLayout.hExpand(4)
    return app.topLayout
}

private func buildBottomLayout(): Layout {
    let app = AppData.get()
    fillSublayout(app.bottomLayout, 0)
    fillSublayout(app.bottomLayout, 1)
    fillSublayout(app.bottomLayout, 2)
    return app.bottomLayout
}

/*
 * Dynamic layouts example
 *
 * The main layout is a stack with three rows:
 * Control Layout: Buttons to add/remove dynamic layouts cells
 * Top Layout: Grid layout with simple widgets where we can add/remove columns/rows dynamically
 * Bottom Layout: A stack where we can add/remove complex sublayouts dynamically
 *
 * Main layout lives in a scroll panel with fixed size.
 * When main layout grows, scrollbars will be activated to browse all the content.
 *
 */
func dynlayPanel(): Panel {
    let _ = AppData.get(recreate: true)
    let panel = Panel(hscroll: true, vscroll: true)
    let layout = Layout(1, 4)
    let controlLayoutVal = controlLayout()
    let topLayoutVal = buildTopLayout()
    let bottomLayoutVal = buildBottomLayout()

    /* Main layout composition */
    layout.add(controlLayoutVal, 0, 0)
    layout.add(topLayoutVal, 0, 1)
    layout.add(bottomLayoutVal, 0, 2)

    /* Grid layout dynamic margins */
    topLayoutMargins()

    /* Articles layout margins */
    bottomLayoutMargins()

    /* Static vertical separation between three layouts */
    layout.setVMargin(0, 10.0)
    layout.setVMargin(1, 10.0)

    /*
     * The main layout vertical expansion is delegated to a fourth empty cell.
     * This prevents excess pixels from being distributed across all rows,
     * keeping the top three rows together.
     */
    layout.vExpand(3)

    /*
     * Main container fixed size
     * Scrollbars will be activated when layouts grow
     */
    panel.setSize(S2Df(400.0, 500.0))

    /* Panel-Layout binding */
    panel.setLayout(layout)

    return panel
}
