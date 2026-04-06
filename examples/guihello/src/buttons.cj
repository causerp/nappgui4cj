package guihello

import nappgui4cj.*

private func flatButtons(): Layout {
    let layout = Layout(6, 1)

    let button1 = Button(BtnFlat)
    let button2 = Button(BtnFlat)
    let button3 = Button(BtnFlat)
    let button4 = Button(BtnFlat)
    let button5 = Button(BtnFlat)
    let button6 = Button(BtnFlat)

    button1.setText("Open File")
    button2.setText("Save File")
    button3.setText("Search File")
    button4.setText("Edit File")
    button5.setText("Add File")
    button6.setText("Delete File")

    button1.setImage(GUI.getImage(FOLDER24_PNG))
    button2.setImage(GUI.getImage(DISK24_PNG))
    button3.setImage(GUI.getImage(SEARCH24_PNG))
    button4.setImage(GUI.getImage(EDIT24_PNG))
    button5.setImage(GUI.getImage(PLUS24_PNG))
    button6.setImage(GUI.getImage(ERROR24_PNG))

    layout.add(button1, 0, 0)
    layout.add(button2, 1, 0)
    layout.add(button3, 2, 0)
    layout.add(button4, 3, 0)
    layout.add(button5, 4, 0)
    layout.add(button6, 5, 0)

    return layout
}

private func radios(): Layout {
    let layout = Layout(1, 4)

    let radio1 = Button(BtnRadio)
    let radio2 = Button(BtnRadio)
    let radio3 = Button(BtnRadio)
    let radio4 = Button(BtnRadio)

    radio1.setText("&Wireframe")
    radio2.setText("&Shaded")
    radio3.setText("&Realistic")
    radio4.setText("&V-Ray")
    radio1.setState(GUIState.On)

    layout.add(radio1, 0, 0)
    layout.add(radio2, 0, 1)
    layout.add(radio3, 0, 2)
    layout.add(radio4, 0, 3)

    layout.setMargin(5.0)
    layout.setVMargin(0, 3.0)
    layout.setVMargin(1, 3.0)
    layout.setVMargin(2, 3.0)

    return layout
}

private func checks(): Layout {
    let layout = Layout(1, 4)

    let check1 = Button(BtnCheck)
    let check2 = Button(BtnCheck)
    let check3 = Button(BtnCheck)
    let check4 = Button(BtnCheck)

    check1.setText("&Lines")
    check2.setText("M&eshes")
    check3.setText("M&aterials")
    check4.setText("L&ights")

    check1.setState(GUIState.On)
    check2.setState(GUIState.Off)
    check3.setState(GUIState.Off)
    check4.setState(GUIState.On)

    layout.add(check1, 0, 0)
    layout.add(check2, 0, 1)
    layout.add(check3, 0, 2)
    layout.add(check4, 0, 3)

    layout.setMargin(5.0)
    layout.setVMargin(0, 3.0)
    layout.setVMargin(1, 3.0)
    layout.setVMargin(2, 3.0)

    return layout
}

private func pushes(defbutton: Box<?Button>): Layout {
    let layout = Layout(4, 1)

    let button1 = Button(BtnPush)
    let button2 = Button(BtnPush)
    let button3 = Button(BtnPush)

    button1.setText("Re&try")
    button2.setText("&Cancel")
    button3.setText("&Ok")
    button1.setImage(GUI.getImage(RETRY_PNG))

    layout.add(button1, 0, 0)
    layout.add(button2, 2, 0)
    layout.add(button3, 3, 0)

    layout.setHMargin(2, 5.0)
    layout.hExpand(1)

    defbutton.value = button1

    return layout
}

private func buttons(defbutton: Box<?Button>): Layout {
    let layout = Layout(1, 3)

    let layout1 = flatButtons()

    let layout2 = Layout(2, 2)
    let layout3 = radios()
    let layout4 = checks()
    let layout5 = pushes(defbutton)

    let check1 = Button(BtnCheck)
    let check2 = Button(BtnCheck3)

    check1.setText("Enable 3&D Render")
    check2.setText("Enable &Preview Settings")
    check1.setState(GUIState.On)
    check2.setState(GUIState.Mixed)

    layout.add(layout1, 0, 0)

    layout2.add(check1, 0, 0)
    layout2.add(layout3, 0, 1)
    layout2.add(check2, 1, 0)
    layout2.add(layout4, 1, 1)

    layout.add(layout2, 0, 1)
    layout.add(layout5, 0, 2)

    layout.setHAlign(0, 0, Align.Left)
    layout2.setMargin(5.0)
    layout2.setHMargin(0, 10.0)
    layout5.setMargin(5.0)

    return layout
}

func buttonsBasics(defbutton: Box<?Button>): Panel {
    let layout = buttons(defbutton)
    let panel = Panel()
    panel.setLayout(layout)
    return panel
}
