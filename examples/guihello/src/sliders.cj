package guihello

import nappgui4cj.*

@C
func slOnSlider(obj: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvSlider>() ?? return
    let progress = Progress(obj)
    progress.setValue(params.pos)
}

func sliders(): Panel {
    let layout1 = Layout(2, 1)
    let layout2 = Layout(1, 8)

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()

    let slider1 = Slider(SlHorizontal)
    let slider2 = Slider(SlHorizontal)
    let slider3 = Slider(SlVertical)

    let prog1 = Progress()
    let prog2 = Progress()

    let panel = Panel()

    label1.setText("Slider")
    label2.setText("Slider (discrete 6 steps)")
    label3.setText("Progress Bar")
    label4.setText("Progress Undefined")

    slider2.setSteps(6)

    slider1.setTooltip("Horizontal Slider")
    slider2.setTooltip("Horizontal Discrete Slider")
    slider3.setTooltip("Vertical Slider")

    slider1.onMoved(slOnSlider, obj: prog1.handle)

    prog2.setUndefined(true)

    layout2.add(label1, 0, 0)
    layout2.add(label2, 0, 2)
    layout2.add(label3, 0, 4)
    layout2.add(label4, 0, 6)

    layout2.add(slider1, 0, 1)
    layout2.add(slider2, 0, 3)
    layout1.add(slider3, 1, 0)

    layout2.add(prog1, 0, 5)
    layout2.add(prog2, 0, 7)

    layout2.setHSize(0, 300.0)

    layout1.add(layout2, 0, 0)

    layout2.setVMargin(0, 5.0)
    layout2.setVMargin(1, 5.0)
    layout2.setVMargin(2, 5.0)
    layout2.setVMargin(3, 5.0)
    layout2.setVMargin(4, 5.0)
    layout2.setVMargin(5, 5.0)
    layout2.setVMargin(6, 5.0)

    layout1.setHMargin(0, 10.0)

    panel.setLayout(layout1)
    return panel
}
