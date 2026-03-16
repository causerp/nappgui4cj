package nappgui4cj

public struct Handle <: Resource {
    var m_handle: CPointer<Unit>
    var m_isOwner: Bool

    public init() {
        this.m_handle = CPointer()
        this.m_isOwner = false
    }

    public init(handle: CPointer<Unit>) {
        this.m_handle = handle
        this.m_isOwner = true
    }

    public func isClosed(): Bool {
        return m_handle.isNull()
    }

    public func close(): Unit {
        if (m_isOwner && m_handle.isNotNull()) {
        }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public prop isOwner: Bool {
        get() {
            m_isOwner
        }
    }
}
