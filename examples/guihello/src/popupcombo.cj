package guihello

import nappgui4cj.*

private class PopUpData {
    private static var m_data: ?PopUpData = None

    var popup: PopUp
    var combo: Combo
    var view: TextView

    private init() {
        popup = PopUp(CPointer())
        combo = Combo(CPointer())
        view = TextView()
    }

    static func get(recreate!: Bool = false): PopUpData {
        if (recreate) {
            m_data = None
        }
        match (m_data) {
            case Some(data) => return data
            case None =>
                let data = PopUpData()
                m_data = data
                return data
        }
    }
}

@C
func pcOnPopUpSelect(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let view = PopUpData.get().view
    view.writef("PopUp OnSelect ${params.index} '${params.text}'\n")
    view.scrollCaret()
}

private func popups(layout: Layout): Unit {
    let label1 = Label()
    let label2 = Label()
    let popup1 = PopUp()
    let popup2 = PopUp()

    label1.setText("Language:")
    label2.setText("Color:")

    popup1.addItem("English", GUI.getImage(UKING_PNG))
    popup1.addItem("Español", GUI.getImage(SPAIN_PNG))
    popup1.addItem("Portugues", GUI.getImage(PORTUGAL_PNG))
    popup1.addItem("Italiana", GUI.getImage(ITALY_PNG))
    popup1.addItem("Tiếng Việt", GUI.getImage(VIETNAM_PNG))
    popup1.addItem("России", GUI.getImage(RUSSIA_PNG))
    popup1.addItem("日本語", GUI.getImage(JAPAN_PNG))

    popup2.addItem("Red", GUI.getImage(RED_PNG))
    popup2.addItem("Blue", GUI.getImage(BLUE_PNG))
    popup2.addItem("Green", GUI.getImage(GREEN_PNG))
    popup2.addItem("Yellow", GUI.getImage(YELLOW_PNG))
    popup2.addItem("Black", GUI.getImage(BLACK_PNG))
    popup2.addItem("White", GUI.getImage(WHITE_PNG))

    popup1.setTooltip("Languages")
    popup2.setTooltip("Colors")

    popup1.onSelect(pcOnPopUpSelect)

    popup1.setListHeight(10)
    popup2.setListHeight(10)

    layout.add(label1, 0, 0)
    layout.add(label2, 0, 1)
    layout.add(popup1, 1, 0)
    layout.add(popup2, 1, 1)

    PopUpData.get().popup = popup1
}

@C
func pcOnComboSelect(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvButton>() ?? return
    let view = PopUpData.get().view
    view.writef("Combo OnSelect ${params.index} '${params.text}'\n")
    view.scrollCaret()
}

private func combos(layout: Layout): Unit {
    let label1 = Label()
    let label2 = Label()
    let combo1 = Combo()
    let combo2 = Combo()

    label1.setText("Search:")
    label2.setText("Folder:")

    combo1.addItem("Search", None)
    combo1.addItem("Disk", None)
    combo1.addItem("Edit", None)

    combo2.addItem("/home/fran/Desktop", GUI.getImage(FOLDER16_PNG))
    combo2.addItem("/usr/include", GUI.getImage(EDIT16_PNG))
    combo2.addItem("/mnt/volume1", GUI.getImage(DISK16_PNG))
    combo2.addItem("/etc/html/log.txt", GUI.getImage(FIRST16_PNG))

    combo1.onSelect(pcOnComboSelect)

    combo1.setListHeight(10)
    combo2.setListHeight(3)

    combo1.setTooltip("This is a tooltip over Combo-1")
    combo2.setTooltip("This is a tooltip over Combo-2")

    layout.add(label1, 2, 0)
    layout.add(label2, 2, 1)
    layout.add(combo1, 3, 0)
    layout.add(combo2, 3, 1)

    PopUpData.get().combo = combo1
}

@C
func pcOnPopUpAdd(_: CPointer<Unit>, _: Event): Unit {
    let popup = PopUpData.get().popup
    popup.addItem("Español", GUI.getImage(SPAIN_PNG))
}

@C
func pcOnPopUpInsert(_: CPointer<Unit>, _: Event): Unit {
    let popup = PopUpData.get().popup
    popup.insertItem(0, "English", GUI.getImage(UKING_PNG))
}

