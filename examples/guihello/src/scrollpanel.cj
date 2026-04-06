package guihello

import nappgui4cj.*

private const ROWS = 100u32

func scrollpanel(): Panel {
    let panel = Panel(hscroll: false, vscroll: true)
    let layout = Layout(3, ROWS)

    let scrollWidth = panel.scrollWidth()
    panel.setSize(S2Df(-1.0, 400.0))

    for (i in 0..ROWS) {
        let label = Label()
        let edit = Edit()
        let button = Button(BtnPush)

        label.setText("User ${i + 1}")
        edit.setText("Name of User ${i + 1}")
        button.setText("Edit ${i + 1}")

        layout.add(label, 0, i)
        layout.add(edit, 1, i)
        layout.add(button, 2, i)
    }

    for (i in 0..ROWS - 1) {
        layout.setVMargin(i, 5.0)
    }

    layout.setHMargin(0, 10.0)
    layout.setHMargin(1, 10.0)
    layout.setHSize(1, 150.0)
    layout.setMargin(0.0, scrollWidth, 0.0, 0.0)

    panel.setLayout(layout)

    return panel
}
