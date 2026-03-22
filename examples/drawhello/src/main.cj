package drawhello

import nappgui4cj.*
import std.math.FloatingPoint

class App <: Resource {
    private static var m_app: ?App = None

    var window: Window
    var view: View
    var label: Label
    var slider1: ?Cell
    var slider2: ?Cell
    var popup_trim: ?Cell
    var popup_align: ?Cell
    var option: UInt32 = 0

    private init() {
        window = Window.create(WindowFlag.Std)
        view = View()
        label = Label()
        slider1 = None
        slider2 = None
        popup_trim = None
        popup_align = None

        let panel = createPanel(this)

        window.setPanel(panel)
        window.setTitle("Drawing primitives")
        window.setOrigin(V2Df(500.0, 200.0))
        window.onClose(onClose)
        window.show()
    }

    static func get(): App {
        match (m_app) {
            case Some(app) => return app
            case None =>
                let app = App()
                m_app = app
                setDemo(app, 0)
                return app
        }
    }

    static func destroy(): Unit {
        m_app?.close()
        m_app = None
    }

    public func isClosed(): Bool {
        window.isNull()
    }

    public func close(): Unit {
        if (!window.isNull()) {
            window.destroy()
        }
    }
}

// Helper functions for drawing

func drawLines(ctx: DCtx): Unit {
    let poly1: Array<V2Df> = [
        V2Df(10.0, 190.0),
        V2Df(90.0, 110.0),
        V2Df(110.0, 190.0),
        V2Df(190.0, 110.0),
        V2Df(210.0, 190.0),
        V2Df(290.0, 110.0)
    ]
    let poly2: Array<V2Df> = [
        V2Df(310.0, 190.0),
        V2Df(390.0, 110.0),
        V2Df(410.0, 190.0),
        V2Df(490.0, 110.0),
        V2Df(510.0, 190.0),
        V2Df(590.0, 110.0)
    ]
    let poly3: Array<V2Df> = [
        V2Df(10.0, 290.0),
        V2Df(90.0, 210.0),
        V2Df(110.0, 290.0),
        V2Df(190.0, 210.0),
        V2Df(210.0, 290.0),
        V2Df(290.0, 210.0)
    ]

    let pattern1: Array<Float32> = [5.0, 5.0, 10.0, 5.0]
    let pattern2: Array<Float32> = [1.0, 1.0]
    let pattern3: Array<Float32> = [2.0, 1.0]
    let pattern4: Array<Float32> = [1.0, 2.0]

    // Line widths
    ctx.setLineColor(Color.BLACK)
    ctx.setLineWidth(5.0)
    ctx.drawLine(10.0, 90.0, 90.0, 10.0)
    ctx.setLineWidth(10.0)
    ctx.drawLine(110.0, 90.0, 190.0, 10.0)
    ctx.setLineWidth(15.0)
    ctx.drawLine(210.0, 90.0, 290.0, 10.0)

    // Line caps
    ctx.setLineCap(LineCap.Flat)
    ctx.drawLine(310.0, 90.0, 390.0, 10.0)
    ctx.setLineCap(LineCap.Square)
    ctx.drawLine(410.0, 90.0, 490.0, 10.0)
    ctx.setLineCap(LineCap.Round)
    ctx.drawLine(510.0, 90.0, 590.0, 10.0)

    // Line joins
    ctx.setLineWidth(15.0)
    ctx.setLineCap(LineCap.Flat)
    ctx.setLineJoin(LineJoin.Miter)
    ctx.drawPolyline(poly1)
    ctx.setLineCap(LineCap.Square)
    ctx.setLineJoin(LineJoin.Round)
    ctx.drawPolyline(poly2)
    ctx.setLineCap(LineCap.Round)
    ctx.setLineJoin(LineJoin.Bevel)
    ctx.drawPolyline(poly3)

    // Line colors
    ctx.setLineWidth(10.0)
    ctx.setLineCap(LineCap.Flat)
    ctx.setLineColor(Color.RED)
    ctx.drawLine(310.0, 215.0, 590.0, 215.0)
    ctx.setLineColor(Color.GREEN)
    ctx.drawLine(310.0, 235.0, 590.0, 235.0)
    ctx.setLineColor(Color.BLUE)
    ctx.drawLine(310.0, 255.0, 590.0, 255.0)
    ctx.setLineWidth(5.0)
    ctx.setLineColor(Color.YELLOW)
    ctx.drawLine(310.0, 270.0, 590.0, 270.0)
    ctx.setLineColor(Color.CYAN)
    ctx.drawLine(310.0, 280.0, 590.0, 280.0)
    ctx.setLineColor(Color.MAGENTA)
    ctx.drawLine(310.0, 290.0, 590.0, 290.0)

    // Line patterns
    ctx.setLineColor(Color.BLACK)
    ctx.setLineWidth(5.0)
    ctx.setLineCap(LineCap.Flat)
    ctx.setLineDash(pattern: pattern1)
    ctx.drawLine(10.0, 310.0, 590.0, 310.0)
    ctx.setLineDash(pattern: pattern2)
    ctx.drawLine(10.0, 330.0, 590.0, 330.0)
    ctx.setLineDash(pattern: pattern3)
    ctx.drawLine(10.0, 350.0, 590.0, 350.0)
    ctx.setLineDash(pattern: pattern4)
    ctx.setLineWidth(2.0)
    ctx.drawLine(10.0, 365.0, 590.0, 365.0)
    ctx.setLineDash(pattern: pattern1)
    ctx.setLineWidth(1.0)
    ctx.drawLine(10.0, 375.0, 590.0, 375.0)
    ctx.setLineDash()
    ctx.drawLine(10.0, 385.0, 590.0, 385.0)

    // Thin lines in centers
    ctx.setLineDash()
    ctx.setLineColor(Color(255, 255, 255))
    ctx.setLineWidth(1.0)
    ctx.drawLine(10.0, 90.0, 90.0, 10.0)
    ctx.drawLine(110.0, 90.0, 190.0, 10.0)
    ctx.drawLine(210.0, 90.0, 290.0, 10.0)
    ctx.drawLine(310.0, 90.0, 390.0, 10.0)
    ctx.drawLine(410.0, 90.0, 490.0, 10.0)
    ctx.drawLine(510.0, 90.0, 590.0, 10.0)
    ctx.drawPolyline(poly1)
    ctx.drawPolyline(poly2)
    ctx.drawPolyline(poly3)
}

