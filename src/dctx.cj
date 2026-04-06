package nappgui4cj

foreign {
    func dctx_bitmap(width: UInt32, height: UInt32, format: PixFormat): CPointer<Unit>

    func dctx_image(ctx: CPointer<CPointer<Unit>>): CPointer<Unit>

    func draw_clear(ctx: CPointer<Unit>, color: Color): Unit

    func draw_matrixf(ctx: CPointer<Unit>, t2d: CPointer<T2Df>): Unit

    func draw_matrixd(ctx: CPointer<Unit>, t2d: CPointer<T2Dd>): Unit

    func draw_matrix_cartesianf(ctx: CPointer<Unit>, t2d: CPointer<T2Df>): Unit

    func draw_matrix_cartesiand(ctx: CPointer<Unit>, t2d: CPointer<T2Dd>): Unit

    func draw_antialias(ctx: CPointer<Unit>, on: Bool): Unit

    func draw_line(ctx: CPointer<Unit>, x0: Float32, y0: Float32, x1: Float32, y1: Float32): Unit

    func draw_polyline(ctx: CPointer<Unit>, closed: Bool, points: CPointer<V2Df>, n: UInt32): Unit

    func draw_arc(ctx: CPointer<Unit>, x: Float32, y: Float32, radius: Float32, start: Float32, sweep: Float32): Unit

    func draw_bezier(ctx: CPointer<Unit>, x0: Float32, y0: Float32, x1: Float32, y1: Float32, x2: Float32, y2: Float32,
        x3: Float32, y3: Float32): Unit

    func draw_line_color(ctx: CPointer<Unit>, color: Color): Unit

    func draw_line_fill(ctx: CPointer<Unit>): Unit

    func draw_line_width(ctx: CPointer<Unit>, width: Float32): Unit

    func draw_line_cap(ctx: CPointer<Unit>, cap: LineCap): Unit

    func draw_line_join(ctx: CPointer<Unit>, join: LineJoin): Unit

    func draw_line_dash(ctx: CPointer<Unit>, pattern: CPointer<Float32>, n: UInt32): Unit

    func draw_rect(ctx: CPointer<Unit>, op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32): Unit

    func draw_rndrect(ctx: CPointer<Unit>, op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32, radius: Float32): Unit

    func draw_circle(ctx: CPointer<Unit>, op: DrawOp, x: Float32, y: Float32, radius: Float32): Unit

    func draw_ellipse(ctx: CPointer<Unit>, op: DrawOp, x: Float32, y: Float32, radx: Float32, rady: Float32): Unit

    func draw_polygon(ctx: CPointer<Unit>, op: DrawOp, points: CPointer<V2Df>, n: UInt32): Unit

    func draw_fill_color(ctx: CPointer<Unit>, color: Color): Unit

    func draw_fill_linear(ctx: CPointer<Unit>, color: CPointer<Color>, stop: CPointer<Float32>, n: UInt32, x0: Float32,
        y0: Float32, x1: Float32, y1: Float32): Unit

    func draw_fill_matrix(ctx: CPointer<Unit>, t2d: CPointer<T2Df>): Unit

    func draw_fill_wrap(ctx: CPointer<Unit>, wrap: FillWrap): Unit

    func draw_font(ctx: CPointer<Unit>, font: CPointer<Unit>): Unit

    func draw_text_color(ctx: CPointer<Unit>, color: Color): Unit

    func draw_text(ctx: CPointer<Unit>, text: CString, x: Float32, y: Float32): Unit

    func draw_text_path(ctx: CPointer<Unit>, op: DrawOp, text: CString, x: Float32, y: Float32): Unit

    func draw_text_width(ctx: CPointer<Unit>, width: Float32): Unit

    func draw_text_trim(ctx: CPointer<Unit>, ellipsis: Ellipsis): Unit

    func draw_text_align(ctx: CPointer<Unit>, halign: Align, valign: Align): Unit

    func draw_text_halign(ctx: CPointer<Unit>, halign: Align): Unit

    func draw_text_extents(ctx: CPointer<Unit>, text: CString, refwidth: Float32, width: CPointer<Float32>,
        height: CPointer<Float32>): Unit

    func draw_image(ctx: CPointer<Unit>, image: CPointer<Unit>, x: Float32, y: Float32): Unit

    func draw_image_frame(ctx: CPointer<Unit>, image: CPointer<Unit>, frame: UInt32, x: Float32, y: Float32): Unit

    func draw_image_align(ctx: CPointer<Unit>, halign: Align, valign: Align): Unit
}

