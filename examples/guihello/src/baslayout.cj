package guihello

import nappgui4cj.*

func basicLayout(): Panel {
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()

    let edit1 = Edit()
    let edit2 = Edit()
    let edit3 = Edit()
    let edit4 = Edit()
    let edit5 = Edit()

    label1.setText("User Name:")
    label2.setText("Password:")
    label3.setText("Address:")
    label4.setText("City:")
    label5.setText("Phone:")

    edit1.setText("Amanda Callister")
    edit2.setText("aQwe56nhjJk")
    edit3.setText("35, Tuam Road")
    edit4.setText("Galway - Ireland")
    edit5.setText("+35 654 333 000")

    edit2.setPassMode(true)

    let layout = Layout(2, 5)
    layout.add(label1, 0, 0)
    layout.add(label2, 0, 1)
    layout.add(label3, 0, 2)
    layout.add(label4, 0, 3)
    layout.add(label5, 0, 4)

    layout.add(edit1, 1, 0)
    layout.add(edit2, 1, 1)
    layout.add(edit3, 1, 2)
    layout.add(edit4, 1, 3)
    layout.add(edit5, 1, 4)

    let panel = Panel()
    panel.setLayout(layout)
    return panel
}