func drawShapesRow(ctx: DCtx, op: DrawOp, origin: T2Df): Unit {
    let poly: Array<V2Df> = [
        V2Df(40.0, 0.0),
        V2Df(12.36, 38.04),
        V2Df(-32.36, 23.52),
        V2Df(-32.36, -23.52),
        V2Df(12.36, -38.04)
    ]

    ctx.drawRect(op, 10.0, 10.0, 110.0, 75.0)
    ctx.drawRoundedRect(op, 140.0, 10.0, 110.0, 75.0, 20.0)
    ctx.drawCircle(op, 312.0, 50.0, 40.0)
    ctx.drawEllipse(op, 430.0, 50.0, 55.0, 37.0)

    let matrix = origin.move(547.0, 50.0).rotate(-Float32.getPI() / 10.0)
    ctx.setMatrix(matrix)
    ctx.drawPolygon(op, poly)
}

func drawShapes(ctx: DCtx, grad: Bool): Unit {
    ctx.setLineColor(Color.BLACK)
    ctx.setLineWidth(10.0)

    // Row 1
    var op = match (grad) {
        case true => DrawOp.SkFill
        case false => DrawOp.Stroke
    }
    var origin = T2Df()
    ctx.setMatrix(origin)
    drawShapesRow(ctx, op, origin)

    // Row 2
    op = match (grad) {
        case true => DrawOp.SkFill
        case false => DrawOp.Fill
    }
    origin = origin.move(0.0, 100.0)
    ctx.setMatrix(origin)
    drawShapesRow(ctx, op, origin)

    // Row 3
    op = match (grad) {
        case true => DrawOp.SkFill
        case false => DrawOp.FillSk
    }
    origin = origin.move(0.0, 100.0)
    ctx.setMatrix(origin)
    drawShapesRow(ctx, op, origin)

    // Row 4
    op = match (grad) {
        case true => DrawOp.SkFill
        case false => DrawOp.FillSk
    }
    origin = origin.move(0.0, 100.0)
    ctx.setMatrix(origin)
    drawShapesRow(ctx, op, origin)
}

func drawGradient(ctx: DCtx, gradient: Float32, back: Bool, shapes: Bool): Unit {
    let c: Array<Color> = [Color.RED, Color.BLUE]
    let stop: Array<Float32> = [0.0, 1.0]

    var gpos = gradient * (600.0 + 400.0)
    var gx: Float32
    var gy: Float32

    if (gpos < 400.0) {
        gx = 600.0
        gy = gpos
    } else {
        gx = 600.0 - (gpos - 400.0)
        gy = 400.0
    }

    ctx.setFillLinear(c, stop, 0.0, 0.0, gx, gy)

    if (back) {
        ctx.drawRect(DrawOp.Fill, 0.0, 0.0, 600.0, 400.0)
    }

    if (shapes) {
        drawShapes(ctx, true)
    }

    ctx.setMatrix(T2Df())
    ctx.setLineWidth(3.0)
    ctx.setLineColor(Color(200, 200, 200))
    ctx.drawLine(3.0, 3.0, gx + 3.0, gy + 3.0)
}

