package guihello

import nappgui4cj.*

@C
private struct StructTypes {
    var x: Float32
    var y: Float32
    var z: Float32

    init(x: Float32, y: Float32, z: Float32) {
        this.x = x
        this.y = y
        this.z = z
    }
}

private func dataBind(): Unit {
    DBind.bind(
        typeName: "StructTypes",
        typeSize: 12,
        memberName: "x",
        membertypeName: "real32_t",
        memberOffset: 0,
        memberSize: 4
    )
    DBind.bind(
        typeName: "StructTypes",
        typeSize: 12,
        memberName: "y",
        membertypeName: "real32_t",
        memberOffset: 4,
        memberSize: 4
    )
    DBind.bind(
        typeName: "StructTypes",
        typeSize: 12,
        memberName: "z",
        membertypeName: "real32_t",
        memberOffset: 8,
        memberSize: 4
    )

    DBind.range("StructTypes", "x", -5.0f32, 5.0f32)
    DBind.range("StructTypes", "y", -5.0f32, 5.0f32)
    DBind.range("StructTypes", "z", -5.0f32, 5.0f32)
    DBind.increment("StructTypes", "x", 0.1f32)
    DBind.increment("StructTypes", "y", 0.1f32)
    DBind.increment("StructTypes", "z", 0.1f32)
}

@C
private func destroyData(dataPtrPtr: CPointer<CPointer<StructTypes>>): Unit {
    unsafe {
        let dataPtr = dataPtrPtr.read()
        var data = dataPtr.read()
        // data.destroy()
        Heap.free(dataPtr)
    }
    DBind.unreg("StructTypes")
    // DBind.unreg("Vector")
}

// private func vecLength(vec: Vector): Float32 {
//     let n = vec.x * vec.x + vec.y * vec.y + vec.z * vec.z
//     return sqrt(n)
// }

@C
private func onDataChange(_: CPointer<Unit>, e: Event): Unit {
    let dataPtr = e.getBindObjPtr<StructTypes>(typeName: "StructTypes")
    let data = unsafe { dataPtr.read() }
    println("Value: ${data.x}, ${data.y}, ${data.z}")

    // if (e.hasBindModify(
    //     typeName: "StructTypes",
    //     typeSize: 12,
    //     memberName: "vec1",
    //     membertypeName: "Vector",
    //     memberOffset: 0,
    //     memberSize: 12
    // )) {
    //     println("yes!")
    // }
}

private func vectorLayout(): Layout {
    let layout = Layout(3, 3)
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let edit1 = Edit()
    let edit2 = Edit()
    let edit3 = Edit()
    let updown1 = UpDown()
    let updown2 = UpDown()
    let updown3 = UpDown()

    label1.setText("X:")
    label2.setText("Y:")
    label3.setText("Z:")

    edit1.setAlign(Align.Right)
    edit2.setAlign(Align.Right)
    edit3.setAlign(Align.Right)

    layout.add(label1, 0, 0)
    layout.add(label2, 0, 1)
    layout.add(label3, 0, 2)
    layout.add(edit1, 1, 0)
    layout.add(edit2, 1, 1)
    layout.add(edit3, 1, 2)
    layout.add(updown1, 2, 0)
    layout.add(updown2, 2, 1)
    layout.add(updown3, 2, 2)

    layout.setHMargin(0, 5.0)
    layout.setVMargin(0, 5.0)
    layout.setVMargin(1, 5.0)
    layout.setHSize(1, 60.0)

    layout.createCell(1, 0).dbind(
        structType: "StructTypes",
        structSize: 12,
        memberName: "x",
        memberType: "real32_t",
        memberOffset: 0,
        memberSize: 4
    )
    layout.createCell(1, 1).dbind(
        structType: "StructTypes",
        structSize: 12,
        memberName: "y",
        memberType: "real32_t",
        memberOffset: 4,
        memberSize: 4
    )
    layout.createCell(1, 2).dbind(
        structType: "StructTypes",
        structSize: 12,
        memberName: "z",
        memberType: "real32_t",
        memberOffset: 8,
        memberSize: 4
    )
    layout.createCell(2, 0).dbind(
        structType: "StructTypes",
        structSize: 12,
        memberName: "x",
        memberType: "real32_t",
        memberOffset: 0,
        memberSize: 4
    )
    layout.createCell(2, 1).dbind(
        structType: "StructTypes",
        structSize: 12,
        memberName: "y",
        memberType: "real32_t",
        memberOffset: 4,
        memberSize: 4
    )
    layout.createCell(2, 2).dbind(
        structType: "StructTypes",
        structSize: 12,
        memberName: "z",
        memberType: "real32_t",
        memberOffset: 8,
        memberSize: 4
    )

    // cell_dbind(layout_cell(layout, 1, 0), Vector, real32_t, x);
    // cell_dbind(layout_cell(layout, 1, 1), Vector, real32_t, y);
    // cell_dbind(layout_cell(layout, 1, 2), Vector, real32_t, z);
    // cell_dbind(layout_cell(layout, 2, 0), Vector, real32_t, x);
    // cell_dbind(layout_cell(layout, 2, 1), Vector, real32_t, y);
    // cell_dbind(layout_cell(layout, 2, 2), Vector, real32_t, z);
    return layout
}

private func nameLayout(): Layout {
    let layout = Layout(2, 1)
    let label = Label()
    let edit = Edit()

    label.setText("Object Name:")

    layout.hExpand(1)
    layout.add(label, 0, 0)
    layout.add(edit, 1, 0)
    layout.setHMargin(0, 10.0)

    // layout.cell(1, 0).dbind<StructTypes, String>("name")
    return layout
}

