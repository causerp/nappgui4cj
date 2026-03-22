package nappgui4cj

import ctemplate.Template
import std.math.sqrt

/**
 * Class template for manipulating 2-dimensional vectors.
 */
@Template[ClassName, NumType, DefaultValue: V2Df, Float32, 0.0 ; V2Dd, Float64, 0.0](
@C
public struct ClassName {
    public var x: NumType
    public var y: NumType

    /**
     * Default constructor
     */
    public const init() {
        x = DefaultValue
        y = DefaultValue
    }

    /**
     * Construct the vector from cartesian coordinates
     *
     * @param x X coordinate
     * @param y Y coordinate
     */
    public const init(x: NumType, y: NumType) {
        this.x = x
        this.y = y
    }

    /**
     * Construct the vector from a tuple.
     *
     * @param tuple Tuple containing x and y coordinates
     */
    public const init(tuple: (NumType, NumType)) {
        x = tuple[0]
        y = tuple[1]
    }

    /**
     * Create a vector from a tuple of Int64.
     *
     * @param tuple Tuple containing x and y coordinates
     * @return Vector constructed from the tuple
     */
    public static func create(tuple: (Int64, Int64)): ClassName {
        ClassName(NumType(tuple[0]), NumType(tuple[1]))
    }

    /**
     * Create a vector from a tuple of Float64.
     *
     * @param tuple Tuple containing x and y coordinates
     * @return Vector constructed from the tuple
     */
    public static func create(tuple: (Float64, Float64)): ClassName {
        ClassName(NumType(tuple[0]), NumType(tuple[1]))
    }

    /**
     * @brief Overload of binary `operator==` to compare two vectors
     *
     * This operator compares strict equality between two vectors.
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a vector)
     *
     * @return `true` if `left` is equal to `right`
     */
    public const operator func ==(right: ClassName): Bool {
        return x == right.x && y == right.y
    }

    /**
     * @brief Overload of binary `operator!=` to compare two vectors
     *
     * This operator compares strict difference between two vectors.
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a vector)
     *
     * @return `true` if `left` is not equal to `right`
     */
    public const operator func !=(right: ClassName): Bool {
        return x != right.x || y != right.y
    }

    /**
     * @brief Overload of binary `operator==` to compare a vector and a tuple
     *
     * This operator compares strict equality between a vector and a tuple.
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a tuple)
     *
     * @return `true` if `left` is equal to `right`
     */
    public const operator func ==(right: (NumType, NumType)): Bool {
        return x == right[0] && y == right[1]
    }

    /**
     * @brief Overload of binary `operator!=` to compare a vector and a tuple
     *
     * This operator compares strict difference between a vector and a tuple.
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a tuple)
     *
     * @return `true` if `left` is not equal to `right`
     */
    public const operator func !=(right: (NumType, NumType)): Bool {
        return x != right[0] || y != right[1]
    }

    /**
     * Overload of unary `operator-` to negate a vector
     *
     * @param right Vector to negate
     *
     * @return Member-wise opposite of the vector
     */
    public const operator func -(): ClassName {
        return ClassName(-x, -y)
    }

    /**
     * @brief Overload of binary `operator+` to add two vectors
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a vector)
     *
     * @return Member-wise addition of both vectors
     */
    public const operator func +(right: ClassName): ClassName {
        return ClassName(x + right.x, y + right.y)
    }

    /**
     * @brief Overload of binary `operator-` to subtract two vectors
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a vector)
     *
     * @return Member-wise subtraction of both vectors
     */
    public const operator func -(right: ClassName): ClassName {
        return ClassName(x - right.x, y - right.y)
    }

    /**
     * @brief Overload of binary `operator+` to add a vector and a tuple
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a tuple)
     *
     * @return Member-wise addition of the vector and tuple
     */
    public const operator func +(right: (NumType, NumType)): ClassName {
        return ClassName(x + right[0], y + right[1])
    }

    /**
     * @brief Overload of binary `operator-` to subtract a tuple from a vector
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a tuple)
     *
     * @return Member-wise subtraction of the tuple from the vector
     */
    public const operator func -(right: (NumType, NumType)): ClassName {
        return ClassName(x - right[0], y - right[1])
    }

    /**
     * @brief Overload of binary `operator*` to scale a vector
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a scalar value)
     *
     * @return Member-wise multiplication by `right`
     */
    public const operator func *(right: NumType): ClassName {
        return ClassName(x * right, y * right)
    }

    /**
     * @brief Overload of binary `operator/` to scale a vector
     *
     * @param left  Left operand (a vector)
     * @param right Right operand (a scalar value)
     *
     * @return Member-wise division by `right`
     */
    public const operator func /(right: NumType): ClassName {
        return ClassName(x / right, y / right)
    }

    /**
     * Convert the vector to a tuple.
     *
     * @return A tuple containing the x and y coordinates
     */
    public func toTuple(): (NumType, NumType) {
        (x, y)
    }

    /**
     * @brief Dot product of two 2D vectors.
     */
    public const func dot(right: ClassName): NumType {
        return x * right.x + y * right.y
    }

    /**
     * @brief Z component of the cross product of two 2D vectors.
     *
     * Treats the operands as 3D vectors, computes their cross product
     * and returns the result's Z component (X and Y components are always zero).
     */
    public const func cross(right: ClassName): NumType {
        return x * right.y - y * right.x
    }

    /**
     * @brief Square of vector's length.
     *
     * Suitable for comparisons, more efficient than `length()`.
     */
    public const func lengthSquared(): NumType {
        return x * x + y * y
    }

    /**
     * @brief Length of the vector.
     *
     * If you are not interested in the actual length, but only in comparisons, consider using `lengthSquared()`.
     */
    public func length(): NumType {
        return NumType(sqrt(Float64(x * x + y * y)))
    }

    /**
     * @brief Vector with same direction but length 1.
     *
     * @pre `this` is no zero vector.
     */
    public func normalized(): ClassName {
        let len = length()
        if (len != 0.0) {
            return ClassName(x / len, y / len)
        }
        return ClassName()
    }

    /**
     * @brief Component-wise multiplication of `this` and `rhs`.
     *
     * Computes `(lhs.x*rhs.x, lhs.y*rhs.y)`.
     *
     * Scaling is the most common use case for component-wise multiplication/division.
     * This operation is also known as the Hadamard or Schur product.
     */
    public const func componentWiseMul(right: ClassName): ClassName {
        return ClassName(x * right.x, y * right.y)
    }

    /**
     * @brief Component-wise division of `this` and `rhs`.
     *
     * Computes `(lhs.x/rhs.x, lhs.y/rhs.y)`.
     *
     * Scaling is the most common use case for component-wise multiplication/division.
     */
    public const func componentWiseDiv(right: ClassName): ClassName {
        return ClassName(x / right.x, y / right.y)
    }

    /**
     * @brief Returns a perpendicular vector.
     *
     * Returns `this` rotated by +90 degrees; (x,y) becomes (-y,x).
     * For example, the vector (1,0) is transformed to (0,1).
     */
    public const func perpendicular(): ClassName {
        return ClassName(-y, x)
    }
})
