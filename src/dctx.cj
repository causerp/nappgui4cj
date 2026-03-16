package nappgui4cj

foreign {
    func dctx_bitmap(width: UInt32, height: UInt32, format: PixFormat): CPointer<Unit>

    func dctx_image(ctx: CPointer<CPointer<Unit>>): CPointer<Unit>

    func draw_clear(ctx: DCtx, color: Color): Unit

    func draw_matrixf(ctx: DCtx, t2d: CPointer<T2Df>): Unit

    func draw_matrixd(ctx: DCtx, t2d: CPointer<T2Dd>): Unit

    func draw_matrix_cartesianf(ctx: DCtx, t2d: CPointer<T2Df>): Unit

    func draw_matrix_cartesiand(ctx: DCtx, t2d: CPointer<T2Dd>): Unit

    func draw_antialias(ctx: DCtx, on: Bool): Unit

    func draw_line(ctx: DCtx, x0: Float32, y0: Float32, x1: Float32, y1: Float32): Unit

    func draw_polyline(ctx: DCtx, closed: Bool, points: CPointer<V2Df>, n: UInt32): Unit

    func draw_arc(ctx: DCtx, x: Float32, y: Float32, radius: Float32, start: Float32, sweep: Float32): Unit

    func draw_bezier(ctx: DCtx, x0: Float32, y0: Float32, x1: Float32, y1: Float32, x2: Float32, y2: Float32,
        x3: Float32, y3: Float32): Unit

    func draw_line_color(ctx: DCtx, color: Color): Unit

    func draw_line_fill(ctx: DCtx): Unit

    func draw_line_width(ctx: DCtx, width: Float32): Unit

    func draw_line_cap(ctx: DCtx, cap: LineCap): Unit

    func draw_line_join(ctx: DCtx, join: LineJoin): Unit

    func draw_line_dash(ctx: DCtx, pattern: CPointer<Float32>, n: UInt32): Unit

    func draw_rect(ctx: DCtx, op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32): Unit

    func draw_rndrect(ctx: DCtx, op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32, radius: Float32): Unit

    func draw_circle(ctx: DCtx, op: DrawOp, x: Float32, y: Float32, radius: Float32): Unit

    func draw_ellipse(ctx: DCtx, op: DrawOp, x: Float32, y: Float32, radx: Float32, rady: Float32): Unit

    func draw_polygon(ctx: DCtx, op: DrawOp, points: CPointer<V2Df>, n: UInt32): Unit

    func draw_fill_color(ctx: DCtx, color: Color): Unit

    func draw_fill_linear(ctx: DCtx, color: CPointer<Color>, stop: CPointer<Float32>, n: UInt32, x0: Float32,
        y0: Float32, x1: Float32, y1: Float32): Unit

    func draw_fill_matrix(ctx: DCtx, t2d: CPointer<T2Df>): Unit

    func draw_fill_wrap(ctx: DCtx, wrap: FillWrap): Unit

    func draw_font(ctx: DCtx, font: CPointer<Unit>): Unit

    func draw_text_color(ctx: DCtx, color: Color): Unit

    func draw_text(ctx: DCtx, text: CString, x: Float32, y: Float32): Unit

    func draw_text_path(ctx: DCtx, op: DrawOp, text: CString, x: Float32, y: Float32): Unit

    func draw_text_width(ctx: DCtx, width: Float32): Unit

    func draw_text_trim(ctx: DCtx, ellipsis: Ellipsis): Unit

    func draw_text_align(ctx: DCtx, halign: Align, valign: Align): Unit

    func draw_text_halign(ctx: DCtx, halign: Align): Unit

    func draw_text_extents(ctx: DCtx, text: CString, refwidth: Float32, width: CPointer<Float32>,
        height: CPointer<Float32>): Unit

    func draw_image(ctx: DCtx, image: CPointer<Unit>, x: Float32, y: Float32): Unit

    func draw_image_frame(ctx: DCtx, image: CPointer<Unit>, frame: UInt32, x: Float32, y: Float32): Unit

    func draw_image_align(ctx: DCtx, halign: Align, valign: Align): Unit
}

@C
public struct DCtx {
    private var m_handle: CPointer<Unit>

    public init() {
        m_handle = CPointer()
    }

    public init(width: UInt32, height: UInt32, format: PixFormat) {
        m_handle = unsafe { dctx_bitmap(width, height, format) }
    }

    public func clear(color: Color): Unit {
        unsafe { draw_clear(this, color) }
    }

    public func setMatrix(t2d: T2Df): Unit {
        unsafe {
            var value = t2d
            draw_matrixf(this, inout value)
        }
    }

    public func setMatrix(t2d: T2Dd): Unit {
        unsafe {
            var value = t2d
            draw_matrixd(this, inout value)
        }
    }

    public func setMatrixCartesian(t2d: T2Df): Unit {
        unsafe {
            var value = t2d
            draw_matrix_cartesianf(this, inout value)
        }
    }

    public func setMatrixCartesian(t2d: T2Dd): Unit {
        unsafe {
            var value = t2d
            draw_matrix_cartesiand(this, inout value)
        }
    }

    public func setAntialias(on: Bool): Unit {
        unsafe { draw_antialias(this, on) }
    }

