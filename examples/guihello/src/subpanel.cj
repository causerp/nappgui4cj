package guihello

import nappgui4cj.*

func subpanels(): Panel {
    let panel1 = Panel()
    let panel2 = Panel()
    let layout1 = Layout(2, 2)
    let layout2 = Layout(2, 2)
    let label1 = Label()
    let label2 = Label()
    let button = Button(BtnPush)
    let slider = Slider(SlHorizontal)
    let edit = Edit()

    label1.setText("Main Panel")
    label2.setText("Subpanel")
    button.setText("Push Button")
    edit.setText("EditBox")

    layout2.add(label2, 0, 0)
    layout2.add(button, 0, 1)
    layout2.add(slider, 1, 1)

    layout2.setHSize(1, 150.0)
    layout2.setHMargin(0, 10.0)
    layout2.setVMargin(0, 10.0)
    layout2.setMargin(5.0, 10.0, 10.0, 10.0)
    layout2.setSkColor(GUI.lineColor())

    panel2.setLayout(layout2)

    layout1.add(label1, 0, 0)
    layout1.add(edit, 1, 1)
    layout1.add(panel2, 0, 1)

    layout1.setHSize(1, 100.0)
    layout1.setHMargin(0, 10.0)
    layout1.setVMargin(0, 10.0)
    layout1.setMargin(5.0, 10.0, 10.0, 10.0)

    panel1.setLayout(layout1)

    return panel1
}