public struct DCtx <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(width: UInt32, height: UInt32, format: PixFormat) {
        m_handle = unsafe { dctx_bitmap(width, height, format) }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public mut func toImage(): Image {
        unsafe { Image(dctx_image(inout m_handle)) }
    }

    public func clear(color: Color): Unit {
        unsafe { draw_clear(m_handle, color) }
    }

    public func setMatrix(t2d: T2Df): Unit {
        unsafe {
            var value = t2d
            draw_matrixf(m_handle, inout value)
        }
    }

    public func setMatrix(t2d: T2Dd): Unit {
        unsafe {
            var value = t2d
            draw_matrixd(m_handle, inout value)
        }
    }

    public func setMatrixCartesian(t2d: T2Df): Unit {
        unsafe {
            var value = t2d
            draw_matrix_cartesianf(m_handle, inout value)
        }
    }

    public func setMatrixCartesian(t2d: T2Dd): Unit {
        unsafe {
            var value = t2d
            draw_matrix_cartesiand(m_handle, inout value)
        }
    }

    public func setAntialias(on: Bool): Unit {
        unsafe { draw_antialias(m_handle, on) }
    }

    public func drawLine(x0: Float32, y0: Float32, x1: Float32, y1: Float32): Unit {
        unsafe { draw_line(m_handle, x0, y0, x1, y1) }
    }

    public func drawPolyline(points: Array<V2Df>, closed!: Bool = false): Unit {
        unsafe {
            let rawData = acquireArrayRawData(points)
            draw_polyline(m_handle, closed, rawData.pointer, UInt32(points.size))
            releaseArrayRawData(rawData)
        }
    }

    public func drawArc(x: Float32, y: Float32, radius: Float32, start: Float32, sweep: Float32): Unit {
        unsafe { draw_arc(m_handle, x, y, radius, start, sweep) }
    }

    public func drawBezier(x0: Float32, y0: Float32, x1: Float32, y1: Float32, x2: Float32, y2: Float32, x3: Float32,
        y3: Float32): Unit {
        unsafe { draw_bezier(m_handle, x0, y0, x1, y1, x2, y2, x3, y3) }
    }

    public func setLineColor(color: Color): Unit {
        unsafe { draw_line_color(m_handle, color) }
    }

    public func setLineFill(): Unit {
        unsafe { draw_line_fill(m_handle) }
    }

    public func setLineWidth(width: Float32): Unit {
        unsafe { draw_line_width(m_handle, width) }
    }

    public func setLineCap(cap: LineCap): Unit {
        unsafe { draw_line_cap(m_handle, cap) }
    }

    public func setLineJoin(join: LineJoin): Unit {
        unsafe { draw_line_join(m_handle, join) }
    }

    public func setLineDash(pattern!: ?Array<Float32> = None): Unit {
        unsafe {
            match (pattern) {
                case Some(pattern) =>
                    let rawData = acquireArrayRawData(pattern)
                    draw_line_dash(m_handle, rawData.pointer, UInt32(pattern.size))
                    releaseArrayRawData(rawData)
                case None => draw_line_dash(m_handle, CPointer(), 0)
            }
        }
    }

    public func drawRect(op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32): Unit {
        unsafe { draw_rect(m_handle, op, x, y, width, height) }
    }