func drawLinesGradient(ctx: DCtx, gradient: Float32): Unit {
    let c: Array<Color> = [Color.RED, Color.BLUE]
    let stop: Array<Float32> = [0.0, 1.0]

    let pattern1: Array<Float32> = [5.0, 5.0, 10.0, 5.0]
    let pattern2: Array<Float32> = [1.0, 1.0]
    let pattern3: Array<Float32> = [2.0, 1.0]
    let pattern4: Array<Float32> = [1.0, 2.0]

    var gpos = gradient * (600.0 + 400.0)
    var gx: Float32
    var gy: Float32

    if (gpos < 400.0) {
        gx = 600.0
        gy = gpos
    } else {
        gx = 600.0 - (gpos - 400.0)
        gy = 400.0
    }

    ctx.setLineWidth(10.0)
    ctx.setLineFill()
    ctx.setFillLinear(c, stop, 0.0, 0.0, gx, gy)

    ctx.setMatrix(T2Df())
    drawShapesRow(ctx, DrawOp.Stroke, T2Df())

    ctx.setMatrix(T2Df())
    ctx.setLineWidth(1.0)
    ctx.drawBezier(30.0, 190.0, 140.0, 50.0, 440.0, 110.0, 570.0, 190.0)
    ctx.setLineWidth(4.0)
    ctx.drawBezier(30.0, 210.0, 140.0, 70.0, 440.0, 130.0, 570.0, 210.0)
    ctx.setLineWidth(7.0)
    ctx.drawBezier(30.0, 230.0, 140.0, 90.0, 440.0, 150.0, 570.0, 230.0)
    ctx.setLineWidth(10.0)
    ctx.drawBezier(30.0, 250.0, 140.0, 110.0, 440.0, 170.0, 570.0, 250.0)

    ctx.setLineWidth(8.0)
    ctx.drawArc(100.0, 280.0, 60.0, 0.0, -Float32.getPI() / 2.0)
    ctx.drawArc(250.0, 280.0, 60.0, Float32.getPI(), Float32.getPI() / 2.0)
    ctx.drawArc(300.0, 220.0, 60.0, Float32.getPI() / 2.0, -Float32.getPI() / 2.0)
    ctx.drawArc(450.0, 220.0, 60.0, Float32.getPI() / 2.0, Float32.getPI() / 2.0)

    ctx.setLineWidth(5.0)
    ctx.setLineCap(LineCap.Flat)
    ctx.setLineDash(pattern: pattern1)
    ctx.drawLine(10.0, 310.0, 590.0, 310.0)
    ctx.setLineDash(pattern: pattern2)
    ctx.drawLine(10.0, 330.0, 590.0, 330.0)
    ctx.setLineDash(pattern: pattern3)
    ctx.drawLine(10.0, 350.0, 590.0, 350.0)
    ctx.setLineDash(pattern: pattern4)
    ctx.setLineWidth(2.0)
    ctx.drawLine(10.0, 365.0, 590.0, 365.0)
    ctx.setLineDash(pattern: pattern1)
    ctx.setLineWidth(1.0)
    ctx.drawLine(10.0, 375.0, 590.0, 375.0)
    ctx.setLineDash()
    ctx.drawLine(10.0, 385.0, 590.0, 385.0)

    ctx.setLineWidth(1.0)
    ctx.setLineColor(Color(50, 50, 50))
    ctx.drawLine(3.0, 3.0, gx + 3.0, gy + 3.0)
}

func drawLocalGradient(ctx: DCtx, gradient: Float32): Unit {
    let c: Array<Color> = [Color.RED, Color.BLUE]
    let stop: Array<Float32> = [0.0, 1.0]

    var gpos = gradient * (200.0 + 100.0)
    var gx: Float32
    var gy: Float32

    if (gpos < 100.0) {
        gx = 200.0
        gy = gpos
    } else {
        gx = 200.0 - (gpos - 100.0)
        gy = 100.0
    }

    ctx.setLineJoin(LineJoin.Round)
    ctx.setFillLinear(c, stop, 0.0, 0.0, gx, gy)

    var matrix = T2Df().move(50.0, 40.0)
    ctx.setMatrix(matrix)
    ctx.setFillMatrix(matrix)
    ctx.setLineWidth(10.0)
    ctx.setLineColor(Color.BLACK)
    ctx.drawRect(DrawOp.SkFill, 0.0, 0.0, 200.0, 100.0)
    ctx.setLineWidth(3.0)
    ctx.setLineColor(Color(200, 200, 200))
    ctx.drawLine(0.0, 0.0, gx, gy)

    matrix = T2Df().move(400.0, 40.0).rotate(Float32.getPI() / 6.0)
    ctx.setMatrix(matrix)
    ctx.setFillMatrix(matrix)
    ctx.setLineWidth(10.0)
    ctx.setLineColor(Color.BLACK)
    ctx.drawRect(DrawOp.SkFill, 0.0, 0.0, 200.0, 100.0)
    ctx.setLineWidth(3.0)
    ctx.setLineColor(Color(200, 200, 200))
    ctx.drawLine(0.0, 0.0, gx, gy)

    matrix = T2Df().move(250.0, 280.0).rotate(-Float32.getPI() / 10.0).move(-100.0, -50.0)
    ctx.setMatrix(matrix)
    ctx.setFillMatrix(matrix)
    ctx.setLineWidth(10.0)
    ctx.setLineColor(Color.BLACK)
    ctx.drawEllipse(DrawOp.SkFill, 0.0, 0.0, 100.0, 50.0)

    ctx.setMatrix(T2Df())
    ctx.setLineWidth(3.0)
    ctx.setLineColor(Color(200, 200, 200))
    ctx.drawLine(0.0, 0.0, gx, gy)
}

