package nappgui4cj

import nappgui4cj.macros.EventHandler

foreign {
    func tableview_create(): CPointer<Unit>

    func tableview_OnData(view: CPointer<Unit>, listener: Listener): Unit

    func tableview_OnSelect(view: CPointer<Unit>, listener: Listener): Unit

    func tableview_OnRowClick(view: CPointer<Unit>, listener: Listener): Unit

    func tableview_OnHeaderClick(view: CPointer<Unit>, listener: Listener): Unit

    func tableview_font(view: CPointer<Unit>, font: CPointer<Unit>): Unit

    func tableview_size(view: CPointer<Unit>, size: S2Df): Unit

    func tableview_add_column_text(view: CPointer<Unit>): UInt32

    func tableview_del_column(view: CPointer<Unit>, column_id: UInt32): Unit

    func tableview_column_count(view: CPointer<Unit>): UInt32

    func tableview_column_icon(view: CPointer<Unit>, column_id: UInt32, icon_height: Float32, hmargin: Float32): Unit

    func tableview_column_width(view: CPointer<Unit>, column_id: UInt32, width: Float32): Unit

    func tableview_column_limits(view: CPointer<Unit>, column_id: UInt32, min: Float32, max: Float32): Unit

    func tableview_column_align(view: CPointer<Unit>, column_id: UInt32, align: Align): Unit

    func tableview_column_resizable(view: CPointer<Unit>, column_id: UInt32, resizable: Bool): Unit

    func tableview_column_freeze(view: CPointer<Unit>, last_column_id: UInt32): Unit

    func tableview_header_title(view: CPointer<Unit>, column_id: UInt32, text: CString): Unit

    func tableview_header_align(view: CPointer<Unit>, column_id: UInt32, align: Align): Unit

    func tableview_header_indicator(view: CPointer<Unit>, column_id: UInt32, indicator: UInt32): Unit

    func tableview_header_visible(view: CPointer<Unit>, visible: Bool): Unit

    func tableview_header_clickable(view: CPointer<Unit>, clickable: Bool): Unit

    func tableview_header_resizable(view: CPointer<Unit>, resizable: Bool): Unit

    func tableview_header_height(view: CPointer<Unit>, height: Float32): Unit

    func tableview_row_height(view: CPointer<Unit>, height: Float32): Unit

    func tableview_hkey_scroll(view: CPointer<Unit>, force_column: Bool, scroll: Float32): Unit

    func tableview_multisel(view: CPointer<Unit>, multisel: Bool, preserve: Bool): Unit

    func tableview_grid(view: CPointer<Unit>, hlines: Bool, vlines: Bool): Unit

    func tableview_update(view: CPointer<Unit>): Unit

    func tableview_select(view: CPointer<Unit>, rows: CPointer<UInt32>, n: UInt32): Unit

    func tableview_deselect(view: CPointer<Unit>, rows: CPointer<UInt32>, n: UInt32): Unit

    func tableview_deselect_all(view: CPointer<Unit>): Unit

    func tableview_selected(view: CPointer<Unit>): CPointer<Unit>

    func tableview_focus_row(view: CPointer<Unit>, row: UInt32, align: Align): Unit

    func tableview_get_focus_row(view: CPointer<Unit>): UInt32

    func tableview_scroll_visible(view: CPointer<Unit>, horizontal: Bool, vertical: Bool): Unit
}

public class TableView <: GuiControl {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init() {
        m_handle = unsafe { tableview_create() }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func create(handle: CPointer<Unit>): TableView {
        TableView(handle)
    }

    @EventHandler(tableview_OnData)

    @EventHandler(tableview_OnSelect)

    @EventHandler(tableview_OnRowClick)

    @EventHandler(tableview_OnHeaderClick)

    public func setFont(font: Font): Unit {
        unsafe { tableview_font(m_handle, font.m_handle) }
    }

    public func setSize(size: S2Df): Unit {
        unsafe { tableview_size(m_handle, size) }
    }

    public func addColumnText(): UInt32 {
        unsafe { tableview_add_column_text(m_handle) }
    }