    public func drawLine(x0: Float32, y0: Float32, x1: Float32, y1: Float32): Unit {
        unsafe { draw_line(this, x0, y0, x1, y1) }
    }

    // public func drawPolyline(closed: Bool, points: Array<V2Df>): Unit {
    //     unsafe {
    //         var arr = points
    //         draw_polyline(this, closed, &arr, UInt32(arr.size))
    //     }
    // }

    public func drawArc(x: Float32, y: Float32, radius: Float32, start: Float32, sweep: Float32): Unit {
        unsafe { draw_arc(this, x, y, radius, start, sweep) }
    }

    public func drawBezier(x0: Float32, y0: Float32, x1: Float32, y1: Float32, x2: Float32, y2: Float32, x3: Float32,
        y3: Float32): Unit {
        unsafe { draw_bezier(this, x0, y0, x1, y1, x2, y2, x3, y3) }
    }

    public func setLineColor(color: Color): Unit {
        unsafe { draw_line_color(this, color) }
    }

    public func setLineFill(): Unit {
        unsafe { draw_line_fill(this) }
    }

    public func setLineWidth(width: Float32): Unit {
        unsafe { draw_line_width(this, width) }
    }

    public func setLineCap(cap: LineCap): Unit {
        unsafe { draw_line_cap(this, cap) }
    }

    public func setLineJoin(join: LineJoin): Unit {
        unsafe { draw_line_join(this, join) }
    }

    // public func setLineDash(pattern: Array<Float32>): Unit {
    //     unsafe {
    //         var arr = pattern
    //         draw_line_dash(this, &arr, UInt32(arr.size))
    //     }
    // }

    public func drawRect(op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32): Unit {
        unsafe { draw_rect(this, op, x, y, width, height) }
    }

    public func drawRoundedRect(op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32, radius: Float32): Unit {
        unsafe { draw_rndrect(this, op, x, y, width, height, radius) }
    }

    public func drawCircle(op: DrawOp, x: Float32, y: Float32, radius: Float32): Unit {
        unsafe { draw_circle(this, op, x, y, radius) }
    }

    public func drawEllipse(op: DrawOp, x: Float32, y: Float32, radx: Float32, rady: Float32): Unit {
        unsafe { draw_ellipse(this, op, x, y, radx, rady) }
    }

    // public func drawPolygon(op: DrawOp, points: Array<V2Df>): Unit {
    //     unsafe {
    //         var arr = points
    //         draw_polygon(this, op, &arr, UInt32(arr.size))
    //     }
    // }

    public func setFillColor(color: Color): Unit {
        unsafe { draw_fill_color(this, color) }
    }

    // public func setFillLinear(colors: Array<Color>, stops: Array<Float32>, x0: Float32, y0: Float32, x1: Float32, y1: Float32): Unit {
    //     unsafe {
    //         var c = colors
    //         var s = stops
    //         draw_fill_linear(this, &c, &s, UInt32(c.size), x0, y0, x1, y1)
    //     }
    // }

    public func setFillMatrix(t2d: T2Df): Unit {
        unsafe {
            var value = t2d
            draw_fill_matrix(this, inout value)
        }
    }

    public func setFillWrap(wrap: FillWrap): Unit {
        unsafe { draw_fill_wrap(this, wrap) }
    }

    public func setFont(font: CPointer<Unit>): Unit {
        unsafe { draw_font(this, font) }
    }

    public func setTextColor(color: Color): Unit {
        unsafe { draw_text_color(this, color) }
    }

    public func drawText(text: String, x: Float32, y: Float32): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            draw_text(this, strPtr, x, y)
            LibC.free(strPtr)
        }
    }

    public func drawTextPath(op: DrawOp, text: String, x: Float32, y: Float32): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            draw_text_path(this, op, strPtr, x, y)
            LibC.free(strPtr)
        }
    }

    public func setTextWidth(width: Float32): Unit {
        unsafe { draw_text_width(this, width) }
    }

    public func setTextTrim(ellipsis: Ellipsis): Unit {
        unsafe { draw_text_trim(this, ellipsis) }
    }

    public func setTextAlign(halign: Align, valign: Align): Unit {
        unsafe { draw_text_align(this, halign, valign) }
    }

    public func setTextHAlign(halign: Align): Unit {
        unsafe { draw_text_halign(this, halign) }
    }

    // public func getTextExtents(text: String, refwidth: Float32): (Float32, Float32) {
    //     unsafe {
    //         let strPtr = LibC.mallocCString(text)
    //         var w: Float32 = 0.0
    //         var h: Float32 = 0.0
    //         draw_text_extents(this, strPtr, refwidth, &w, &h)
    //         LibC.free(strPtr)
    //         return (w, h)
    //     }
    // }

    public func drawImage(image: CPointer<Unit>, x: Float32, y: Float32): Unit {
        unsafe { draw_image(this, image, x, y) }
    }

    public func drawImageFrame(image: CPointer<Unit>, frame: UInt32, x: Float32, y: Float32): Unit {
        unsafe { draw_image_frame(this, image, frame, x, y) }
    }

    public func setImageAlign(halign: Align, valign: Align): Unit {
        unsafe { draw_image_align(this, halign, valign) }
    }
}
