package bricks

import nappgui4cj.*

const NUM_BRICKS: Int64 = 40
const BALL_RADIUS: Float32 = 0.03
const BRICK_HEIGHT: Float32 = 0.03
const BRICK_SEPARATION: Float32 = 0.005
const BRICKS_PER_ROW: UInt32 = 10
const NUM_ROWS: UInt32 = 4

struct Brick {
    var x: Float32 = 0.0
    var y: Float32 = 0.0
    var color: UInt8 = 0
    var isVisible: Bool = false
}

class App <: Resource {
    private static var m_app: ?App = None

    var isRunning: Bool = false
    var bricks: Array<Brick> = Array<Brick>(NUM_BRICKS, repeat: Brick())
    var color: Array<Color> = Array<Color>(4, repeat: Color(0, 0, 0))
    var brickWidth: Float32 = 0.0
    var playerPos: Float32 = 0.0
    var ballX: Float32 = 0.0
    var ballY: Float32 = 0.0
    var ballDir: V2Df = V2Df(0.0, 0.0)
    var ballSpeed: Float32 = 0.0
    var window: Window
    var button: ?Cell
    var slider: Slider
    var view: View

    private init() {
        window = Window(WindowFlag.StdRes)
        button = None
        slider = Slider(SlHorizontal)
        view = View()

        window.setPanel(createPanel(this))
        window.setTitle("Bricks - A 2D Game")
        window.setOrigin(V2Df(200.0, 200.0))
        window.onClose(onClose)
        window.show()
        initGame(this)
    }