    public func delColumn(columnId: UInt32): Unit {
        unsafe { tableview_del_column(m_handle, columnId) }
    }

    public func columnCount(): UInt32 {
        unsafe { tableview_column_count(m_handle) }
    }

    public func columnIcon(columnId: UInt32, iconHeight: Float32, hmargin: Float32): Unit {
        unsafe { tableview_column_icon(m_handle, columnId, iconHeight, hmargin) }
    }

    public func columnWidth(columnId: UInt32, width: Float32): Unit {
        unsafe { tableview_column_width(m_handle, columnId, width) }
    }

    public func columnLimits(columnId: UInt32, min: Float32, max: Float32): Unit {
        unsafe { tableview_column_limits(m_handle, columnId, min, max) }
    }

    public func columnAlign(columnId: UInt32, align: Align): Unit {
        unsafe { tableview_column_align(m_handle, columnId, align) }
    }

    public func columnResizable(columnId: UInt32, resizable: Bool): Unit {
        unsafe { tableview_column_resizable(m_handle, columnId, resizable) }
    }

    public func columnFreeze(lastColumnId: UInt32): Unit {
        unsafe { tableview_column_freeze(m_handle, lastColumnId) }
    }

    public func headerTitle(columnId: UInt32, text: String): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            tableview_header_title(m_handle, columnId, strPtr)
            LibC.free(strPtr)
        }
    }

    public func headerAlign(columnId: UInt32, align: Align): Unit {
        unsafe { tableview_header_align(m_handle, columnId, align) }
    }

    public func headerIndicator(columnId: UInt32, indicator: Indicator): Unit {
        unsafe { tableview_header_indicator(m_handle, columnId, indicator.value) }
    }

    public func headerVisible(visible: Bool): Unit {
        unsafe { tableview_header_visible(m_handle, visible) }
    }

    public func headerClickable(clickable: Bool): Unit {
        unsafe { tableview_header_clickable(m_handle, clickable) }
    }

    public func headerResizable(resizable: Bool): Unit {
        unsafe { tableview_header_resizable(m_handle, resizable) }
    }

    public func headerHeight(height: Float32): Unit {
        unsafe { tableview_header_height(m_handle, height) }
    }

    public func rowHeight(height: Float32): Unit {
        unsafe { tableview_row_height(m_handle, height) }
    }

    public func hkeyScroll(forceColumn: Bool, scroll: Float32): Unit {
        unsafe { tableview_hkey_scroll(m_handle, forceColumn, scroll) }
    }

    public func multisel(multisel: Bool, preserve: Bool): Unit {
        unsafe { tableview_multisel(m_handle, multisel, preserve) }
    }

    public func grid(hlines: Bool, vlines: Bool): Unit {
        unsafe { tableview_grid(m_handle, hlines, vlines) }
    }

    public func update(): Unit {
        unsafe { tableview_update(m_handle) }
    }

    public func select(rows: Array<UInt32>): Unit {
        if (rows.isEmpty()) {
            return
        }
        unsafe {
            let rawData = acquireArrayRawData(rows)
            tableview_select(m_handle, rawData.pointer, UInt32(rows.size))
            releaseArrayRawData(rawData)
        }
    }

    public func deselect(rows: Array<UInt32>): Unit {
        if (rows.isEmpty()) {
            return
        }
        unsafe {
            let rawData = acquireArrayRawData(rows)
            tableview_deselect(m_handle, rawData.pointer, UInt32(rows.size))
            releaseArrayRawData(rawData)
        }
    }

    public func deselectAll(): Unit {
        unsafe { tableview_deselect_all(m_handle) }
    }

    public func selected(): Array<UInt32> {
        unsafe { NArray<UInt32>(tableview_selected(m_handle)).toArray() }
    }

    public func focusRow(row: UInt32, hint: Align): Unit {
        unsafe { tableview_focus_row(m_handle, row, hint) }
    }

    public func getFocusRow(): UInt32 {
        unsafe { tableview_get_focus_row(m_handle) }
    }

    public func scrollVisible(horizontal: Bool, vertical: Bool): Unit {
        unsafe { tableview_scroll_visible(m_handle, horizontal, vertical) }
    }
}