@C
func pcOnPopUpDelete(_: CPointer<Unit>, _: Event): Unit {
    let popup = PopUpData.get().popup
    if (popup.count() > 0) {
        popup.deleteItem(0)
    }
}

@C
func pcOnPopUpClear(_: CPointer<Unit>, _: Event): Unit {
    let popup = PopUpData.get().popup
    popup.clear()
}

@C
@OverflowWrapping
private func pcOnPopUpGetSel(_: CPointer<Unit>, _: Event): Unit {
    let data = PopUpData.get()
    data.view.writef("PopUp selected: ${Int32(data.popup.getSelected())}\n")
    data.view.scrollCaret()
}

@C
func pcOnComboAdd(_: CPointer<Unit>, _: Event): Unit {
    let combo = PopUpData.get().combo
    combo.addItem("combo add item", None)
}

@C
func pcOnComboInsert(_: CPointer<Unit>, _: Event): Unit {
    let combo = PopUpData.get().combo
    combo.insertItem(0, "combo ins item", None)
}

@C
func pcOnComboDelete(_: CPointer<Unit>, _: Event): Unit {
    let combo = PopUpData.get().combo
    if (combo.count() > 0) {
        combo.delItem(0)
    }
}

@C
func pcOnComboClear(_: CPointer<Unit>, _: Event): Unit {
    let combo = PopUpData.get().combo
    combo.clear()
}

@C
@OverflowWrapping
private func pcOnComboGetSel(_: CPointer<Unit>, _: Event): Unit {
    let data = PopUpData.get()
    data.view.writef("Combo selected: ${Int32(data.combo.getSelected())}\n")
    data.view.scrollCaret()
}

func popupCombo(): Panel {
    let panel = Panel()
    let layout1 = Layout(1, 2)
    let layout2 = Layout(4, 7)

    let button1 = Button(BtnPush)
    let button2 = Button(BtnPush)
    let button3 = Button(BtnPush)
    let button4 = Button(BtnPush)
    let button5 = Button(BtnPush)
    let button6 = Button(BtnPush)
    let button7 = Button(BtnPush)
    let button8 = Button(BtnPush)
    let button9 = Button(BtnPush)
    let button10 = Button(BtnPush)

    let data = PopUpData.get(recreate: true)

    popups(layout2)
    combos(layout2)

    button1.setText("Add elem to PopUp")
    button2.setText("Insert elem to PopUp")
    button3.setText("Delete elem from PopUp")
    button4.setText("Clear PopUp")
    button5.setText("Get Select PopUp")
    button6.setText("Add elem to Combo")
    button7.setText("Insert elem to Combo")
    button8.setText("Delete elem from Combo")
    button9.setText("Clear Combo")
    button10.setText("Get Select Combo")

    button1.onClick(pcOnPopUpAdd)
    button2.onClick(pcOnPopUpInsert)
    button3.onClick(pcOnPopUpDelete)
    button4.onClick(pcOnPopUpClear)
    button5.onClick(pcOnPopUpGetSel)
    button6.onClick(pcOnComboAdd)
    button7.onClick(pcOnComboInsert)
    button8.onClick(pcOnComboDelete)
    button9.onClick(pcOnComboClear)
    button10.onClick(pcOnComboGetSel)

    layout2.add(button1, 1, 2)
    layout2.add(button2, 1, 3)
    layout2.add(button3, 1, 4)
    layout2.add(button4, 1, 5)
    layout2.add(button5, 1, 6)
    layout2.add(button6, 3, 2)
    layout2.add(button7, 3, 3)
    layout2.add(button8, 3, 4)
    layout2.add(button9, 3, 5)
    layout2.add(button10, 3, 6)

    layout1.add(layout2, 0, 0)
    layout1.add(data.view, 0, 1)

    layout1.setMargin(10.0)
    layout2.setVMargin(0, 10.0)
    layout2.setVMargin(1, 10.0)
    layout2.setVMargin(2, 5.0)
    layout2.setVMargin(3, 5.0)
    layout2.setVMargin(4, 5.0)
    layout2.setVMargin(5, 5.0)
    layout1.setVMargin(0, 10.0)
    layout2.setHMargin(0, 5.0)
    layout2.setHMargin(1, 10.0)
    layout2.setHMargin(2, 5.0)

    panel.setLayout(layout1)

    return panel
}
