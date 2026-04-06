package guihello

import nappgui4cj.*

private class AppData {
    private static var m_data: ?AppData = None

    var table: TableView
    var text: TextView
    var tempText: CString

    private init() {
        table = TableView()
        text = TextView()
        tempText = CString(CPointer())
    }

    ~init() {
        unsafe {
            if (!tempText.isNull()) {
                LibC.free(tempText)
            }
        }
    }

    func destroy(): Unit {
        unsafe {
            if (!tempText.isNull()) {
                LibC.free(tempText)
            }
        }
    }

    func setTempText(str: String): Unit {
        unsafe {
            if (!tempText.isNull()) {
                LibC.free(tempText)
            }
            tempText = LibC.mallocCString(str)
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
}

@C
func taOnTableData(_: CPointer<Unit>, e: Event): Unit {
    let data = AppData.get()
    let etype = e.getType()

    if (etype == GUIEvent.TblNRows) {
        e.setResult<UInt32>(100)
    } else if (etype == GUIEvent.TblCell) {
        let pos = e.getParams<EvTbPos>() ?? return
        var cell = EvTbCell()
        var cellText: String = ""

        cell.align = Align.Left

        match (pos.col) {
            case 0 =>
                cell.align = Align.Left
                cellText = "Name ${pos.row}"
            case 1 =>
                cell.align = Align.Left
                if (pos.row % 3 == 0) {
                    cell.icon = GUI.getImage(ERROR16_PNG) ?? cell.icon
                } else if (pos.row % 3 == 1) {
                    cell.icon = GUI.getImage(EDIT16_PNG) ?? cell.icon
                } else {
                    cell.icon = GUI.getImage(DISK16_PNG) ?? cell.icon
                }
                cellText = "Address ${pos.row}"
            case 2 =>
                cell.align = Align.Left
                cellText = "City ${pos.row}"
            case 3 =>
                cell.align = Align.Right
                cellText = "${pos.row}"
            case 4 =>
                cell.align = Align.Right
                cellText = "${10.5 + Float32(pos.row)}"
            case 5 =>
                cell.align = Align.Center
                cellText = "Extra Data 1 ${pos.row}"
            case 6 =>
                cell.align = Align.Center
                cellText = "Extra Data 2 ${pos.row}"
            case 7 =>
                cell.align = Align.Center
                cellText = "Extra Data 3 ${pos.row}"
            case 8 =>
                cell.align = Align.Center
                cellText = "Extra Data 4 ${pos.row}"
            case _ => ()
        }

        data.setTempText(cellText)
        cell.text = data.tempText
        e.setResult(cell)
    }
}

@C
func taOnHeaderClick(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    data.text.writef("Click on Header: ${params.index}\n")
    data.text.scrollCaret()
}

@C
func taOnMultisel(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()

    if (params.index == 0) {
        data.table.multisel(false, false)
    } else if (params.index == 1) {
        data.table.multisel(true, false)
    } else if (params.index == 2) {
        data.table.multisel(true, true)
    }
}

@C
func taOnResizeCheck(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    let resizable = params.state == GUIState.On
    data.table.headerResizable(resizable)
}

@C
func taOnHeaderCheck(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    let clickable = params.state == GUIState.On
    data.table.headerClickable(clickable)
}

@C
func taOnFreezeCheck(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    let colFreeze = match (params.state == GUIState.On) {
        case true => 1u32
        case false => UInt32.Max
    }
    data.table.columnFreeze(colFreeze)
}

@C
func taOnGridCheck(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let data = AppData.get()
    let grid = params.state == GUIState.On
    data.table.grid(grid, grid)
}

@C
func taOnPrintsel(_: CPointer<Unit>, _: Event): Unit {
    let data = AppData.get()
    let sel = data.table.selected().toArray()
    let n = sel.size
    data.text.writef("Selected rows: ")
    for (i in 0..n) {
        data.text.writef("${sel[i]}")
        if (i < n - 1) {
            data.text.writef(", ")
        }
    }
    data.text.writef("\n")
}

private func tableControlLayout(): Layout {
    let layout1 = Layout(3, 1)
    let layout2 = Layout(1, 6)

    let button1 = Button(BtnRadio)
    let button2 = Button(BtnRadio)
    let button3 = Button(BtnRadio)
    let button4 = Button(BtnCheck)
    let button5 = Button(BtnCheck)
    let button6 = Button(BtnCheck)
    let button7 = Button(BtnCheck)
    let button8 = Button(BtnPush)

    button1.setText("Single select")
    button2.setText("Multi select")
    button3.setText("Preserve select")
    button4.setText("Resizable headers")
    button5.setText("Clickable headers")
    button6.setText("Freeze 0 and 1 columns")
    button7.setText("Draw grid lines")
    button8.setText("Print selected rows")

    button1.setState(GUIState.On)
    button4.setState(GUIState.On)
    button5.setState(GUIState.On)
    button6.setState(GUIState.On)
    button7.setState(GUIState.On)

    layout1.add(button1, 0, 0)
    layout1.add(button2, 1, 0)
    layout1.add(button3, 2, 0)

    layout2.add(layout1, 0, 0)
    layout2.add(button4, 0, 1)
    layout2.add(button5, 0, 2)
    layout2.add(button6, 0, 3)
    layout2.add(button7, 0, 4)
    layout2.add(button8, 0, 5)

    layout1.setHMargin(0, 5.0)
    layout1.setHMargin(1, 5.0)

    layout2.setVMargin(0, 5.0)
    layout2.setVMargin(1, 5.0)
    layout2.setVMargin(2, 5.0)
    layout2.setVMargin(3, 5.0)
    layout2.setVMargin(4, 5.0)

    layout2.setHAlign(0, 0, Align.Left)
    layout2.setHAlign(0, 5, Align.Left)

    button1.onClick(taOnMultisel)
    button2.onClick(taOnMultisel)
    button3.onClick(taOnMultisel)
    button4.onClick(taOnResizeCheck)
    button5.onClick(taOnHeaderCheck)
    button6.onClick(taOnFreezeCheck)
    button7.onClick(taOnGridCheck)
    button8.onClick(taOnPrintsel)

    return layout2
}

func tableView(): Panel {
    let panel = Panel()
    let data = AppData.get(recreate: true)

    let layout1 = Layout(1, 3)
    let layout2 = tableControlLayout()

    data.table.setSize(S2Df(500.0, 300.0))
    data.table.onData(taOnTableData)
    data.table.onHeaderClick(taOnHeaderClick)

    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()
    data.table.addColumnText()

    data.table.headerClickable(true)
    data.table.headerResizable(true)

    data.table.headerIndicator(1, Indicator.DownArrow)
    data.table.headerIndicator(2, Indicator.UpArrow)

    data.table.headerTitle(0, "Name")
    data.table.headerTitle(1, "Address")
    data.table.columnIcon(1, 16.0, 5.0)
    data.table.headerTitle(2, "City")
    data.table.headerTitle(3, "Age")
    data.table.headerTitle(4, "Value")
    data.table.headerTitle(5, "Extra\nData 1")
    data.table.headerTitle(6, "Extra\nData 2")
    data.table.headerTitle(7, "Extra\nData 3")
    data.table.headerTitle(8, "Extra\nData 4")

    data.table.columnWidth(0, 100.0)
    data.table.columnWidth(1, 105.0)
    data.table.columnWidth(2, 50.0)
    data.table.columnWidth(3, 50.0)
    data.table.columnWidth(4, 170.0)
    data.table.columnWidth(5, 200.0)
    data.table.columnWidth(6, 200.0)
    data.table.columnWidth(7, 200.0)
    data.table.columnWidth(8, 200.0)

    data.table.columnLimits(2, 50.0, 100.0)
    data.table.columnFreeze(1)

    data.table.headerAlign(0, Align.Left)
    data.table.headerAlign(1, Align.Left)
    data.table.headerAlign(2, Align.Left)
    data.table.headerAlign(3, Align.Right)
    data.table.headerAlign(4, Align.Right)
    data.table.headerAlign(5, Align.Center)
    data.table.headerAlign(6, Align.Center)
    data.table.headerAlign(7, Align.Center)
    data.table.headerAlign(8, Align.Center)

    data.table.multisel(false, false)
    data.table.headerVisible(true)
    data.table.grid(true, true)
    data.table.update()

    data.table.select(20)
    data.table.focusRow(20, Align.Bottom)

    layout1.add(layout2, 0, 0)
    layout1.add(data.table, 0, 1)
    layout1.add(data.text, 0, 2)

    layout1.setVMargin(0, 5.0)
    layout1.setVMargin(1, 5.0)

    panel.setLayout(layout1)
    return panel
}
