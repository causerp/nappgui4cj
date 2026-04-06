package nappgui4cj

foreign {
    func layout_create(columns: UInt32, rows: UInt32): CPointer<Unit>

    func layout_cell(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_control(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_label(layout: CPointer<Unit>, label: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_button(layout: CPointer<Unit>, button: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_popup(layout: CPointer<Unit>, popup: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_edit(layout: CPointer<Unit>, edit: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_combo(layout: CPointer<Unit>, combo: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_listbox(layout: CPointer<Unit>, list: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_updown(layout: CPointer<Unit>, updown: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_slider(layout: CPointer<Unit>, slider: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_progress(layout: CPointer<Unit>, progress: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_view(layout: CPointer<Unit>, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_textview(layout: CPointer<Unit>, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_webview(layout: CPointer<Unit>, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_imageview(layout: CPointer<Unit>, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_tableview(layout: CPointer<Unit>, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_splitview(layout: CPointer<Unit>, view: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_panel(layout: CPointer<Unit>, panel: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_panel_replace(layout: CPointer<Unit>, panel: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_line(layout: CPointer<Unit>, panel: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_layout(layout: CPointer<Unit>, sublayout: CPointer<Unit>, col: UInt32, row: UInt32): Unit

    func layout_get_label(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_button(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_popup(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_edit(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_combo(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_listbox(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_updown(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_slider(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_progress(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_view(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_textview(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_webview(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_imageview(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_tableview(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_splitview(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_panel(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_line(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_get_layout(layout: CPointer<Unit>, col: UInt32, row: UInt32): CPointer<Unit>

    func layout_ncols(layout: CPointer<Unit>): UInt32

    func layout_nrows(layout: CPointer<Unit>): UInt32

    func layout_insert_col(layout: CPointer<Unit>, col: UInt32): Unit

    func layout_insert_row(layout: CPointer<Unit>, row: UInt32): Unit

    func layout_remove_col(layout: CPointer<Unit>, col: UInt32): Unit

    func layout_remove_row(layout: CPointer<Unit>, row: UInt32): Unit

    func layout_taborder(layout: CPointer<Unit>, order: GUIOrient): Unit

    func layout_tabstop(layout: CPointer<Unit>, col: UInt32, row: UInt32, tabstop: Bool): Unit

    func layout_hsize(layout: CPointer<Unit>, col: UInt32, width: Float32): Unit

    func layout_vsize(layout: CPointer<Unit>, row: UInt32, height: Float32): Unit

    func layout_hmargin(layout: CPointer<Unit>, col: UInt32, margin: Float32): Unit

    func layout_vmargin(layout: CPointer<Unit>, row: UInt32, margin: Float32): Unit

    func layout_hexpand(layout: CPointer<Unit>, col: UInt32): Unit

    func layout_hexpand2(layout: CPointer<Unit>, col1: UInt32, col2: UInt32, exp: Float32): Unit

    func layout_hexpand3(layout: CPointer<Unit>, col1: UInt32, col2: UInt32, col3: UInt32, exp1: Float32, exp2: Float32): Unit

    func layout_hexpandn(layout: CPointer<Unit>, n: UInt32, index: CPointer<UInt32>, exp: CPointer<Float32>): Unit

    func layout_vexpand(layout: CPointer<Unit>, row: UInt32): Unit

    func layout_vexpand2(layout: CPointer<Unit>, row1: UInt32, row2: UInt32, exp: Float32): Unit

    func layout_vexpand3(layout: CPointer<Unit>, row1: UInt32, row2: UInt32, row3: UInt32, exp1: Float32, exp2: Float32): Unit

    func layout_vexpandn(layout: CPointer<Unit>, n: UInt32, index: CPointer<UInt32>, exp: CPointer<Float32>): Unit

    func layout_halign(layout: CPointer<Unit>, col: UInt32, row: UInt32, align: Align): Unit

    func layout_valign(layout: CPointer<Unit>, col: UInt32, row: UInt32, align: Align): Unit

    func layout_show_col(layout: CPointer<Unit>, col: UInt32, visible: Bool): Unit

    func layout_show_row(layout: CPointer<Unit>, row: UInt32, visible: Bool): Unit

    func layout_margin(layout: CPointer<Unit>, mall: Float32): Unit

    func layout_margin2(layout: CPointer<Unit>, mtb: Float32, mlr: Float32): Unit

    func layout_margin4(layout: CPointer<Unit>, mt: Float32, mr: Float32, mb: Float32, ml: Float32): Unit

    func layout_bgcolor(layout: CPointer<Unit>, color: Color): Unit

    func layout_skcolor(layout: CPointer<Unit>, color: Color): Unit

    func layout_update(layout: CPointer<Unit>): Unit

    func layout_dbind_imp(layout: CPointer<Unit>, listener: Listener, typeName: CString, size: UInt16): Unit

    func layout_dbind_obj_imp(layout: CPointer<Unit>, obj: CPointer<Unit>, typeName: CString): Unit

    func layout_dbind_get_obj_imp(layout: CPointer<Unit>, typeName: CString): CPointer<Unit>

    func layout_dbind_update_imp(layout: CPointer<Unit>, typeName: CString, size: UInt16, mname: CString,
        mtypeName: CString, moffset: UInt16, msize: UInt16): CPointer<Unit>
}

public struct Layout <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(nCols: UInt32, nRows: UInt32) {
        m_handle = unsafe { layout_create(nCols, nRows) }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func createCell(col: UInt32, row: UInt32): Cell {
        Cell(this, col, row)
    }

    public func getControl<T>(col: UInt32, row: UInt32): T where T <: GuiControl {
        T.create(unsafe { layout_control(m_handle, col, row) }) as T ?? throw IllegalStateException(
            "Unable to cast GuiControl")
    }

    public func numCols(): UInt32 {
        unsafe { layout_ncols(m_handle) }
    }

    public func numRows(): UInt32 {
        unsafe { layout_nrows(m_handle) }
    }

    public func add(obj: Button, col: UInt32, row: UInt32): Unit {
        unsafe { layout_button(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Combo, col: UInt32, row: UInt32): Unit {
        unsafe { layout_combo(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Edit, col: UInt32, row: UInt32): Unit {
        unsafe { layout_edit(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: ImageView, col: UInt32, row: UInt32): Unit {
        unsafe { layout_imageview(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Label, col: UInt32, row: UInt32): Unit {
        unsafe { layout_label(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Layout, col: UInt32, row: UInt32): Unit {
        unsafe { layout_layout(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Line, col: UInt32, row: UInt32): Unit {
        unsafe { layout_line(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: ListBox, col: UInt32, row: UInt32): Unit {
        unsafe { layout_listbox(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Panel, col: UInt32, row: UInt32): Unit {
        unsafe { layout_panel(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: PopUp, col: UInt32, row: UInt32): Unit {
        unsafe { layout_popup(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Progress, col: UInt32, row: UInt32): Unit {
        unsafe { layout_progress(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: Slider, col: UInt32, row: UInt32): Unit {
        unsafe { layout_slider(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: SplitView, col: UInt32, row: UInt32): Unit {
        unsafe { layout_splitview(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: TableView, col: UInt32, row: UInt32): Unit {
        unsafe { layout_tableview(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: TextView, col: UInt32, row: UInt32): Unit {
        unsafe { layout_textview(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: UpDown, col: UInt32, row: UInt32): Unit {
        unsafe { layout_updown(m_handle, obj.m_handle, col, row) }
    }

    public func add(obj: View, col: UInt32, row: UInt32): Unit {
        unsafe { layout_view(m_handle, obj.m_handle, col, row) }
    }

    public func getButton(col: UInt32, row: UInt32): ?Button {
        match (unsafe { layout_get_button(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Button(ptr)
            case _ => None
        }
    }

    public func getCombo(col: UInt32, row: UInt32): ?Combo {
        match (unsafe { layout_get_combo(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Combo(ptr)
            case _ => None
        }
    }

    public func getEdit(col: UInt32, row: UInt32): ?Edit {
        match (unsafe { layout_get_edit(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Edit(ptr)
            case _ => None
        }
    }

    public func getImageView(col: UInt32, row: UInt32): ?ImageView {
        match (unsafe { layout_get_imageview(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => ImageView(ptr)
            case _ => None
        }
    }

    public func getLabel(col: UInt32, row: UInt32): ?Label {
        match (unsafe { layout_get_label(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Label(ptr)
            case _ => None
        }
    }

    public func getLayout(col: UInt32, row: UInt32): ?Layout {
        match (unsafe { layout_get_layout(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Layout(ptr)
            case _ => None
        }
    }

    public func getLine(col: UInt32, row: UInt32): ?Line {
        match (unsafe { layout_get_line(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Line(ptr)
            case _ => None
        }
    }

    public func getListBox(col: UInt32, row: UInt32): ?ListBox {
        match (unsafe { layout_get_listbox(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => ListBox(ptr)
            case _ => None
        }
    }

    public func getPanel(col: UInt32, row: UInt32): ?Panel {
        match (unsafe { layout_get_panel(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Panel(ptr)
            case _ => None
        }
    }

    public func getPopUp(col: UInt32, row: UInt32): ?PopUp {
        match (unsafe { layout_get_popup(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => PopUp(ptr)
            case _ => None
        }
    }

    public func getProgress(col: UInt32, row: UInt32): ?Progress {
        match (unsafe { layout_get_progress(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Progress(ptr)
            case _ => None
        }
    }

    public func getSlider(col: UInt32, row: UInt32): ?Slider {
        match (unsafe { layout_get_slider(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => Slider(ptr)
            case _ => None
        }
    }

    public func getSplitView(col: UInt32, row: UInt32): ?SplitView {
        match (unsafe { layout_get_splitview(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => SplitView(ptr)
            case _ => None
        }
    }

    public func getTableView(col: UInt32, row: UInt32): ?TableView {
        match (unsafe { layout_get_tableview(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => TableView(ptr)
            case _ => None
        }
    }

    public func getTextView(col: UInt32, row: UInt32): ?TextView {
        match (unsafe { layout_get_textview(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => TextView(ptr)
            case _ => None
        }
    }

    public func getUpDown(col: UInt32, row: UInt32): ?UpDown {
        match (unsafe { layout_get_updown(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => UpDown(ptr)
            case _ => None
        }
    }

    public func getView(col: UInt32, row: UInt32): ?View {
        match (unsafe { layout_get_view(m_handle, col, row) }) {
            case ptr where ptr.isNotNull() => View(ptr)
            case _ => None
        }
    }

    // public func getWebView(col: UInt32, row: UInt32): ?WebView {
    //     match (unsafe { layout_get_webview(m_handle, col, row) }) {
    //         case ptr where ptr.isNotNull() => WebView(ptr)
    //         case _ => None
    //     }
    // }

    public func replace(obj: Panel, col: UInt32, row: UInt32): Unit {
        unsafe { layout_panel_replace(m_handle, obj.m_handle, col, row) }
    }

    public func setTabOrder(order: GUIOrient): Unit {
        unsafe { layout_taborder(m_handle, order) }
    }

    public func setTabStop(col: UInt32, row: UInt32, tabstop: Bool): Unit {
        unsafe { layout_tabstop(m_handle, col, row, tabstop) }
    }

    public func setHSize(col: UInt32, width: Float32): Unit {
        unsafe { layout_hsize(m_handle, col, width) }
    }

    public func setVSize(row: UInt32, height: Float32): Unit {
        unsafe { layout_vsize(m_handle, row, height) }
    }

    public func setMargin(margin: Float32): Unit {
        unsafe { layout_margin(m_handle, margin) }
    }

    public func setMargin(tmb: Float32, mlr: Float32): Unit {
        unsafe { layout_margin2(m_handle, tmb, mlr) }
    }

    public func setMargin(mt: Float32, mr: Float32, mb: Float32, ml: Float32): Unit {
        unsafe { layout_margin4(m_handle, mt, mr, mb, ml) }
    }

    public func setHMargin(col: UInt32, margin: Float32): Unit {
        unsafe { layout_hmargin(m_handle, col, margin) }
    }

    public func setVMargin(row: UInt32, margin: Float32): Unit {
        unsafe { layout_vmargin(m_handle, row, margin) }
    }

    public func hExpand(col: UInt32): Unit {
        unsafe { layout_hexpand(m_handle, col) }
    }

    public func hExpand2(col1: UInt32, col2: UInt32, exp: Float32): Unit {
        unsafe { layout_hexpand2(m_handle, col1, col2, exp) }
    }

    public func hExpand3(col1: UInt32, col2: UInt32, col3: UInt32, exp1: Float32, exp2: Float32): Unit {
        unsafe { layout_hexpand3(m_handle, col1, col2, col3, exp1, exp2) }
    }

    public func vExpand(row: UInt32): Unit {
        unsafe { layout_vexpand(m_handle, row) }
    }

    public func vExpand2(row1: UInt32, row2: UInt32, exp: Float32): Unit {
        unsafe { layout_vexpand2(m_handle, row1, row2, exp) }
    }

    public func vExpand3(row1: UInt32, row2: UInt32, row3: UInt32, exp1: Float32, exp2: Float32): Unit {
        unsafe { layout_vexpand3(m_handle, row1, row2, row3, exp1, exp2) }
    }

    public func setHAlign(col: UInt32, row: UInt32, align: Align): Unit {
        unsafe { layout_halign(m_handle, col, row, align) }
    }

    public func setVAlign(col: UInt32, row: UInt32, align: Align): Unit {
        unsafe { layout_valign(m_handle, col, row, align) }
    }

    public func showCol(col: UInt32, visible: Bool): Unit {
        unsafe { layout_show_col(m_handle, col, visible) }
    }

    public func showRow(row: UInt32, visible: Bool): Unit {
        unsafe { layout_show_row(m_handle, row, visible) }
    }

    public func insertCol(col: UInt32): Unit {
        unsafe { layout_insert_col(m_handle, col) }
    }

    public func insertRow(row: UInt32): Unit {
        unsafe { layout_insert_row(m_handle, row) }
    }

    public func removeCol(col: UInt32): Unit {
        unsafe { layout_remove_col(m_handle, col) }
    }

    public func removeRow(row: UInt32): Unit {
        unsafe { layout_remove_row(m_handle, row) }
    }

    public func setBgColor(color: Color): Unit {
        unsafe { layout_bgcolor(m_handle, color) }
    }

    public func setSkColor(color: Color): Unit {
        unsafe { layout_skcolor(m_handle, color) }
    }

    public func update(): Unit {
        unsafe { layout_update(m_handle) }
    }

    public func bind<T>(
        function: EventHandlerFunc<T>,
        obj!: CPointer<T>,
        typeName!: String,
        typeSize!: UInt16
    ): Unit where T <: CType {
        unsafe {
            let listener = Listener.create(obj, function)
            let tPtr = LibC.mallocCString(typeName)
            layout_dbind_imp(m_handle, listener, tPtr, typeSize)
            LibC.free(tPtr)
        }
    }

    public func bind(
        typeName!: String,
        typeSize!: UInt16
    ): Unit {
        unsafe {
            let listener = Listener(CPointer())
            let tPtr = LibC.mallocCString(typeName)
            layout_dbind_imp(m_handle, listener, tPtr, typeSize)
            LibC.free(tPtr)
        }
    }

    public func bindObj<T>(obj!: CPointer<T>, typeName!: String): Unit where T <: CType {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            layout_dbind_obj_imp(m_handle, CPointer(obj), tPtr)
            LibC.free(tPtr)
        }
    }

    public func bindUpdate(
        typeName!: String,
        typeSize!: UInt16,
        memberName!: String,
        membertypeName!: String,
        memberOffset!: UInt16,
        memberSize!: UInt16
    ): CPointer<Unit> {
        unsafe {
            let tPtr = LibC.mallocCString(typeName)
            let mPtr = LibC.mallocCString(memberName)
            let mtPtr = LibC.mallocCString(membertypeName)
            let res = layout_dbind_update_imp(m_handle, tPtr, typeSize, mPtr, mtPtr, memberOffset, memberSize)
            LibC.free(tPtr)
            LibC.free(mPtr)
            LibC.free(mtPtr)
            return res
        }
    }
}
