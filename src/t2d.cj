package nappgui4cj

import ctemplate.Template
import std.math.{cos, sin, atan2, abs}

/**
 * Class template for manipulating 2D affine transformations.
 */
@Template[ClassName, VecType, NumType: T2Df, V2Df, Float32 ; T2Dd, V2Dd, Float64](
@C
public struct ClassName {
    public var i: VecType
    public var j: VecType
    public var p: VecType

    /**
     * Default constructor (Identity transformation).
     */
    public const init() {
        i = VecType(1.0, 0.0)
        j = VecType(0.0, 1.0)
        p = VecType(0.0, 0.0)
    }

    /**
     * Construct from axis vectors and position.
     *
     * @param i X-axis vector
     * @param j Y-axis vector
     * @param p Position vector
     */
    public const init(i: VecType, j: VecType, p: VecType) {
        this.i = i
        this.j = j
        this.p = p
    }

    /**
     * Create an identity transformation.
     */
    public static func identity(): ClassName {
        return ClassName()
    }

    /**
     * @brief Overload of binary `operator==` to compare two transformations
     */
    public const operator func ==(right: ClassName): Bool {
        return i == right.i && j == right.j && p == right.p
    }

    /**
     * @brief Overload of binary `operator!=` to compare two transformations
     */
    public const operator func !=(right: ClassName): Bool {
        return i != right.i || j != right.j || p != right.p
    }

    /**
     * @brief Multiply (combine) two transformations.
     *
     * Computes `result = this * right`.
     */
    public const operator func *(right: ClassName): ClassName {
        let ix = i.x * right.i.x + j.x * right.i.y
        let iy = i.y * right.i.x + j.y * right.i.y
        let jx = i.x * right.j.x + j.x * right.j.y
        let jy = i.y * right.j.x + j.y * right.j.y
        let px = i.x * right.p.x + j.x * right.p.y + p.x
        let py = i.y * right.p.x + j.y * right.p.y + p.y

        return ClassName(VecType(ix, iy), VecType(jx, jy), VecType(px, py))
    }

    /**
     * @brief Transform a 2D vector.
     *
     * Applies the transformation to the vector (Translation + Rotation/Scale).
     */
    public const operator func *(right: VecType): VecType {
        let x = i.x * right.x + j.x * right.y + p.x
        let y = i.y * right.x + j.y * right.y + p.y
        return VecType(x, y)
    }

    /**
     * @brief Returns a moved (translated) transformation.
     *
     * @param x X offset
     * @param y Y offset
     * @return A new transformation moved by (x, y)
     */
    public const func move(x: NumType, y: NumType): ClassName {
        let px = p.x + i.x * x + j.x * y
        let py = p.y + i.y * x + j.y * y
        return ClassName(i, j, VecType(px, py))
    }

    /**
     * @brief Returns a rotated transformation.
     *
     * @param angle Rotation angle in radians
     * @return A new transformation rotated by angle
     */
    public func rotate(angle: NumType): ClassName {
        let c = NumType(cos(Float64(angle)))
        let s = NumType(sin(Float64(angle)))

        let ix = i.x * c + j.x * s
        let iy = i.y * c + j.y * s
        let jx = -i.x * s + j.x * c
        let jy = -i.y * s + j.y * c

        return ClassName(VecType(ix, iy), VecType(jx, jy), p)
    }

    /**
     * @brief Returns a scaled transformation.
     *
     * @param sx X scale factor
     * @param sy Y scale factor
     * @return A new transformation scaled by (sx, sy)
     */
    public const func scale(sx: NumType, sy: NumType): ClassName {
        let ni = VecType(i.x * sx, i.y * sx)
        let nj = VecType(j.x * sy, j.y * sy)
        return ClassName(ni, nj, p)
    }

    /**
     * @brief Fast inversion of the transformation.
     *
     * Assumes the transformation is orthogonal (rotation only, no shear).
     * @return A new transformation representing the inverse.
     */
    public const func invfast(): ClassName {
        // Inverse of orthogonal matrix is transpose
        let ni = VecType(i.x, j.x)
        let nj = VecType(i.y, j.y)

        // Inverse translation: -M^T * p
        let px = -(ni.x * p.x + nj.x * p.y)
        let py = -(ni.y * p.x + nj.y * p.y)

        return ClassName(ni, nj, VecType(px, py))
    }

    /**
     * @brief Inversion of a general transformation.
     *
     * Computes the inverse of a potentially non-orthogonal matrix (with shear).
     * @return A new transformation representing the inverse.
     */
    public const func inverse(): ClassName {
        // Determinant of the 2x2 matrix [i.x j.x; i.y j.y]
        let det = i.x * j.y - j.x * i.y

        // Inverse matrix
        let ix = j.y / det
        let iy = -i.y / det
        let jx = -j.x / det
        let jy = i.x / det

        // Inverse translation
        let px = -(ix * p.x + jx * p.y)
        let py = -(iy * p.x + jy * p.y)

        return ClassName(VecType(ix, iy), VecType(jx, jy), VecType(px, py))
    }

    /**
     * @brief Decomposes the transformation into position, angle, and scale.
     *
     * @param pos Box to receive the position vector.
     * @param angle Box to receive the rotation angle in radians.
     * @param sc Box to receive the scale vector.
     */
    public func decompose(pos: Box<VecType>, angle: Box<NumType>, sc: Box<VecType>) {
        // Position is just the translation part
        pos.value = p

        // Angle between X axis and the 'i' vector (X-axis of the transform)
        // atan2(y, x)
        var a = NumType(atan2(Float64(i.y), Float64(i.x)))

        // Calculate scale.
        // The length of the 'i' vector is the X scale.
        // The length of the 'j' vector is the Y scale, adjusted for potential rotation.

        let hpi = NumType(1.57079632679489661923) // PI / 2
        let tolerance: NumType = 0.0001

        if (abs(a - hpi) < tolerance) {
            a = hpi
            sc.value.x = i.y
            sc.value.y = -j.x
        } else if (abs(a + hpi) < tolerance) {
            a = -hpi
            sc.value.x = -i.y
            sc.value.y = j.x
        } else {
            let c = NumType(cos(Float64(a)))
            if (c != 0.0) {
                sc.value.x = i.x / c
                sc.value.y = j.y / c
            } else {
                sc.value.x = 0.0
                sc.value.y = 0.0
            }
        }
        angle.value = a
    }
})