    static func get(): App {
        match (m_app) {
            case Some(app) => return app
            case None =>
                let app = App()
                m_app = app
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

func collision(brick: Brick, brickWidth: Float32, ballX: Float32, ballY: Float32): Bool {
    if (ballX + BALL_RADIUS < brick.x) {
        return false
    }
    if (ballX - BALL_RADIUS > brick.x + brickWidth) {
        return false
    }
    if (ballY + BALL_RADIUS < brick.y) {
        return false
    }
    if (ballY - BALL_RADIUS > brick.y + BRICK_HEIGHT) {
        return false
    }
    return true
}

@C
func onDraw(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvDraw>() ?? return
    let app = App.get()
    let ctx = params.ctx

    let green = Color(102, 153, 26)
    ctx.clear(green)
    ctx.setLineColor(Color.BLACK)

    for (i in 0..NUM_BRICKS) {
        let brick = app.bricks[i]
        if (brick.isVisible) {
            let x = brick.x * params.width
            let y = brick.y * params.height
            let width = app.brickWidth * params.width
            let height = BRICK_HEIGHT * params.height
            ctx.setFillColor(app.color[Int64(brick.color)])
            ctx.drawRect(DrawOp.FillSk, x, y, width, height)
        }
    }

    // Draw Player
    let px = (app.playerPos - app.brickWidth) * params.width
    let py = (1.0 - BRICK_HEIGHT - BRICK_SEPARATION) * params.height
    let pw = 2.0 * app.brickWidth * params.width
    let ph = BRICK_HEIGHT * params.height
    ctx.setFillColor(Color.BLACK)
    ctx.drawRect(DrawOp.Fill, px, py, pw, ph)

    // Draw Ball
    let bx = app.ballX * params.width
    let by = app.ballY * params.height
    let br = BALL_RADIUS * params.width
    ctx.setFillColor(Color.WHITE)
    ctx.drawCircle(DrawOp.Fill, bx, by, br)
}

@C
func onSlider(_: CPointer<Unit>, e: Event): Unit {
    let params = e.getParams<EvSlider>() ?? return
    let app = App.get()
    app.playerPos = params.pos
}

@C
func onStart(_: CPointer<Unit>, _: Event): Unit {
    let app = App.get()
    app.isRunning = true
    app.button?.setEnabled(false)
}

func initGame(app: App): Unit {
    app.color[0] = Color(255, 0, 0)
    app.color[1] = Color(0, 255, 0)
    app.color[2] = Color(0, 0, 255)
    app.color[3] = Color(0, 255, 255)

    var hoffset: Float32 = BRICK_SEPARATION

    app.isRunning = false
    app.brickWidth = (1.0 - (Float32(BRICKS_PER_ROW) + 1.0) * BRICK_SEPARATION) / Float32(BRICKS_PER_ROW)

    var brickIndex = 0

    for (j in 0..NUM_ROWS) {
        var woffset: Float32 = BRICK_SEPARATION

        for (_ in 0..BRICKS_PER_ROW) {
            var brick = app.bricks[brickIndex]
            brick.x = woffset
            brick.y = hoffset
            brick.isVisible = true
            brick.color = UInt8(j)
            app.bricks[brickIndex] = brick

            woffset += app.brickWidth + BRICK_SEPARATION
            brickIndex++
        }
        hoffset += BRICK_HEIGHT + BRICK_SEPARATION
    }

    app.playerPos = app.slider.getValue()
    app.ballX = 0.5
    app.ballY = 0.5
    app.ballDir.x = 0.3
    app.ballDir.y = -0.1
    app.ballSpeed = 0.6
    app.ballDir = app.ballDir.normalized()
}

func createLayout(app: App): Layout {
    let layout = Layout(1, 4)
    let label = Label()

    app.view.setSize(S2Df(258.0, 344.0))
    app.view.onDraw(onDraw)

    app.slider.onMoved(onSlider)

    label.setText("Use the slider!")

    let button = Button(BtnPush)
    button.setText("Start")
    button.onClick(onStart)

    layout.add(app.view, 0, 0)
    layout.add(app.slider, 0, 1)
    layout.add(label, 0, 2)
    layout.add(button, 0, 3)

    layout.vExpand(0)
    layout.setVMargin(0, 10.0)
    layout.setVMargin(2, 10.0)
    layout.setMargin(10.0)

    app.button = layout.createCell(0, 3)

    return layout
}

func createPanel(app: App): Panel {
    let panel = Panel()
    let layout = createLayout(app)
    panel.setLayout(layout)
    return panel
}

@C
func onClose(_: CPointer<Unit>, e: Event): Unit {
    if (e.getType() == GUIEvent.WndClose) {
        OSApp.finish()
    }
}

@C
func appUpdate(_: UIntNative, prtime: Float64, ctime: Float64): Unit {
    let app = App.get()
    if (app.isRunning) {
        let step = Float32(ctime - prtime)

        // Update ball
        app.ballX += step * app.ballSpeed * app.ballDir.x
        app.ballY += step * app.ballSpeed * app.ballDir.y

        // Collision limits
        if (app.ballX + BALL_RADIUS >= 1.0 && app.ballDir.x >= 0.0) {
            app.ballDir.x = -app.ballDir.x
        }
        if (app.ballX - BALL_RADIUS <= 0.0 && app.ballDir.x <= 0.0) {
            app.ballDir.x = -app.ballDir.x
        }
        if (app.ballY - BALL_RADIUS <= 0.0 && app.ballDir.y <= 0.0) {
            app.ballDir.y = -app.ballDir.y
        }

        // Collision bricks
        var collided = false
        for (i in 0..NUM_BRICKS) {
            if (app.bricks[i].isVisible) {
                if (collision(app.bricks[i], app.brickWidth, app.ballX, app.ballY)) {
                    var brick = app.bricks[i]
                    brick.isVisible = false
                    app.bricks[i] = brick
                    if (!collided) {
                        let brick_x = app.bricks[i].x + 0.5 * app.brickWidth
                        app.ballDir.x = 5.0 * (app.ballX - brick_x)
                        app.ballDir.y = -app.ballDir.y
                        app.ballDir = app.ballDir.normalized()
                        collided = true
                    }
                }
            }
        }

        // Collision player
        var playerBrick = Brick()
        playerBrick.x = app.playerPos - app.brickWidth
        playerBrick.y = 1.0 - BRICK_HEIGHT - BRICK_SEPARATION
        if (collision(playerBrick, 2.0 * app.brickWidth, app.ballX, app.ballY)) {
            app.ballDir.x = 5.0 * (app.ballX - app.playerPos)
            app.ballDir.y = -app.ballDir.y
            app.ballDir = app.ballDir.normalized()
        }

        // Game Over
        if (app.ballY + BALL_RADIUS >= 1.0) {
            initGame(app)
            app.button?.setEnabled(true)
        }
    }
    app.view.update()
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
    osmain_sync(lframe: 0.04, onCreate: appCreate, onUpdate: appUpdate, onDestroy: appDestroy)
    return 0
}
