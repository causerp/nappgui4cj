macro package nappgui4cj.macros

import std.ast.*
import std.reflect.StructTypeInfo

public macro GetName(inputTokens: Tokens) {
    if (inputTokens.size < 1) {
        diagReport(
            DiagReportLevel.ERROR,
            inputTokens,
            "Invalid arguments",
            "Expected 1 argument to get name. Example: @GetName[window_OnClose]"
        )
    }
    return Token(STRING_LITERAL, inputTokens[0].value).toTokens()
}


public macro CellBind(input: Tokens): Tokens {
    let typeInfo = StructTypeInfo.get(input[0].value)
    typeInfo.instanceVariables.iterator()
    quote(cell.dbind(
        structType: @GetName($(input[0])),
        structSize: UInt16(sizeOf<$(input[0])>()),
        memberName: "fuck",
        memberType: "fuck",
        memberOffset: 10,
        memberSize: 10
    ))
}
