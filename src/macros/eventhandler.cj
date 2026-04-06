macro package nappgui4cj.macros

import std.ast.*

private func getEventHandlerFuncNames(inputTokens: Tokens): (funcName: Token, cFuncName: Token) {
    if (inputTokens.size != 1) {
        diagReport(
            DiagReportLevel.ERROR,
            inputTokens,
            "Invalid arguments",
            "Expected 1 argument for function name. Example: @EventHandler[window_OnClose]"
        )
    }
    let funcNameToken = inputTokens[0]
    return match (funcNameToken.kind) {
        case IDENTIFIER =>
            let parts = funcNameToken.value.split("_O")
            if (parts.size != 2) {
                diagReport(
                    DiagReportLevel.ERROR,
                    inputTokens,
                    "Invalid function name",
                    "Expected function name to include \"_O\" in it. Example: window_OnClose"
                )
            }
            let cFuncName = "o${parts[1]}"
            (Token(IDENTIFIER, cFuncName), funcNameToken)
        case _ =>
            diagReport(
                DiagReportLevel.ERROR,
                inputTokens,
                "Invalid identifier",
                "Invalid identifier"
            )
            throw Exception()
    }
}

public macro EventHandler(inputTokens: Tokens) {
    let (funcName, cFuncName) = getEventHandlerFuncNames(inputTokens)
    return quote(public func $(funcName)<T>(function: EventHandlerFunc<T>, obj!: CPointer<T>): Unit where T <: CType {
        let listener = Listener.create(obj, function)
        unsafe { $(cFuncName)(m_handle, listener) }
    }

    public func $(funcName)(function: EventHandlerFunc<Unit>, obj!: NappObject): Unit {
        $(funcName)(function, obj: obj.handle)
    }

    public func $(funcName)(function: EventHandlerFunc<Unit>): Unit {
        $(funcName)(function, obj: this.m_handle)
    })
}

public macro StaticEventHandler(inputTokens: Tokens) {
    let (funcName, cFuncName) = getEventHandlerFuncNames(inputTokens)
    return quote(public func $(funcName)<T>(function: EventHandlerFunc<T>, obj!: CPointer<T>): Unit where T <: CType {
        let listener = Listener.create(obj, function)
        unsafe { $(cFuncName)(listener) }
    }

    public func $(funcName)(function: EventHandlerFunc<Unit>, obj!: NappObject): Unit {
        $(funcName)(function, obj: obj.handle)
    })
}
