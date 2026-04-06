package guihello

import nappgui4cj.*

private func vpaddingLayout(): Layout {
    let button1 = Button(BtnPush)
    let button2 = Button(BtnPush)
    let button3 = Button(BtnPush)

    button1.setText("Button with default padding")
    button2.setText("Button with zero padding")
    button3.setText("Button with high padding")

    var font = Font(FntSystem, 20.0, FStyle.Normal)
    button2.setFont(font)
    font.destroy()

    button1.setImage(GUI.getImage(FOLDER24_PNG))
    button2.setImage(GUI.getImage(FOLDER24_PNG))
    button3.setImage(GUI.getImage(FOLDER24_PNG))

    button2.setVPadding(0.0)
    button3.setVPadding(30.0)

    let layout = Layout(1, 3)

    layout.add(button1, 0, 0)
    layout.add(button2, 0, 1)
    layout.add(button3, 0, 2)

    layout.setVMargin(0, 5.0)
    layout.setVMargin(1, 5.0)

    return layout
}

/*---------------------------------------------------------------------------*/

private func hpaddingLayout(): Layout {
    let button1 = Button(BtnPush)
    let button2 = Button(BtnPush)
    let button3 = Button(BtnPush)
    let button4 = Button(BtnPush)
    let button5 = Button(BtnPush)

    button1.setText("Default padding")
    button2.setText("Zero padding")
    button3.setText("High padding")
    button4.setText("Min Width")
    button5.setText("Expand")

    button2.setHPadding(0.0)
    button3.setHPadding(50.0)
    button4.setWidth(150.0)

    let layout = Layout(1, 5)

    layout.add(button1, 0, 0)
    layout.add(button2, 0, 1)
    layout.add(button3, 0, 2)
    layout.add(button4, 0, 3)
    layout.add(button5, 0, 4)

    layout.setHSize(0, 300.0)
    layout.setHAlign(0, 0, Align.Left)
    layout.setHAlign(0, 1, Align.Left)
    layout.setHAlign(0, 2, Align.Left)
    layout.setHAlign(0, 3, Align.Left)

    return layout
}

/*---------------------------------------------------------------------------*/

private func flatpaddingLayout(): Layout {
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()

    label1.setText("Default padding")
    label2.setText("Zero padding")
    label3.setText("High padding")

    let button1 = Button(BtnFlatgle)
    let button2 = Button(BtnFlatgle)
    let button3 = Button(BtnFlatgle)

    button1.setImage(GUI.getImage(FOLDER24_PNG))
    button2.setImage(GUI.getImage(FOLDER24_PNG))
    button3.setImage(GUI.getImage(FOLDER24_PNG))

    button2.setHPadding(0.0)
    button2.setVPadding(0.0)
    button3.setHPadding(30.0)
    button3.setVPadding(30.0)

    let layout = Layout(3, 2)

    layout.add(label1, 0, 0)
    layout.add(label2, 1, 0)
    layout.add(label3, 2, 0)

    layout.add(button1, 0, 1)
    layout.add(button2, 1, 1)
    layout.add(button3, 2, 1)

    layout.setHAlign(0, 1, Align.Center)
    layout.setHAlign(1, 1, Align.Center)
    layout.setHAlign(2, 1, Align.Center)

    layout.setHMargin(0, 10.0)
    layout.setHMargin(1, 10.0)

    return layout
}

/*---------------------------------------------------------------------------*/

func buttonpad(): Panel {
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()

    label1.setText("Vertical padding")
    label2.setText("Horizontal padding")
    label3.setText("Flat padding")

    let layout1 = Layout(1, 6)

    layout1.add(label1, 0, 0)
    layout1.add(label2, 0, 2)
    layout1.add(label3, 0, 4)

    let layout2 = vpaddingLayout()
    let layout3 = hpaddingLayout()
    let layout4 = flatpaddingLayout()

    layout1.add(layout2, 0, 1)
    layout1.add(layout3, 0, 3)
    layout1.add(layout4, 0, 5)

    layout1.setHAlign(0, 1, Align.Left)
    layout1.setHAlign(0, 5, Align.Left)

    layout1.setVMargin(0, 5.0)
    layout1.setVMargin(1, 5.0)
    layout1.setVMargin(2, 5.0)
    layout1.setVMargin(3, 5.0)
    layout1.setVMargin(4, 5.0)

    let panel = Panel()
    panel.setLayout(layout1)
    return panel
}
