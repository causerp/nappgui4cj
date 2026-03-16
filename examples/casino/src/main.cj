package casino

import nappgui4cj.*
import std.math.floor

public const DefPadding: Float32 = 0.15
public const DefCorner: Float32 = 0.15
public const DefRadius: Float32 = 0.35

// Internal constant
private const MaxPadding: Float32 = 0.2

public func die_draw(
    ctx: DCtx,
    x: Float32,
    y: Float32,
    width: Float32,
    height: Float32,
    padding: Float32,
    corner: Float32,
    radius: Float32,
    face: UInt32
): Unit {
    let white = Color.WHITE
    let black = Color.BLACK

    var dsize: Float32 = 0.0
    var dx: Float32
    var dy: Float32
    var rc: Float32
    var rr: Float32
    var p1: Float32
    var p2: Float32
    var p3: Float32

    // Calculate die size (take the smaller dimension)
    dsize = match (width < height) {
        case true => width
        case false => height
    }

    // Adjust size based on padding
    dsize -= floor(2.0 * dsize * padding * MaxPadding)

    // Center the die in the provided rectangle
    dx = x + 0.5 * (width - dsize)
    dy = y + 0.5 * (height - dsize)

    // Calculate corner radius and dot radius based on size
    rc = dsize * (0.1 + 0.3 * corner)
    rr = dsize * (0.05 + 0.1 * radius)

    // Pre-calculate dot positions relative to dx/dy
    p1 = 0.5 * dsize // Center
    p2 = 0.2 * dsize // Top/Left
    p3 = 0.8 * dsize // Bottom/Right

    // Draw white rounded rectangle (the die body)
    ctx.setFillColor(white)
    ctx.drawRoundedRect(DrawOp.Fill, dx, dy, dsize, dsize, rc)

    // Draw black dots
    ctx.setFillColor(black)

    // Center dot (1, 3, 5)
    if (face == 1 || face == 3 || face == 5) {
        ctx.drawCircle(DrawOp.Fill, dx + p1, dy + p1, rr)
    }

    // Top-Right and Bottom-Left dots (2, 3, 4, 5, 6)
    if (face != 1) {
        ctx.drawCircle(DrawOp.Fill, dx + p3, dy + p2, rr) // TR
        ctx.drawCircle(DrawOp.Fill, dx + p2, dy + p3, rr) // BL
    }

    // Top-Left and Bottom-Right dots (4, 5, 6)
    if (face == 4 || face == 5 || face == 6) {
        ctx.drawCircle(DrawOp.Fill, dx + p2, dy + p2, rr) // TL
        ctx.drawCircle(DrawOp.Fill, dx + p3, dy + p3, rr) // BR
    }

    // Middle-Left and Middle-Right dots (6)
    if (face == 6) {
        ctx.drawCircle(DrawOp.Fill, dx + p2, dy + p1, rr) // ML
        ctx.drawCircle(DrawOp.Fill, dx + p3, dy + p1, rr) // MR
    }
}
