package nappgui4cj

foreign {
    func cell_empty(cell: Cell): Bool

    // Getters for controls (returning specific handle types)

    func cell_control(cell: Cell): CPointer<Unit>

    func cell_label(cell: Cell): Label

    func cell_button(cell: Cell): Button

    func cell_popup(cell: Cell): PopUp

    func cell_edit(cell: Cell): CPointer<Unit>

    func cell_combo(cell: Cell): CPointer<Unit>

    func cell_listbox(cell: Cell): CPointer<Unit>

    func cell_updown(cell: Cell): CPointer<Unit>

    func cell_slider(cell: Cell): Slider

    func cell_progress(cell: Cell): CPointer<Unit>

    func cell_view(cell: Cell): View

    func cell_textview(cell: Cell): TextView

    func cell_webview(cell: Cell): CPointer<Unit>

    func cell_imageview(cell: Cell): ImageView

    func cell_tableview(cell: Cell): CPointer<Unit>

    func cell_splitview(cell: Cell): CPointer<Unit>

    func cell_panel(cell: Cell): CPointer<Unit>

    func cell_layout(cell: Cell): Layout

    // State manipulation

    func cell_enabled(cell: Cell, enabled: Bool): Unit

    func cell_visible(cell: Cell, visible: Bool): Unit

    // Padding

    func cell_padding(cell: Cell, pall: Float32): Unit

    func cell_padding2(cell: Cell, ptb: Float32, plr: Float32): Unit

    func cell_padding4(cell: Cell, pt: Float32, pr: Float32, pb: Float32, pl: Float32): Unit
}

@C
public struct Cell {
    private var m_handle: CPointer<Unit>

    public init(layout: Layout, col: UInt32, row: UInt32) {
        m_handle = unsafe { layout_cell(layout, col, row) }
    }

    public func isEmpty(): Bool {
        unsafe { cell_empty(this) }
    }

    public func setEnabled(enabled: Bool): Unit {
        unsafe { cell_enabled(this, enabled) }
    }

    public func setVisible(visible: Bool): Unit {
        unsafe { cell_visible(this, visible) }
    }

    public func setPadding(padding: Float32): Unit {
        unsafe { cell_padding(this, padding) }
    }

    public func setPadding(ptb: Float32, plr: Float32): Unit {
        unsafe { cell_padding2(this, ptb, plr) }
    }

    public func setPadding(pt: Float32, pr: Float32, pb: Float32, pl: Float32): Unit {
        unsafe { cell_padding4(this, pt, pr, pb, pl) }
    }

    // Getters for specific control types that are wrapped in the library

    public func getLabel(): Label {
        unsafe { cell_label(this) }
    }

    public func getButton(): Button {
        unsafe { cell_button(this) }
    }

    public func getPopUp(): PopUp {
        unsafe { cell_popup(this) }
    }

    public func getSlider(): Slider {
        unsafe { cell_slider(this) }
    }

    public func getView(): View {
        unsafe { cell_view(this) }
    }

    public func getTextView(): TextView {
        unsafe { cell_textview(this) }
    }

    public func getImageView(): ImageView {
        unsafe { cell_imageview(this) }
    }

    public func getLayout(): Layout {
        unsafe { cell_layout(this) }
    }
}
