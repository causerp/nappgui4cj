package nappgui4cj

foreign {
    func layout_create(columns: UInt32, rows: UInt32): CPointer<Unit>

    func layout_cell(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_control(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_label(layout: Layout, label: Label, col: UInt32, row: UInt32): Unit

    func layout_button(layout: Layout, button: Button, col: UInt32, row: UInt32): Unit

    func layout_popup(layout: Layout, popup: PopUp, col: UInt32, row: UInt32): Unit

    func layout_edit(layout: Layout, edit: Edit, col: UInt32, row: UInt32): Unit

    func layout_combo(layout: Layout, combo: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_listbox(layout: Layout, list: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_updown(layout: Layout, updown: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_slider(layout: Layout, slider: Slider, col: UInt32, row: UInt32): Unit

    func layout_progress(layout: Layout, progress: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_view(layout: Layout, view: View, col: UInt32, row: UInt32): Unit

    func layout_textview(layout: Layout, view: TextView, col: UInt32, row: UInt32): Unit

    func layout_webview(layout: Layout, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_imageview(layout: Layout, view: ImageView, col: UInt32, row: UInt32): Unit

    func layout_tableview(layout: Layout, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_splitview(layout: Layout, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_panel(layout: Layout, panel: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_panel_replace(layout: Layout, panel: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_layout(layout: Layout, sublayout: Layout, col: UInt32, row: UInt32): Unit

    func layout_get_label(layout: Layout, col: UInt32, row: UInt32): Label

    func layout_get_button(layout: Layout, col: UInt32, row: UInt32): Button

    func layout_get_popup(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_edit(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_combo(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_listbox(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_updown(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_slider(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_progress(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_view(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_textview(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_webview(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_imageview(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_tableview(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_splitview(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_panel(layout: Layout, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_layout(layout: Layout, col: UInt32, row: UInt32): Layout

    func layout_ncols(layout: Layout): UInt32

    func layout_nrows(layout: Layout): UInt32

    func layout_insert_col(layout: Layout, col: UInt32): Unit

    func layout_insert_row(layout: Layout, row: UInt32): Unit

    func layout_remove_col(layout: Layout, col: UInt32): Unit

    func layout_remove_row(layout: Layout, row: UInt32): Unit

    func layout_taborder(layout: Layout, order: GUIOrient): Unit

    func layout_tabstop(layout: Layout, col: UInt32, row: UInt32, tabstop: Bool): Unit

    func layout_hsize(layout: Layout, col: UInt32, width: Float32): Unit

    func layout_vsize(layout: Layout, row: UInt32, height: Float32): Unit

    func layout_hmargin(layout: Layout, col: UInt32, margin: Float32): Unit

    func layout_vmargin(layout: Layout, row: UInt32, margin: Float32): Unit

    func layout_hexpand(layout: Layout, col: UInt32): Unit

    func layout_hexpand2(layout: Layout, col1: UInt32, col2: UInt32, exp: Float32): Unit

    func layout_hexpand3(layout: Layout, col1: UInt32, col2: UInt32, col3: UInt32, exp1: Float32, exp2: Float32): Unit

    func layout_hexpandn(layout: Layout, n: UInt32, index: CPointer<UInt32>, exp: CPointer<Float32>): Unit

    func layout_vexpand(layout: Layout, row: UInt32): Unit

    func layout_vexpand2(layout: Layout, row1: UInt32, row2: UInt32, exp: Float32): Unit

    func layout_vexpand3(layout: Layout, row1: UInt32, row2: UInt32, row3: UInt32, exp1: Float32, exp2: Float32): Unit

    func layout_vexpandn(layout: Layout, n: UInt32, index: CPointer<UInt32>, exp: CPointer<Float32>): Unit

    func layout_halign(layout: Layout, col: UInt32, row: UInt32, align: Align): Unit

    func layout_valign(layout: Layout, col: UInt32, row: UInt32, align: Align): Unit

    func layout_show_col(layout: Layout, col: UInt32, visible: Bool): Unit

    func layout_show_row(layout: Layout, row: UInt32, visible: Bool): Unit

    func layout_margin(layout: Layout, mall: Float32): Unit

    func layout_margin2(layout: Layout, mtb: Float32, mlr: Float32): Unit

    func layout_margin4(layout: Layout, mt: Float32, mr: Float32, mb: Float32, ml: Float32): Unit

    func layout_bgcolor(layout: Layout, color: Color): Unit

    func layout_skcolor(layout: Layout, color: Color): Unit

    func layout_update(layout: Layout): Unit
}

@C
public struct Layout {
    private var m_handle: CPointer<Unit>

    public init(nCols: UInt32, nRows: UInt32) {
        m_handle = unsafe { layout_create(nCols, nRows) }
    }

    public func createCell(col: UInt32, row: UInt32): Cell {
        Cell(this, col, row)
    }

    // Getters for dimensions

    public func numCols(): UInt32 {
        unsafe { layout_ncols(this) }
    }

    public func numRows(): UInt32 {
        unsafe { layout_nrows(this) }
    }

    public func add(obj: Button, col: UInt32, row: UInt32): Unit {
        unsafe { layout_button(this, obj, col, row) }
    }

    public func add(obj: ImageView, col: UInt32, row: UInt32): Unit {
        unsafe { layout_imageview(this, obj, col, row) }
    }

    public func add(obj: Label, col: UInt32, row: UInt32): Unit {
        unsafe { layout_label(this, obj, col, row) }
    }

    public func add(obj: Layout, col: UInt32, row: UInt32): Unit {
        unsafe { layout_layout(this, obj, col, row) }
    }

    public func add(obj: PopUp, col: UInt32, row: UInt32): Unit {
        unsafe { layout_popup(this, obj, col, row) }
    }

    public func add(obj: Edit, col: UInt32, row: UInt32): Unit {
        unsafe { layout_edit(this, obj, col, row) }
    }

    public func add(obj: Slider, col: UInt32, row: UInt32): Unit {
        unsafe { layout_slider(this, obj, col, row) }
    }

    public func add(obj: TextView, col: UInt32, row: UInt32): Unit {
        unsafe { layout_textview(this, obj, col, row) }
    }

    public func add(obj: View, col: UInt32, row: UInt32): Unit {
        unsafe { layout_view(this, obj, col, row) }
    }

    // Sizing

    public func setHSize(col: UInt32, width: Float32): Unit {
        unsafe { layout_hsize(this, col, width) }
    }

    public func setVSize(row: UInt32, height: Float32): Unit {
        unsafe { layout_vsize(this, row, height) }
    }

    // Margins

    public func setMargin(margin: Float32): Unit {
        unsafe { layout_margin(this, margin) }
    }

    public func setMargin(tmb: Float32, mlr: Float32): Unit {
        unsafe { layout_margin2(this, tmb, mlr) }
    }

    public func setMargin(mt: Float32, mr: Float32, mb: Float32, ml: Float32): Unit {
        unsafe { layout_margin4(this, mt, mr, mb, ml) }
    }

    public func setHMargin(col: UInt32, margin: Float32): Unit {
        unsafe { layout_hmargin(this, col, margin) }
    }

    public func setVMargin(row: UInt32, margin: Float32): Unit {
        unsafe { layout_vmargin(this, row, margin) }
    }

    // Expansion

    public func hExpand(col: UInt32): Unit {
        unsafe { layout_hexpand(this, col) }
    }

    public func hExpand2(col1: UInt32, col2: UInt32, exp: Float32): Unit {
        unsafe { layout_hexpand2(this, col1, col2, exp) }
    }

    public func hExpand3(col1: UInt32, col2: UInt32, col3: UInt32, exp1: Float32, exp2: Float32): Unit {
        unsafe { layout_hexpand3(this, col1, col2, col3, exp1, exp2) }
    }

    public func vExpand(row: UInt32): Unit {
        unsafe { layout_vexpand(this, row) }
    }

    public func vExpand2(row1: UInt32, row2: UInt32, exp: Float32): Unit {
        unsafe { layout_vexpand2(this, row1, row2, exp) }
    }

    public func vExpand3(row1: UInt32, row2: UInt32, row3: UInt32, exp1: Float32, exp2: Float32): Unit {
        unsafe { layout_vexpand3(this, row1, row2, row3, exp1, exp2) }
    }

    // Alignment

    public func setHAlign(col: UInt32, row: UInt32, align: Align): Unit {
        unsafe { layout_halign(this, col, row, align) }
    }

    public func setVAlign(col: UInt32, row: UInt32, align: Align): Unit {
        unsafe { layout_valign(this, col, row, align) }
    }

    // Visibility

    public func showCol(col: UInt32, visible: Bool): Unit {
        unsafe { layout_show_col(this, col, visible) }
    }

    public func showRow(row: UInt32, visible: Bool): Unit {
        unsafe { layout_show_row(this, row, visible) }
    }

    // Insert/Remove

    public func insertCol(col: UInt32): Unit {
        unsafe { layout_insert_col(this, col) }
    }

    public func insertRow(row: UInt32): Unit {
        unsafe { layout_insert_row(this, row) }
    }

    public func removeCol(col: UInt32): Unit {
        unsafe { layout_remove_col(this, col) }
    }

    public func removeRow(row: UInt32): Unit {
        unsafe { layout_remove_row(this, row) }
    }

    // Appearance

    public func setBgColor(color: Color): Unit {
        unsafe { layout_bgcolor(this, color) }
    }

    public func update(): Unit {
        unsafe { layout_update(this) }
    }
}