func drawWrapGradient(ctx: DCtx): Unit {
    let c: Array<Color> = [Color.RED, Color.BLUE]
    let stop: Array<Float32> = [0.0, 1.0]
    ctx.setLineWidth(2.0)
    ctx.setFillLinear(c, stop, 200.0, 0.0, 400.0, 0.0)

    ctx.setFillWrap(FillWrap.Clamp)
    ctx.drawRect(DrawOp.SkFill, 50.0, 25.0, 500.0, 100.0)

    ctx.setFillWrap(FillWrap.Tile)
    ctx.drawRect(DrawOp.SkFill, 50.0, 150.0, 500.0, 100.0)

    ctx.setFillWrap(FillWrap.Flip)
    ctx.drawRect(DrawOp.SkFill, 50.0, 275.0, 500.0, 100.0)
}

func drawTextRect(ctx: DCtx, x: Float32, y: Float32, w: Float32, h: Float32, halign: Align, valign: Align): Unit {
    var rx = x
    var ry = y
    if (halign == Align.Center) {
        rx -= w / 2.0
    } else if (halign == Align.Right) {
        rx -= w
    }
    if (valign == Align.Center) {
        ry -= h / 2.0
    } else if (valign == Align.Bottom) {
        ry -= h
    }
    ctx.drawRect(DrawOp.Stroke, rx, ry, w, h)
}

func drawText(ctx: DCtx, text: String, x: Float32, y: Float32, w: Float32, h: Float32, halign: Align, valign: Align): Unit {
    ctx.setTextAlign(halign, valign)
    if (w > 20.0) {
        ctx.drawText(text, x, y)
    }
    ctx.drawCircle(DrawOp.Fill, x, y, 3.0)
    drawTextRect(ctx, x, y, w, h, halign, valign)
}

func textSingle(ctx: DCtx, xscale: Float32, text_width: Float32, text_trim: UInt32, text_align: UInt32): Unit {
    var bfont = Font.createSystem(20.0, 0)
    var font = bfont.withXScale(xscale)
    let text = "Text 文本 Κείμενο"
    let (w, h) = ctx.textExtents(text, -1.0)

    ctx.setFont(font)
    ctx.setTextColor(Color.BLUE)
    ctx.setLineColor(Color.RED)
    ctx.setFillColor(Color.RED)

    let halign = Align(text_align + 1)
    ctx.setTextHAlign(halign)

    var width = w
    if (text_trim > 0) {
        ctx.setTextWidth(text_width)
        if (text_trim == 1) {
            ctx.setTextTrim(Ellipsis.Begin)
        } else if (text_trim == 2) {
            ctx.setTextTrim(Ellipsis.Middle)
        } else {
            ctx.setTextTrim(Ellipsis.End)
        }
        width = text_width
    } else {
        ctx.setTextWidth(-1.0)
    }

    // Draw grid of text
    drawText(ctx, text, 25.0, 25.0, width, h, Align.Left, Align.Top)
    drawText(ctx, text, 300.0, 25.0, width, h, Align.Center, Align.Top)
    drawText(ctx, text, 575.0, 25.0, width, h, Align.Right, Align.Top)
    drawText(ctx, text, 25.0, 100.0, width, h, Align.Left, Align.Center)
    drawText(ctx, text, 300.0, 100.0, width, h, Align.Center, Align.Center)
    drawText(ctx, text, 575.0, 100.0, width, h, Align.Right, Align.Center)
    drawText(ctx, text, 25.0, 175.0, width, h, Align.Left, Align.Bottom)
    drawText(ctx, text, 300.0, 175.0, width, h, Align.Center, Align.Bottom)
    drawText(ctx, text, 575.0, 175.0, width, h, Align.Right, Align.Bottom)

    // Rotated
    var matrix = T2Df().move(25.0, 200.0).rotate(Float32.getPI() / 8.0)
    ctx.setMatrix(matrix)
    drawText(ctx, text, 0.0, 0.0, width, h, Align.Left, Align.Top)

    matrix = T2Df().move(300.0, 250.0).rotate(-Float32.getPI() / 8.0)
    ctx.setMatrix(matrix)
    drawText(ctx, text, 0.0, 0.0, width, h, Align.Center, Align.Center)

    // Scaled
    matrix = T2Df().move(25.0, 325.0).scale(3.0, 1.0)
    ctx.setMatrix(matrix)
    drawText(ctx, text, 0.0, 0.0, width, h, Align.Left, Align.Top)

    matrix = T2Df().move(575.0, 200.0).scale(0.5, 1.0)
    ctx.setMatrix(matrix)
    drawText(ctx, text, 0.0, 0.0, width, h, Align.Right, Align.Top)

    matrix = T2Df().move(575.0, 230.0).scale(0.75, 1.0)
    ctx.setMatrix(matrix)
    drawText(ctx, text, 0.0, 0.0, width, h, Align.Right, Align.Top)

    matrix = T2Df().move(575.0, 260.0).scale(1.25, 1.0)
    ctx.setMatrix(matrix)
    drawText(ctx, text, 0.0, 0.0, width, h, Align.Right, Align.Top)

    font.destroy()
    bfont.destroy()
}

