package guihello

import nappgui4cj.*

private func setRtf(text: TextView): Unit {
    var pack = ResPack("")
    match (pack.getFile(TEXTVIEW_RTF)) {
        case Some((dataPtr, size)) => text.rtf(dataPtr, size)
        case _ => ()
    }
    pack.destroy()
}

private func setHardCoding(text: TextView): Unit {
    text.setUnits(FStyle.Points.value)
    text.setLSpacing(1.15)
    text.setAfSpace(10.0)
    text.setFamily("Arial")
    text.setFSize(16.0)
    text.writef("What is Lorem Ipsum?\n")
    text.setFSize(11.0)
    text.writef("Lorem Ipsum ")
    text.setFStyle(FStyle.Bold)
    text.writef("is simply")
    text.setFStyle(FStyle.Normal)
    text.writef(" dummy text of the ")
    text.setFStyle(FStyle.Italic)
    text.writef("printing and typesetting ")
    text.setFStyle(FStyle.Normal)
    text.writef("industry. ")
    text.setFSize(16.0)
    text.setColor(Color.RED)
    text.writef("Lorem Ipsum ")
    text.setColor(Color(0, 0, 0)) // kCOLOR_DEFAULT approximation
    text.setFSize(11.0)
    text.writef("has been the ")
    text.setFamily("Courier New")
    text.setFSize(14.0)
    text.writef("[industry's standard] ")
    text.setFamily("Arial")
    text.setFSize(11.0)
    text.setFStyle(FStyle.Underline)
    text.writef("dummy text")
    text.setFStyle(FStyle.Normal)
    text.writef(" ever ")
    text.setFStyle(FStyle.Strikeout)
    text.writef("since the 1500s")
    text.setFStyle(FStyle.Normal)
    text.writef(", when an ")
    text.setColor(Color(0, 176, 80))
    text.writef("unknown printer ")
    text.setColor(Color(0, 0, 0))
    text.writef("took a galley of type and scrambled it to make a type specimen book")
    text.setFStyle(FStyle.Italic)
    text.setColor(Color(0, 77, 187))
    text.setBgColor(Color(192, 192, 192))
    text.writef(". It has survived not only five centuries")
    text.setFStyle(FStyle.Normal)
    text.setColor(Color(0, 0, 0))
    text.setBgColor(Color(0, 0, 0))
    text.writef(", but also the leap into electronic typesetting, remaining essentially unchanged.")
}

func textviews(): Panel {
    let layout = Layout(1, 4)
    let label1 = Label()
    let label2 = Label()
    let text1 = TextView()
    let text2 = TextView()
    let panel = Panel()

    label1.setText("From RTF data")
    label2.setText("Hard coding")

    text1.setSize(S2Df(450.0, 250.0))
    text2.setSize(S2Df(450.0, 250.0))

    setRtf(text1)
    setHardCoding(text2)

    layout.add(label1, 0, 0)
    layout.add(text1, 0, 1)
    layout.add(label2, 0, 2)
    layout.add(text2, 0, 3)

    layout.setVMargin(0, 5.0)
    layout.setVMargin(1, 10.0)
    layout.setVMargin(2, 5.0)

    panel.setLayout(layout)
    return panel
}
