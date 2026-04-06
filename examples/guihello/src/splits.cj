package guihello

import nappgui4cj.*

private const LOREM = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
private const N_ROWS = 32u32

@C
func spOnDraw(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvDraw>() ?? return
    let ctx = params.ctx
    let width = params.width
    let height = params.height

    let p0 = width / 6.0
    let p1 = height / 6.0
    let p2 = width / 3.0
    let p3 = height / 3.0

    ctx.setFillColor(Color.RED)
    ctx.drawRect(DrawOp.Fill, 0.0, 0.0, width, height)
    ctx.setFillColor(Color.GREEN)
    ctx.drawRect(DrawOp.Fill, p0, p1, width - 2.0 * p0, height - 2.0 * p1)
    ctx.setFillColor(Color.BLUE)
    ctx.drawRect(DrawOp.Fill, p2, p3, width - 2.0 * p2, height - 2.0 * p3)
}

private func createLeftPanel(): Panel {
    let panel = Panel(hscroll: false, vscroll: true)
    let layout = Layout(2, N_ROWS)

    let scrollWidth = panel.scrollWidth()

    for (i in 0..N_ROWS) {
        let label = Label()
        let edit = Edit()

        label.setText("Value ${i + 1}")
        edit.setText("Edit here value ${i + 1}")

        layout.add(label, 0, i)
        layout.add(edit, 1, i)
    }

    for (i in 0..N_ROWS - 1) {
        layout.setVMargin(i, 3.0)
    }

    layout.setHMargin(0, 5.0)
    layout.setMargin(0.0, scrollWidth, 0.0, 0.0)
    layout.hExpand(1)

    panel.setLayout(layout)
    return panel
}

func splitPanel(): Panel {
    let mainPanel = Panel()
    let leftPanel = createLeftPanel()
    let layout = Layout(1, 1)

    // Create split views
    let split1 = SplitView(SvVertical)
    let split2 = SplitView(SvHorizontal)

    // Create TextView
    let text = TextView()
    text.writef(LOREM)
    text.setSize(S2Df(400.0, 200.0))

    // Create custom View with drawing callback
    let view = View()
    view.setSize(S2Df(400.0, 200.0))
    view.onDraw(spOnDraw)

    // Setup split2 (SlHorizontal: Top/Bottom)
    split2.setView(view, tabstop: false)
    split2.setTextView(text, tabstop: false)

    // Setup split1 (SlVertical: Left/Right)
    split1.setPanel(leftPanel)
    split1.setSplitView(split2)

    layout.add(split1, 0, 0)

    mainPanel.setLayout(layout)
    return mainPanel
}