func textNewline(ctx: DCtx, xscale: Float32, align: UInt32): Unit {
    var bfont = Font.createSystem(20.0, 0)
    var font = bfont.withXScale(xscale)
    let text = "Text new line\n文字换行\nΓραμμή κειμένου"
    let stext = "Text single line"

    ctx.setFont(font)
    let (w1, h1) = ctx.textExtents(text, -1.0)
    let (w2, h2) = ctx.textExtents(stext, -1.0)

    ctx.setTextColor(Color.BLUE)
    ctx.setLineColor(Color.RED)
    ctx.setFillColor(Color.RED)
    ctx.setTextWidth(-1.0)
    let halign = Align(align + 1)
    ctx.setTextHAlign(halign)

    drawText(ctx, text, 25.0, 25.0, w1, h1, Align.Left, Align.Top)
    drawText(ctx, text, 300.0, 25.0, w1, h1, Align.Center, Align.Top)
    drawText(ctx, text, 575.0, 25.0, w1, h1, Align.Right, Align.Top)
    drawText(ctx, text, 25.0, 175.0, w1, h1, Align.Left, Align.Center)
    drawText(ctx, text, 300.0, 175.0, w1, h1, Align.Center, Align.Center)
    drawText(ctx, text, 575.0, 175.0, w1, h1, Align.Right, Align.Center)
    drawText(ctx, text, 25.0, 325.0, w1, h1, Align.Left, Align.Bottom)
    drawText(ctx, text, 300.0, 325.0, w1, h1, Align.Center, Align.Bottom)
    drawText(ctx, text, 575.0, 325.0, w1, h1, Align.Right, Align.Bottom)
    drawText(ctx, stext, 25.0, 350.0, w2, h2, Align.Left, Align.Top)
    drawText(ctx, stext, 300.0, 350.0, w2, h2, Align.Center, Align.Top)
    drawText(ctx, stext, 575.0, 350.0, w2, h2, Align.Right, Align.Top)

    font.destroy()
    bfont.destroy()
}

func textBlock(ctx: DCtx, xscale: Float32, text_width: Float32, align: UInt32): Unit {
    let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    var bfont = Font.createSystem(Font.regularSize, 0)
    var font = bfont.withXScale(xscale)

    ctx.setFont(font)
    ctx.setTextColor(Color.BLUE)
    ctx.setLineColor(Color.RED)
    ctx.setFillColor(Color.RED)
    let halign = Align(align + 1)
    ctx.setTextHAlign(halign)
    ctx.setTextWidth(text_width)

    let (w, h) = ctx.textExtents(text, text_width)

    drawText(ctx, text, 25.0, 25.0, text_width, h, Align.Left, Align.Top)
    drawText(ctx, text, 400.0, 25.0, text_width, h, Align.Center, Align.Top)
    drawText(ctx, text, 500.0, 200.0, text_width, h, Align.Right, Align.Top)

    font.destroy()
    bfont.destroy()
}

