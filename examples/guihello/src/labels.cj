package guihello

import nappgui4cj.*

private const LABEL_01: String = "Hello."
private const LABEL_02: String = "Hello, I'm a Label."
private const LABEL_03: String = "Hello, I'm a Label, longer than first."
private const LABEL_04: String = "Hello, I'm a Label, longer than first and longer than second."
private const LABEL_05: String = "Hello, I'm a Label, longer than first, longer than second and longer than third."
private const LABEL_06: String = "Hello, I'm a Label, longer than first, longer than second, longer than third and longer than fourth."
private const LABEL_07: String = "Mouse sensitive label"

@C
func laOnLayoutWidth(layoutPtr: CPointer<Unit>, e: Event): Unit {
    let layout = Layout(layoutPtr)
    let params = e.getParams<EvButton>()
    var width: Float32 = 0.0

    match (params?.index ?? 0) {
        case 1 => width = 100.0
        case 2 => width = 200.0
        case 3 => width = 300.0
        case 4 => width = 400.0
        case _ => width = 0.0
    }

    layout.setHSize(0, width)
    layout.update()
}

private func createWidthPopup(layout: Layout): PopUp {
    let popup = PopUp()
    popup.addItem("Natural")
    popup.addItem("100px")
    popup.addItem("200px")
    popup.addItem("300px")
    popup.addItem("400px")

    popup.onSelect(laOnLayoutWidth, obj: layout.handle)
    return popup
}

private func createLabels(multiline: Bool): Panel {
    let panel = Panel()
    let layout = Layout(1, 7)
    let popup = createWidthPopup(layout)

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()
    let label6 = Label()

    let c1 = GUI.altColor(Color(192, 255, 255), Color(48, 112, 112))
    let c2 = GUI.altColor(Color(255, 192, 255), Color(128, 48, 112))
    let c3 = GUI.altColor(Color(255, 255, 192), Color(112, 112, 48))

    label1.setMultiline(multiline)
    label2.setMultiline(multiline)
    label3.setMultiline(multiline)
    label4.setMultiline(multiline)
    label5.setMultiline(multiline)
    label6.setMultiline(multiline)

    label1.setText(LABEL_01)
    label2.setText(LABEL_02)
    label3.setText(LABEL_03)
    label4.setText(LABEL_04)
    label5.setText(LABEL_05)
    label6.setText(LABEL_06)

    label5.setAlign(Align.Center)
    label6.setAlign(Align.Right)

    label4.setTrim(Ellipsis.End)
    label5.setTrim(Ellipsis.Middle)
    label6.setTrim(Ellipsis.Begin)

    label1.setBgColor(c1)
    label2.setBgColor(c2)
    label3.setBgColor(c3)
    label4.setBgColor(c1)
    label5.setBgColor(c2)
    label6.setBgColor(c3)

    layout.add(popup, 0, 0)
    layout.add(label1, 0, 1)
    layout.add(label2, 0, 2)
    layout.add(label3, 0, 3)
    layout.add(label4, 0, 4)
    layout.add(label5, 0, 5)
    layout.add(label6, 0, 6)

    layout.setVMargin(0, 5.0)
    panel.setLayout(layout)
    return panel
}

func labelsSingleLine(): Panel {
    return createLabels(false)
}

func labelsMultiLine(): Panel {
    return createLabels(true)
}

func labelsMouseOver(): Panel {
    let panel = Panel()
    let layout = Layout(1, 5)
    var font = Font(FntSystem, 20.0, FStyle.Normal | FStyle.Pixels)

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()

    label1.setText(LABEL_07)
    label2.setText(LABEL_07)
    label3.setText(LABEL_07)
    label4.setText(LABEL_07)
    label5.setText(LABEL_07)

    label1.setFont(font)
    label2.setFont(font)
    label3.setFont(font)
    label4.setFont(font)
    label5.setFont(font)

    label1.setColorOver(Color.RED)
    label2.setColorOver(Color.RED)
    label3.setColorOver(Color.RED)
    label4.setColorOver(Color.RED)
    label5.setColorOver(Color.RED)

    label1.setStyleOver(FStyle.Bold)
    label2.setStyleOver(FStyle.Italic)
    label3.setStyleOver(FStyle.Strikeout)
    label4.setStyleOver(FStyle.Underline)
    label5.setBgColorOver(Color.CYAN)

    layout.add(label1, 0, 0)
    layout.add(label2, 0, 1)
    layout.add(label3, 0, 2)
    layout.add(label4, 0, 3)
    layout.add(label5, 0, 4)

    panel.setLayout(layout)
    font.destroy()

    return panel
}