private func vectorsLayout(): Layout {
    let layout1 = Layout(3, 4)
    let layout2 = vectorLayout()
    let layout3 = vectorLayout()
    let layout4 = vectorLayout()
    let layout5 = vectorLayout()
    let layout6 = vectorLayout()
    let layout7 = vectorLayout()

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()
    let label6 = Label()

    label1.setText("vec1")
    label2.setText("vec2")
    label3.setText("vec3")
    label4.setText("*pvec1")
    label5.setText("*pvec2")
    label6.setText("*pvec3")

    layout1.add(label1, 0, 0)
    layout1.add(label2, 1, 0)
    layout1.add(label3, 2, 0)
    layout1.add(label4, 0, 2)
    layout1.add(label5, 1, 2)
    layout1.add(label6, 2, 2)

    layout1.add(layout2, 0, 1)
    layout1.add(layout3, 1, 1)
    layout1.add(layout4, 2, 1)
    layout1.add(layout5, 0, 3)
    layout1.add(layout6, 1, 3)
    layout1.add(layout7, 2, 3)

    layout1.setHAlign(0, 0, Align.Center)
    layout1.setHAlign(1, 0, Align.Center)
    layout1.setHAlign(2, 0, Align.Center)
    layout1.setHAlign(0, 2, Align.Center)
    layout1.setHAlign(1, 2, Align.Center)
    layout1.setHAlign(2, 2, Align.Center)

    layout1.setHMargin(0, 10.0)
    layout1.setHMargin(1, 10.0)
    layout1.setVMargin(0, 5.0)
    layout1.setVMargin(1, 10.0)
    layout1.setVMargin(2, 5.0)

    // layout1.createCell(0, 1).dbind(
    //     structType: "StructTypes",
    //     structSize: 12,
    //     memberName: "vec1",
    //     memberType: "Vector",
    //     memberOffset: 0,
    //     memberSize: 12
    // )

    // cell_dbind(layout_cell(layout1, 0, 1), StructTypes, Vector, vec1);
    // cell_dbind(layout_cell(layout1, 1, 1), StructTypes, Vector, vec2);
    // cell_dbind(layout_cell(layout1, 2, 1), StructTypes, Vector, vec3);
    // cell_dbind(layout_cell(layout1, 0, 3), StructTypes, Vector *, pvec1);
    // cell_dbind(layout_cell(layout1, 1, 3), StructTypes, Vector *, pvec2);
    // cell_dbind(layout_cell(layout1, 2, 3), StructTypes, Vector *, pvec3);

    return layout1
}

private func lengthsLayout(): Layout {
    let layout = Layout(2, 6)
    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()
    let label6 = Label()
    let label7 = Label()
    let label8 = Label()
    let label9 = Label()
    let label10 = Label()
    let label11 = Label()
    let label12 = Label()

    label1.setText("length1:")
    label2.setText("length2:")
    label3.setText("length3:")
    label4.setText("length4:")
    label5.setText("length5:")
    label6.setText("length6:")

    layout.add(label1, 0, 0)
    layout.add(label2, 0, 1)
    layout.add(label3, 0, 2)
    layout.add(label4, 0, 3)
    layout.add(label5, 0, 4)
    layout.add(label6, 0, 5)
    layout.add(label7, 1, 0)
    layout.add(label8, 1, 1)
    layout.add(label9, 1, 2)
    layout.add(label10, 1, 3)
    layout.add(label11, 1, 4)
    layout.add(label12, 1, 5)

    label7.setAlign(Align.Right)
    label8.setAlign(Align.Right)
    label9.setAlign(Align.Right)
    label10.setAlign(Align.Right)
    label11.setAlign(Align.Right)
    label12.setAlign(Align.Right)

    layout.setHSize(1, 40.0)
    layout.setHMargin(0, 5.0)

    layout.setHAlign(1, 0, Align.Justify)
    layout.setHAlign(1, 1, Align.Justify)
    layout.setHAlign(1, 2, Align.Justify)
    layout.setHAlign(1, 3, Align.Justify)
    layout.setHAlign(1, 4, Align.Justify)
    layout.setHAlign(1, 5, Align.Justify)

    // layout.cell(1, 0).dbind<StructTypes, Float32>("length1")
    // layout.cell(1, 1).dbind<StructTypes, Float32>("length2")
    // layout.cell(1, 2).dbind<StructTypes, Float32>("length3")
    // layout.cell(1, 3).dbind<StructTypes, Float32>("length4")
    // layout.cell(1, 4).dbind<StructTypes, Float32>("length5")
    // layout.cell(1, 5).dbind<StructTypes, Float32>("length6")

    return layout
}

private func mainLayout(): Layout {
    let layout1 = Layout(2, 2)
    let layout2 = nameLayout()
    let layout3 = vectorsLayout()
    let layout4 = lengthsLayout()

    layout1.add(layout2, 0, 0)
    layout1.add(layout3, 0, 1)
    layout1.add(layout4, 1, 1)

    layout1.setHMargin(0, 10.0)
    layout1.setVMargin(0, 10.0)

    return layout1
}

func layoutbind(): Panel {
    let panel = Panel()
    let dataPtr = Heap.malloc<StructTypes>()
    let data = StructTypes(1.2f32, 2.1f32, -3.4f32)
    unsafe { dataPtr.write(data) }

    dataBind()

    let layout = mainLayout()
    panel.setLayout(layout)

    layout.bind(typeName: "StructTypes", typeSize: 12)
    layout.bind(onDataChange, obj: CPointer<Unit>(), typeName: "StructTypes", typeSize: 12)
    layout.bindObj(obj: dataPtr, typeName: "StructTypes")

    panel.setData(dataPtr, destroyData)

    return panel
}