func textArt(ctx: DCtx): Unit {
    var font = Font.createSystem(50.0, 0)
    let c: Array<Color> = [Color.BLUE, Color.RED]
    let stop: Array<Float32> = [0.0, 1.0]
    let dash: Array<Float32> = [1.0, 1.0]

    ctx.setFont(font)
    ctx.setLineWidth(2.0)
    ctx.setLineColor(Color.WHITE)
    ctx.setFillColor(Color.BLUE)
    ctx.drawTextPath(DrawOp.FillSk, "Fill and Stoke text", 25.0, 25.0)

    let (width, _) = ctx.textExtents("Gradient fill text", -1.0)
    ctx.setFillLinear(c, stop, 25.0, 0.0, 25.0 + width, 0.0)
    ctx.setFillMatrix(T2Df())
    ctx.drawTextPath(DrawOp.Fill, "Gradient fill text", 25.0, 100.0)

    ctx.setLineColor(Color.BLACK)
    ctx.setLineDash(pattern: dash)
    ctx.drawTextPath(DrawOp.Stroke, "Dashed stroke text", 25.0, 175.0)

    ctx.setLineColor(Color.GREEN)
    let (w2, _) = ctx.textExtents("Gradient dashed text", -1.0)
    ctx.setFillLinear(c, stop, 25.0, 0.0, 25.0 + w2, 0.0)
    ctx.drawTextPath(DrawOp.FillSk, "Gradient dashed text", 25.0, 250.0)

    ctx.setLineColor(Color.BLACK)
    ctx.setLineWidth(0.5)
    ctx.setLineDash()
    ctx.drawTextPath(DrawOp.Stroke, "Thin stroke text", 25.0, 325.0)

    font.destroy()
}

func textRaster(ctx: DCtx, xscale: Float32, text_width: Float32, text_trim: UInt32, align: UInt32): Unit {
    var bfont = Font.createSystem(20.0, 0)
    var font = bfont.withXScale(xscale)
    let halign = Align(align + 1)

    ctx.setFont(font)
    ctx.setLineColor(Color.RED)
    ctx.setFillColor(Color.RED)

    // Single line with text width and trim (ellipsis)
    let text1 = "This is a text line"
    var (w1, h1) = ctx.textExtents(text1, -1.0)
    ctx.setTextColor(Color.DEFAULT)

    if (text_trim > 0) {
        ctx.setTextWidth(text_width)
        if (text_trim == 1) {
            ctx.setTextTrim(Ellipsis.Begin)
        } else if (text_trim == 2) {
            ctx.setTextTrim(Ellipsis.Middle)
        } else {
            ctx.setTextTrim(Ellipsis.End)
        }
        w1 = text_width
    } else {
        ctx.setTextWidth(-1.0)
    }

    ctx.setTextHAlign(halign)
    ctx.drawText(text1, 25.0, 25.0) // Using drawText as wrapper for draw_text
    ctx.drawCircle(DrawOp.Fill, 25.0, 25.0, 3.0)
    ctx.drawRect(DrawOp.Stroke, 25.0, 25.0, w1, h1)

    // Text block with newlines
    let text2 = "Text new line\n文字换行\nΓραμμή κειμένου"
    ctx.setTextWidth(-1.0)
    ctx.setTextColor(Color.BLUE)
    let (w2, h2) = ctx.textExtents(text2, -1.0)

    ctx.setTextHAlign(halign)
    ctx.drawText(text2, 200.0, 25.0)
    ctx.drawCircle(DrawOp.Fill, 200.0, 25.0, 3.0)
    ctx.drawRect(DrawOp.Stroke, 200.0, 25.0, w2, h2)

    // Text block with fixed width
    let text3 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    let tw3 = 200.0 + text_width
    ctx.setTextWidth(tw3)
    ctx.setTextTrim(Ellipsis.MLine)
    let (w3, h3) = ctx.textExtents(text3, tw3)

    ctx.setTextHAlign(halign)
    ctx.drawText(text3, 25.0, 125.0)
    ctx.drawCircle(DrawOp.Fill, 25.0, 125.0, 3.0)
    ctx.drawRect(DrawOp.Stroke, 25.0, 125.0, tw3, h3)

    font.destroy()
    bfont.destroy()
}

