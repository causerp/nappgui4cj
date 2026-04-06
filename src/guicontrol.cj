package nappgui4cj

foreign {
    @FastNative
    func guicontrol_button(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_combo(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_edit(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_imageview(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_label(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_line(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_listbox(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_panel(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_popup(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_progress(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_slider(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_splitview(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_tableview(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_textview(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_updown(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_view(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_webview(control: CPointer<Unit>): CPointer<Unit>

    @FastNative
    func guicontrol_get_tag(control: CPointer<Unit>): UInt32

    @FastNative
    func guicontrol_tag(control: CPointer<Unit>, tag: UInt32): Unit
}

sealed interface GuiControl <: NappObject {
    static func create(handle: CPointer<Unit>): GuiControl

    static func toButton(obj: GuiControl): ?Button {
        match (unsafe { guicontrol_button(obj.handle) }) {
            case ptr where ptr.isNotNull() => Button(ptr)
            case _ => None
        }
    }

    static func toCombo(obj: GuiControl): ?Combo {
        match (unsafe { guicontrol_combo(obj.handle) }) {
            case ptr where ptr.isNotNull() => Combo(ptr)
            case _ => None
        }
    }

    static func toEdit(obj: GuiControl): ?Edit {
        match (unsafe { guicontrol_edit(obj.handle) }) {
            case ptr where ptr.isNotNull() => Edit(ptr)
            case _ => None
        }
    }

    static func toImageView(obj: GuiControl): ?ImageView {
        match (unsafe { guicontrol_imageview(obj.handle) }) {
            case ptr where ptr.isNotNull() => ImageView(ptr)
            case _ => None
        }
    }

    static func toLabel(obj: GuiControl): ?Label {
        match (unsafe { guicontrol_label(obj.handle) }) {
            case ptr where ptr.isNotNull() => Label(ptr)
            case _ => None
        }
    }

    static func toLine(obj: GuiControl): ?Line {
        match (unsafe { guicontrol_line(obj.handle) }) {
            case ptr where ptr.isNotNull() => Line(ptr)
            case _ => None
        }
    }

    static func toListBox(obj: GuiControl): ?ListBox {
        match (unsafe { guicontrol_listbox(obj.handle) }) {
            case ptr where ptr.isNotNull() => ListBox(ptr)
            case _ => None
        }
    }

    static func toPanel(obj: GuiControl): ?Panel {
        match (unsafe { guicontrol_panel(obj.handle) }) {
            case ptr where ptr.isNotNull() => Panel(ptr)
            case _ => None
        }
    }

    static func toPopUp(obj: GuiControl): ?PopUp {
        match (unsafe { guicontrol_popup(obj.handle) }) {
            case ptr where ptr.isNotNull() => PopUp(ptr)
            case _ => None
        }
    }

    static func toProgress(obj: GuiControl): ?Progress {
        match (unsafe { guicontrol_progress(obj.handle) }) {
            case ptr where ptr.isNotNull() => Progress(ptr)
            case _ => None
        }
    }

    static func toSlider(obj: GuiControl): ?Slider {
        match (unsafe { guicontrol_slider(obj.handle) }) {
            case ptr where ptr.isNotNull() => Slider(ptr)
            case _ => None
        }
    }

    static func toSplitView(obj: GuiControl): ?SplitView {
        match (unsafe { guicontrol_splitview(obj.handle) }) {
            case ptr where ptr.isNotNull() => SplitView(ptr)
            case _ => None
        }
    }

    static func toTableView(obj: GuiControl): ?TableView {
        match (unsafe { guicontrol_tableview(obj.handle) }) {
            case ptr where ptr.isNotNull() => TableView(ptr)
            case _ => None
        }
    }

    static func toTextView(obj: GuiControl): ?TextView {
        match (unsafe { guicontrol_textview(obj.handle) }) {
            case ptr where ptr.isNotNull() => TextView(ptr)
            case _ => None
        }
    }

    static func toUpDown(obj: GuiControl): ?UpDown {
        match (unsafe { guicontrol_updown(obj.handle) }) {
            case ptr where ptr.isNotNull() => UpDown(ptr)
            case _ => None
        }
    }

    static func toView(obj: GuiControl): ?View {
        match (unsafe { guicontrol_view(obj.handle) }) {
            case ptr where ptr.isNotNull() => View(ptr)
            case _ => None
        }
    }

    // static func toWebView(obj: GuiControl): ?WebView {
    //     match (unsafe { guicontrol_webview(obj.handle) }) {
    //         case ptr where ptr.isNotNull() => WebView(ptr)
    //         case _ => None
    //     }
    // }

    func getTag(): UInt32 {
        unsafe { guicontrol_get_tag(this.handle) }
    }

    func setTag(tag: UInt32): Unit {
        unsafe { guicontrol_tag(this.handle, tag) }
    }
}