    public func drawRoundedRect(op: DrawOp, x: Float32, y: Float32, width: Float32, height: Float32, radius: Float32): Unit {
        unsafe { draw_rndrect(m_handle, op, x, y, width, height, radius) }
    }

    public func drawCircle(op: DrawOp, x: Float32, y: Float32, radius: Float32): Unit {
        unsafe { draw_circle(m_handle, op, x, y, radius) }
    }

    public func drawEllipse(op: DrawOp, x: Float32, y: Float32, radx: Float32, rady: Float32): Unit {
        unsafe { draw_ellipse(m_handle, op, x, y, radx, rady) }
    }

    public func drawPolygon(op: DrawOp, points: Array<V2Df>): Unit {
        unsafe {
            let rawData = acquireArrayRawData(points)
            draw_polygon(m_handle, op, rawData.pointer, UInt32(points.size))
            releaseArrayRawData(rawData)
        }
    }

    public func setFillColor(color: Color): Unit {
        unsafe { draw_fill_color(m_handle, color) }
    }

    public func setFillLinear(colors: Array<Color>, stops: Array<Float32>, x0: Float32, y0: Float32, x1: Float32,
        y1: Float32): Unit {
        unsafe {
            let size = match {
                case colors.size < stops.size => UInt32(colors.size)
                case _ => UInt32(stops.size)
            }
            let rawColors = acquireArrayRawData(colors)
            let rawStops = acquireArrayRawData(stops)
            draw_fill_linear(m_handle, rawColors.pointer, rawStops.pointer, size, x0, y0, x1, y1)
            releaseArrayRawData(rawColors)
            releaseArrayRawData(rawStops)
        }
    }

    public func setFillMatrix(t2d: T2Df): Unit {
        unsafe {
            var value = t2d
            draw_fill_matrix(m_handle, inout value)
        }
    }

    public func setFillWrap(wrap: FillWrap): Unit {
        unsafe { draw_fill_wrap(m_handle, wrap) }
    }

    public func setFont(font: Font): Unit {
        unsafe { draw_font(m_handle, font.m_handle) }
    }

    public func setTextColor(color: Color): Unit {
        unsafe { draw_text_color(m_handle, color) }
    }

    public func drawText(text: String, x: Float32, y: Float32): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            draw_text(m_handle, strPtr, x, y)
            LibC.free(strPtr)
        }
    }

    public func drawTextPath(op: DrawOp, text: String, x: Float32, y: Float32): Unit {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            draw_text_path(m_handle, op, strPtr, x, y)
            LibC.free(strPtr)
        }
    }

    public func setTextWidth(width: Float32): Unit {
        unsafe { draw_text_width(m_handle, width) }
    }

    public func setTextTrim(ellipsis: Ellipsis): Unit {
        unsafe { draw_text_trim(m_handle, ellipsis) }
    }

    public func setTextAlign(halign: Align, valign: Align): Unit {
        unsafe { draw_text_align(m_handle, halign, valign) }
    }

    public func setTextHAlign(halign: Align): Unit {
        unsafe { draw_text_halign(m_handle, halign) }
    }

    public func textExtents(text: String, refwidth: Float32): (Float32, Float32) {
        unsafe {
            let strPtr = LibC.mallocCString(text)
            var w: Float32 = 0.0
            var h: Float32 = 0.0
            draw_text_extents(m_handle, strPtr, refwidth, inout w, inout h)
            LibC.free(strPtr)
            return (w, h)
        }
    }

    public func drawImage(image: Image, x: Float32, y: Float32): Unit {
        unsafe { draw_image(m_handle, image.m_handle, x, y) }
    }

    public func drawImageFrame(image: Image, frame: UInt32, x: Float32, y: Float32): Unit {
        unsafe { draw_image_frame(m_handle, image.m_handle, frame, x, y) }
    }

    public func setImageAlign(halign: Align, valign: Align): Unit {
        unsafe { draw_image_align(m_handle, halign, valign) }
    }
}