func imageDraw(ctx: DCtx): Unit {
    var pack = unsafe { resdrawhelloResPack(CString(CPointer())) }
    let image = Image(pack, IMAGE_PNG)

    ctx.setImageAlign(Align.Left, Align.Top)
    ctx.drawImage(image, 25.0, 25.0)

    var matrix = T2Df().move(300.0, 200.0).rotate(Float32.getPI() / 8.0)
    ctx.setMatrix(matrix)
    ctx.setImageAlign(Align.Center, Align.Center)
    ctx.drawImage(image, 0.0, 0.0)

    ctx.setMatrix(T2Df())
    ctx.setImageAlign(Align.Right, Align.Top)
    ctx.drawImage(image, 575.0, 25.0)

    ctx.setImageAlign(Align.Left, Align.Bottom)
    ctx.drawImage(image, 25.0, 375.0)

    ctx.setImageAlign(Align.Right, Align.Bottom)
    ctx.drawImage(image, 575.0, 375.0)

    ctx.setFillColor(Color.BLUE)
    ctx.drawCircle(DrawOp.Fill, 25.0, 25.0, 3.0)
    ctx.drawCircle(DrawOp.Fill, 300.0, 200.0, 3.0)
    ctx.drawCircle(DrawOp.Fill, 575.0, 25.0, 3.0)
    ctx.drawCircle(DrawOp.Fill, 25.0, 375.0, 3.0)
    ctx.drawCircle(DrawOp.Fill, 575.0, 375.0, 3.0)

    pack.destroy()
}

func setDemo(app: App, option: UInt32): Unit {
    app.option = option

    let slider1 = app.slider1?.getSlider()
    let slider2 = app.slider2?.getSlider()

    slider1?.setValue(0.5)
    slider2?.setValue(0.5)

    app.slider1?.setEnabled(false)
    app.slider2?.setEnabled(false)
    app.popup_trim?.setEnabled(false)
    app.popup_align?.setEnabled(false)

    if (option == 0) {
        app.label.setText("Different line styles: width, join, cap, dash...")
    } else if (option == 1) {
        app.label.setText("Basic shapes filled and stroke.")
    } else if (option == 2) {
        app.slider1?.setEnabled(true)
        app.label.setText("Global linear gradient.")
    } else if (option == 3) {
        app.slider1?.setEnabled(true)
        app.label.setText("Shapes filled with global (identity) linear gradient (with background).")
    } else if (option == 4) {
        app.slider1?.setEnabled(true)
        app.label.setText("Shapes filled with global (identity) linear gradient.")
    } else if (option == 5) {
        app.slider1?.setEnabled(true)
        app.label.setText("Lines with global (identity) linear gradient.")
    } else if (option == 6) {
        app.slider1?.setEnabled(true)
        app.label.setText("Shapes filled with local (transformed) gradient.")
    } else if (option == 7) {
        app.label.setText("Gradient wrap modes.")
    } else if (option == 8) {
        app.label.setText("Single line text with alignment, transforms and trimming")
        app.slider1?.setEnabled(true)
        app.slider2?.setEnabled(true)
        app.popup_trim?.setEnabled(true)
        app.popup_align?.setEnabled(true)
    } else if (option == 9) {
        app.label.setText("Text with newline '\\n' character and internal alignment")
        app.slider1?.setEnabled(true)
        app.popup_align?.setEnabled(true)
    } else if (option == 10) {
        app.label.setText("Text block in a constrained width area")
        app.slider1?.setEnabled(true)
        app.slider2?.setEnabled(true)
        app.popup_align?.setEnabled(true)
    } else if (option == 11) {
        app.label.setText("Artistic text filled and stroke")
    } else if (option == 12) {
        app.label.setText("Rasterized text with alignment and trimming")
        app.slider1?.setEnabled(true)
        app.slider2?.setEnabled(true)
        app.popup_trim?.setEnabled(true)
        app.popup_align?.setEnabled(true)
    } else if (option == 13) {
        app.label.setText("Drawing images with alignment")
    }

    app.view.update()
}

// Event Handlers

@C
func onDraw(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvDraw>()

    let slider1 = app.slider1?.getSlider()
    let slider2 = app.slider2?.getSlider()
    let popup1 = app.popup_trim?.getPopUp()
    let popup2 = app.popup_align?.getPopUp()

    let slider1_pos = slider1?.getValue() ?? 0.5
    let slider2_pos = slider2?.getValue() ?? 0.5
    let text_trim = popup1?.getSelected() ?? 0
    let text_align = popup2?.getSelected() ?? 0

    params.ctx.clear(Color(200, 200, 200))

    match (app.option) {
        case 0 => drawLines(params.ctx)
        case 1 =>
            params.ctx.setFillColor(Color.BLUE)
            drawShapes(params.ctx, false)
        case 2 => drawGradient(params.ctx, slider1_pos, true, false)
        case 3 => drawGradient(params.ctx, slider1_pos, true, true)
        case 4 => drawGradient(params.ctx, slider1_pos, false, true)
        case 5 => drawLinesGradient(params.ctx, slider1_pos)
        case 6 => drawLocalGradient(params.ctx, slider1_pos)
        case 7 => drawWrapGradient(params.ctx)
        case 8 => textSingle(params.ctx, slider1_pos + 0.5, 100.0 + 200.0 * (-0.5 + slider2_pos), text_trim, text_align)
        case 9 => textNewline(params.ctx, slider1_pos + 0.5, text_align)
        case 10 => textBlock(params.ctx, slider1_pos + 0.5, 200.0 + 200.0 * (-0.5 + slider2_pos), text_align)
        case 11 => textArt(params.ctx)
        case 12 => textRaster(params.ctx, slider1_pos + 0.5, 100.0 + 200.0 * (-0.5 + slider2_pos), text_trim, text_align)
        case 13 => imageDraw(params.ctx)
        case _ => ()
    }
}

