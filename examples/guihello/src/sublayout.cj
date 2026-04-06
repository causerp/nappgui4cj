package guihello

import nappgui4cj.*

private class SubLayoutData {
    private static var m_data: ?SubLayoutData = None

    var view: TextView = TextView()

    private init() {}

    static func get(recreate!: Bool = false): SubLayoutData {
        if (recreate) {
            m_data = None
        }
        match (m_data) {
            case Some(data) => return data
            case None =>
                let data = SubLayoutData()
                m_data = data
                return data
        }
    }
}

private func updownLayout(): Layout {
    let layout = Layout(2, 1)
    let label = Label()
    let updown = UpDown()

    label.setText("UpDown")

    layout.add(label, 0, 0)
    layout.add(updown, 1, 0)
    layout.hExpand(0)

    return layout
}

private func leftGridLayout(): Layout {
    let layout1 = Layout(2, 4)
    let layout2 = updownLayout()

    let label = Label()
    let button1 = Button(BtnPush)
    let button2 = Button(BtnCheck)
    let slider = Slider(SlHorizontal)
    let popup = PopUp()
    let edit = Edit()
    let progress = Progress()

    label.setText("Hello!, I'm a label.")
    button1.setText("Push Button")
    button2.setText("Check Button")

    popup.addItem("Option 1", None)
    popup.addItem("Option 2", None)
    popup.addItem("Option 3", None)
    popup.addItem("Option 4", None)

    progress.setUndefined(true)

    layout1.add(label, 0, 0)
    layout1.add(button1, 0, 1)
    layout1.add(button2, 0, 2)
    layout1.add(slider, 0, 3)

    layout1.add(popup, 1, 0)
    layout1.add(edit, 1, 1)
    layout1.add(layout2, 1, 2)
    layout1.add(progress, 1, 3)

    layout1.setHSize(0, 150.0)
    layout1.setHSize(1, 150.0)
    layout1.setHMargin(0, 5.0)
    layout1.setVMargin(0, 5.0)
    layout1.setVMargin(1, 5.0)
    layout1.setVMargin(2, 5.0)

    return layout1
}

private func leftLayout(): Layout {
    let layout1 = Layout(1, 2)
    let layout2 = leftGridLayout()
    let button = Button(BtnPush)

    button.setText("Clear")

    layout1.add(layout2, 0, 0)
    layout1.add(button, 0, 1)
    layout1.setVMargin(0, 5.0)

    return layout1
}

private func topLayout(): Layout {
    let layout1 = Layout(3, 1)
    let layout2 = leftLayout()
    let line = Line(LnVertical)
    let data = SubLayoutData.get()

    layout1.add(layout2, 0, 0)
    layout1.add(line, 1, 0)
    layout1.add(data.view, 2, 0)
    layout1.setHSize(2, 230.0)
    layout1.setHMargin(0, 5.0)
    layout1.setHMargin(1, 5.0)
    layout1.setVAlign(2, 0, Align.Justify)

    return layout1
}

@C
func slOnLabelClick(viewPtr: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvMouse>() ?? return
    let view = TextView(viewPtr)
    let label = Label(e.getSenderPtr())
    view.writef("${label.getText()} (${params.x}, ${params.y}) ${params.button.value} ${params.count}\n")
    view.scrollCaret()
}

private func bottomLayout(data: SubLayoutData): Layout {
    let layout = Layout(6, 1)
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()
    let label6 = Label()

    label1.setText("Select 1")
    label2.setText("Select 2")
    label3.setText("Select 3")
    label4.setText("Select 4")
    label5.setText("Select 5")
    label6.setText("Select 6")

    label1.onClick(slOnLabelClick, obj: data.view.handle)
    label2.onClick(slOnLabelClick, obj: data.view.handle)
    label3.onClick(slOnLabelClick, obj: data.view.handle)
    label4.onClick(slOnLabelClick, obj: data.view.handle)
    label5.onClick(slOnLabelClick, obj: data.view.handle)
    label6.onClick(slOnLabelClick, obj: data.view.handle)

    label1.setStyleOver(FStyle.Underline)
    label2.setStyleOver(FStyle.Underline)
    label3.setStyleOver(FStyle.Underline)
    label4.setStyleOver(FStyle.Underline)
    label5.setStyleOver(FStyle.Underline)
    label6.setStyleOver(FStyle.Underline)

    layout.add(label1, 0, 0)
    layout.add(label2, 1, 0)
    layout.add(label3, 2, 0)
    layout.add(label4, 3, 0)
    layout.add(label5, 4, 0)
    layout.add(label6, 5, 0)

    return layout
}

private func mainLayout(data: SubLayoutData): Layout {
    let layout1 = Layout(1, 4)
    let layout2 = topLayout()
    let layout3 = bottomLayout(data)
    let line = Line(LnHorizontal)

    layout1.add(layout2, 0, 0)
    layout1.add(layout3, 0, 2)
    layout1.add(line, 0, 1)

    layout1.setMargin(5.0)
    layout1.setVMargin(0, 5.0)
    layout1.setVMargin(1, 5.0)
    layout1.vExpand(3)

    return layout1
}

func sublayouts(): Panel {
    let panel = Panel()
    let data = SubLayoutData.get(recreate: true)
    let layout = mainLayout(data)
    panel.setLayout(layout)
    return panel
}
