package nappgui4cj

import ctemplate.Template

/**
 * Class template for manipulating 2-dimensional vectors.
 */
@Template[ClassName, NumType, DefaultValue: S2Df, Float32, 0.0 ; S2Dd, Float64, 0.0](
@C
public struct ClassName {
    public var width: NumType
    public var height: NumType

    /**
     * Default constructor
     */
    public const init() {
        width = DefaultValue
        height = DefaultValue
    }

    /**
     * Construct the vector from cartesian coordinates
     *
     * @param width Width coordinate
     * @param height Height coordinate
     */
    public const init(width: NumType, height: NumType) {
        this.width = width
        this.height = height
    }

    /**
     * Construct the vector from a tuple.
     *
     * @param tuple Tuple containing width and height coordinates
     */
    public const init(tuple: (NumType, NumType)) {
        width = tuple[0]
        height = tuple[1]
    }

    /**
     * Create a vector from a tuple of Int64.
     *
     * @param tuple Tuple containing width and height coordinates
     * @return Vector constructed from the tuple
     */
    public static func create(tuple: (Int64, Int64)): ClassName {
        ClassName(NumType(tuple[0]), NumType(tuple[1]))
    }

    /**
     * Create a vector from a tuple of Float64.
     *
     * @param tuple Tuple containing width and height coordinates
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
        return width == right.width && height == right.height
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
        return width != right.width || height != right.height
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
        return width == right[0] && height == right[1]
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
        return width != right[0] || height != right[1]
    }

    /**
     * Overload of unary `operator-` to negate a vector
     *
     * @param right Vector to negate
     *
     * @return Member-wise opposite of the vector
     */
    public const operator func -(): ClassName {
        return ClassName(-width, -height)
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
        return ClassName(width + right.width, height + right.height)
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
        return ClassName(width - right.width, height - right.height)
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
        return ClassName(width + right[0], height + right[1])
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
        return ClassName(width - right[0], height - right[1])
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
        return ClassName(width * right, height * right)
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
        return ClassName(width / right, height / right)
    }

    /**
     * Convert the vector to a tuple.
     *
     * @return A tuple containing the width and height coordinates
     */
    public func toTuple(): (NumType, NumType) {
        (width, height)
    }
})