@C
func onAcceptFocus(_: CPointer<Unit>, e: Event): Unit {
    e.setResult<Bool>(false)
}

@C
func onSelect1(_: CPointer<Unit>, e: Event): Unit {
    let app = App.get()
    let params = e.getParams<EvButton>()
    setDemo(app, params.index)
}

@C
func onSelect2(_: CPointer<Unit>, _: Event): Unit {
    let app = App.get()
    app.view.update()
}

@C
func onSlider(_: CPointer<Unit>, _: Event): Unit {
    let app = App.get()
    app.view.update()
}

@C
func onClose(_: CPointer<Unit>, e: Event): Unit {
    if (e.getType() == GUIEvent.WndClose) {
        OSApp.finish()
    }
}

// Layout

func createPanel(app: App): Panel {
    let layout1 = Layout(1, 3)
    let layout2 = Layout(4, 3)

    let label1 = Label()
    let label2 = Label()
    let label3 = Label()
    let label4 = Label()
    let label5 = Label()
    let label6 = app.label

    let popup1 = PopUp()
    let popup2 = PopUp()
    let popup3 = PopUp()

    let slider1 = Slider()
    let slider2 = Slider()

    label1.setText("Select primitives:")
    label2.setText("Gradient/scale:")
    label3.setText("Text trim:")
    label4.setText("Text width:")
    label5.setText("Text halign:")
    label6.setMultiline(true)

    popup1.addItem("Lines", None)
    popup1.addItem("Shapes", None)
    popup1.addItem("Gradient-1", None)
    popup1.addItem("Gradient-2", None)
    popup1.addItem("Gradient-3", None)
    popup1.addItem("Gradient-4", None)
    popup1.addItem("Gradient-5", None)
    popup1.addItem("Gradient-6", None)
    popup1.addItem("Text-1", None)
    popup1.addItem("Text-2", None)
    popup1.addItem("Text-3", None)
    popup1.addItem("Text-4", None)
    popup1.addItem("Text-5", None)
    popup1.addItem("Image", None)
    popup1.setListHeight(6)

    popup2.addItem("No trim", None)
    popup2.addItem("Ellip begin", None)
    popup2.addItem("Ellip middle", None)
    popup2.addItem("Ellip end", None)

    popup3.addItem("Left", None)
    popup3.addItem("Center", None)
    popup3.addItem("Right", None)

    popup1.onSelect(onSelect1)
    popup2.onSelect(onSelect2)
    popup3.onSelect(onSelect2)
    slider1.onMoved(onSlider)
    slider2.onMoved(onSlider)

    app.view.setSize(S2Df(600.0, 400.0))
    app.view.onDraw(onDraw)
    app.view.onAcceptFocus(onAcceptFocus)

    layout2.add(label1, 0, 0)
    layout2.add(label2, 2, 0)
    layout2.add(label3, 0, 1)
    layout2.add(label4, 2, 1)
    layout2.add(label5, 0, 2)
    layout2.add(popup1, 1, 0)
    layout2.add(popup2, 1, 1)
    layout2.add(popup3, 1, 2)
    layout2.add(slider1, 3, 0)
    layout2.add(slider2, 3, 1)

    layout1.add(layout2, 0, 0)
    layout1.add(label6, 0, 1)
    layout1.add(app.view, 0, 2)

    layout1.setMargin(5.0)
    layout2.setHMargin(0, 10.0)
    layout2.setHMargin(1, 10.0)
    layout2.setHMargin(2, 10.0)
    layout1.setVMargin(0, 5.0)
    layout1.setVMargin(1, 5.0)
    layout1.setHAlign(0, 1, Align.Justify)
    layout2.hExpand(3)

    app.slider1 = layout2.createCell(3, 0)
    app.slider2 = layout2.createCell(3, 1)
    app.popup_trim = layout2.createCell(1, 1)
    app.popup_align = layout2.createCell(1, 2)

    let panel = Panel()
    panel.setLayout(layout1)
    return panel
}

@C
func appCreate(): UIntNative {
    App.get()
    return 1
}

@C
func appDestroy(_: UIntNative): Unit {
    App.destroy()
}

main(): Int64 {
    osmain(onCreate: appCreate, onDestroy: appDestroy)
    return 0
}
