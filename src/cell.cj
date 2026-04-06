package nappgui4cj

foreign {
    func cell_empty(cell: CPointer<Unit>): Bool

    func cell_control(cell: CPointer<Unit>): CPointer<Unit>

    func cell_label(cell: CPointer<Unit>): CPointer<Unit>

    func cell_button(cell: CPointer<Unit>): CPointer<Unit>

    func cell_popup(cell: CPointer<Unit>): CPointer<Unit>

    func cell_edit(cell: CPointer<Unit>): CPointer<Unit>

    func cell_combo(cell: CPointer<Unit>): CPointer<Unit>

    func cell_listbox(cell: CPointer<Unit>): CPointer<Unit>

    func cell_updown(cell: CPointer<Unit>): CPointer<Unit>

    func cell_slider(cell: CPointer<Unit>): CPointer<Unit>

    func cell_progress(cell: CPointer<Unit>): CPointer<Unit>

    func cell_view(cell: CPointer<Unit>): CPointer<Unit>

    func cell_textview(cell: CPointer<Unit>): CPointer<Unit>

    func cell_webview(cell: CPointer<Unit>): CPointer<Unit>

    func cell_imageview(cell: CPointer<Unit>): CPointer<Unit>

    func cell_tableview(cell: CPointer<Unit>): CPointer<Unit>

    func cell_splitview(cell: CPointer<Unit>): CPointer<Unit>

    func cell_panel(cell: CPointer<Unit>): CPointer<Unit>

    func cell_line(cell: CPointer<Unit>): CPointer<Unit>

    func cell_layout(cell: CPointer<Unit>): CPointer<Unit>

    func cell_enabled(cell: CPointer<Unit>, enabled: Bool): Unit

    func cell_visible(cell: CPointer<Unit>, visible: Bool): Unit

    func cell_padding(cell: CPointer<Unit>, pall: Float32): Unit

    func cell_padding2(cell: CPointer<Unit>, ptb: Float32, plr: Float32): Unit

    func cell_padding4(cell: CPointer<Unit>, pt: Float32, pr: Float32, pb: Float32, pl: Float32): Unit

    func cell_dbind_imp(cell: CPointer<Unit>, typeName: CString, size: UInt16, mname: CString, mtype: CString,
        moffset: UInt16, msize: UInt16): Unit
}

public struct Cell <: NappObject {
    var m_handle: CPointer<Unit>

    public init(layout: Layout, col: UInt32, row: UInt32) {
        m_handle = unsafe { layout_cell(layout.m_handle, col, row) }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public func getControl<T>(): T where T <: GuiControl {
        T.create(unsafe { cell_control(m_handle) }) as T ?? throw IllegalStateException("Unable to cast GuiControl")
    }

    public func isEmpty(): Bool {
        unsafe { cell_empty(m_handle) }
    }

    public func setEnabled(enabled: Bool): Unit {
        unsafe { cell_enabled(m_handle, enabled) }
    }

    public func setVisible(visible: Bool): Unit {
        unsafe { cell_visible(m_handle, visible) }
    }

    public func setPadding(padding: Float32): Unit {
        unsafe { cell_padding(m_handle, padding) }
    }

    public func setPadding(ptb: Float32, plr: Float32): Unit {
        unsafe { cell_padding2(m_handle, ptb, plr) }
    }

    public func setPadding(pt: Float32, pr: Float32, pb: Float32, pl: Float32): Unit {
        unsafe { cell_padding4(m_handle, pt, pr, pb, pl) }
    }

    public func getLabel(): Label {
        unsafe { Label(cell_label(m_handle)) }
    }

    public func getButton(): Button {
        unsafe { Button(cell_button(m_handle)) }
    }

    public func getPopUp(): PopUp {
        unsafe { PopUp(cell_popup(m_handle)) }
    }

    public func getSlider(): Slider {
        unsafe { Slider(cell_slider(m_handle)) }
    }

    public func getView(): View {
        unsafe { View(cell_view(m_handle)) }
    }

    public func getTextView(): TextView {
        unsafe { TextView(cell_textview(m_handle)) }
    }

    public func getImageView(): ImageView {
        unsafe { ImageView(cell_imageview(m_handle)) }
    }

    public func getLayout(): Layout {
        unsafe { Layout(cell_layout(m_handle)) }
    }

    public func dbind(
        structType!: String,
        structSize!: UInt16,
        memberName!: String,
        memberType!: String,
        memberOffset!: UInt16,
        memberSize!: UInt16
    ): Unit {
        unsafe {
            let structTypePtr = LibC.mallocCString(structType)
            let memberNamePtr = LibC.mallocCString(memberName)
            let memberTypePtr = LibC.mallocCString(memberType)
            cell_dbind_imp(
                m_handle,
                structTypePtr,
                structSize,
                memberNamePtr,
                memberTypePtr,
                memberOffset,
                memberSize
            )
            LibC.free(structTypePtr)
            LibC.free(memberNamePtr)
            LibC.free(memberTypePtr)
        }
    }
}
