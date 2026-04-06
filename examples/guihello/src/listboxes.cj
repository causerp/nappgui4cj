package guihello

import nappgui4cj.*

private func fullListbox(): ListBox {
    let listbox = ListBox()

    listbox.setSize(S2Df(150.0, 200.0))
    listbox.setMultisel(true)
    listbox.setCheckbox(true)

    listbox.addItem("Sales presentation", GUI.getImage(POWERPOINT_PNG))
    listbox.addItem("Balance 2017", GUI.getImage(POWERPOINT_PNG))
    listbox.addItem("The Last of Us Analysis", GUI.getImage(POWERPOINT_PNG))
    listbox.addItem("Phone list", GUI.getImage(ACCESS_PNG))
    listbox.addItem("Customer database", GUI.getImage(ACCESS_PNG))
    listbox.addItem("My first book", GUI.getImage(WORD_PNG))
    listbox.addItem("Letter to April", GUI.getImage(WORD_PNG))
    listbox.addItem("Cookbook Recipes", GUI.getImage(WORD_PNG))
    listbox.addItem("Dog playing piano", GUI.getImage(JPG_PNG))
    listbox.addItem("Hollidays 2019", GUI.getImage(JPG_PNG))
    listbox.addItem("Amanda's party", GUI.getImage(JPG_PNG))
    listbox.addItem("Flying", GUI.getImage(JPG_PNG))
    listbox.addItem("The C Programing Language", GUI.getImage(PDF_PNG))
    listbox.addItem("Graphics Programing with GDI+", GUI.getImage(PDF_PNG))
    listbox.addItem("Personal finances", GUI.getImage(EXCEL_PNG))
    listbox.addItem("Stocks 2017", GUI.getImage(EXCEL_PNG))
    listbox.addItem("Website Dashboard", GUI.getImage(EXCEL_PNG))
    listbox.addItem("Open Issues", GUI.getImage(DOCUMENT_PNG))
    listbox.addItem("TODO List", GUI.getImage(DOCUMENT_PNG))

    listbox.select(0, true)

    return listbox
}

private func imageListbox(): ListBox {
    let listbox = ListBox()

    listbox.setSize(S2Df(150.0, 200.0))

    listbox.addItem("Spain", GUI.getImage(SPAIN_PNG))
    listbox.addItem("Italy", GUI.getImage(ITALY_PNG))
    listbox.addItem("United Kingdom", GUI.getImage(UKING_PNG))
    listbox.addItem("Vietnam", GUI.getImage(VIETNAM_PNG))
    listbox.addItem("Russia", GUI.getImage(RUSSIA_PNG))
    listbox.addItem("Portugal", GUI.getImage(PORTUGAL_PNG))
    listbox.addItem("Japan", GUI.getImage(JAPAN_PNG))
    listbox.addItem("Disk", GUI.getImage(DISK16_PNG))
    listbox.addItem("Edit", GUI.getImage(EDIT16_PNG))
    listbox.addItem("Folder", GUI.getImage(FOLDER16_PNG))
    listbox.addItem("Restore", GUI.getImage(RESTORE16_PNG))
    listbox.addItem("Search", GUI.getImage(SEARCH16_PNG))
    listbox.addItem("Error", GUI.getImage(ERROR16_PNG))

    listbox.select(0, true)

    return listbox
}

private func simpleListbox(): ListBox {
    let listbox = ListBox()

    listbox.setSize(S2Df(150.0, 200.0))

    listbox.addItem("Item 1", None)
    listbox.addItem("Item 2", None)
    listbox.addItem("Item 3", None)
    listbox.addItem("Item 4", None)

    listbox.setColor(0, GUI.altColor(Color(128, 0, 0), Color.RED))
    listbox.setColor(1, GUI.altColor(Color(0, 128, 0), Color.GREEN))
    listbox.setColor(2, GUI.altColor(Color(0, 0, 128), Color.BLUE))

    listbox.select(0, true)

    return listbox
}

func listboxes(): Panel {
    let panel = Panel()
    let layout = Layout(3, 2)

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()

    let listbox1 = simpleListbox()
    let listbox2 = imageListbox()
    let listbox3 = fullListbox()

    label1.setText("Simple ListBox")
    label2.setText("With Images")
    label3.setText("Checks and Multiselect")

    layout.add(label1, 0, 0)
    layout.add(label2, 1, 0)
    layout.add(label3, 2, 0)

    layout.add(listbox1, 0, 1)
    layout.add(listbox2, 1, 1)
    layout.add(listbox3, 2, 1)

    layout.setHMargin(0, 10.0)
    layout.setHMargin(1, 10.0)
    layout.setVMargin(0, 5.0)

    panel.setLayout(layout)

    return panel
}
