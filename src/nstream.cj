package nappgui4cj

foreign {
    func stm_from_block(data: CPointer<Byte>, size: UInt32): CPointer<Unit>

    func stm_memory(size: UInt32): CPointer<Unit>

    func stm_from_file(pathname: CString, error: CPointer<Int32>): CPointer<Unit>

    func stm_to_file(pathname: CString, error: CPointer<Int32>): CPointer<Unit>

    func stm_append_file(pathname: CString, error: CPointer<Int32>): CPointer<Unit>

    func stm_socket(socket: CPointer<Unit>): CPointer<Unit>

    func stm_close(stm: CPointer<CPointer<Unit>>): Unit

    func stm_get_write_endian(stm: CPointer<Unit>): UInt32

    func stm_get_read_endian(stm: CPointer<Unit>): UInt32

    func stm_set_write_endian(stm: CPointer<Unit>, endian: UInt32): Unit

    func stm_set_read_endian(stm: CPointer<Unit>, endian: UInt32): Unit

    func stm_get_write_utf(stm: CPointer<Unit>): UInt32

    func stm_get_read_utf(stm: CPointer<Unit>): UInt32

    func stm_set_write_utf(stm: CPointer<Unit>, format: UInt32): Unit

    func stm_set_read_utf(stm: CPointer<Unit>, format: UInt32): Unit

    func stm_is_memory(stm: CPointer<Unit>): Bool

    func stm_bytes_written(stm: CPointer<Unit>): UInt64

    func stm_bytes_readed(stm: CPointer<Unit>): UInt64

    func stm_col(stm: CPointer<Unit>): UInt32

    func stm_row(stm: CPointer<Unit>): UInt32

    func stm_token_col(stm: CPointer<Unit>): UInt32

    func stm_token_row(stm: CPointer<Unit>): UInt32

    func stm_token_lexeme(stm: CPointer<Unit>, size: CPointer<UInt32>): CString

    func stm_token_escapes(stm: CPointer<Unit>, active_escapes: Bool): Unit

    func stm_token_spaces(stm: CPointer<Unit>, active_spaces: Bool): Unit

    func stm_token_comments(stm: CPointer<Unit>, active_comments: Bool): Unit

    func stm_state(stm: CPointer<Unit>): UInt32

    func stm_file_err(stm: CPointer<Unit>): Int32

    func stm_sock_err(stm: CPointer<Unit>): Int32

    func stm_corrupt(stm: CPointer<Unit>): Unit

    func stm_str(stm: CPointer<Unit>): CString

    func stm_buffer(stm: CPointer<Unit>): CPointer<Byte>

    func stm_buffer_size(stm: CPointer<Unit>): UInt32

    func stm_write(stm: CPointer<Unit>, data: CPointer<Byte>, size: UInt32): Unit

    func stm_write_char(stm: CPointer<Unit>, codepoint: UInt32): Unit

    // func stm_printf(stm: CPointer<Unit>, format: CString, ...): UInt32

    func stm_writef(stm: CPointer<Unit>, str: CString): UInt32

    func stm_write_bool(stm: CPointer<Unit>, value: Bool): Unit

    func stm_write_i8(stm: CPointer<Unit>, value: Int8): Unit

    func stm_write_i16(stm: CPointer<Unit>, value: Int16): Unit

    func stm_write_i32(stm: CPointer<Unit>, value: Int32): Unit

    func stm_write_i64(stm: CPointer<Unit>, value: Int64): Unit

    func stm_write_u8(stm: CPointer<Unit>, value: UInt8): Unit

    func stm_write_u16(stm: CPointer<Unit>, value: UInt16): Unit

    func stm_write_u32(stm: CPointer<Unit>, value: UInt32): Unit

    func stm_write_u64(stm: CPointer<Unit>, value: UInt64): Unit

    func stm_write_r32(stm: CPointer<Unit>, value: Float32): Unit

    func stm_write_r64(stm: CPointer<Unit>, value: Float64): Unit

    func stm_read(stm: CPointer<Unit>, data: CPointer<Byte>, size: UInt32): UInt32

    func stm_read_char(stm: CPointer<Unit>): UInt32

    func stm_read_chars(stm: CPointer<Unit>, n: UInt32): CString

    func stm_read_line(stm: CPointer<Unit>): CString

    func stm_read_trim(stm: CPointer<Unit>): CString

    func stm_read_token(stm: CPointer<Unit>): UInt32

    func stm_read_i8_tok(stm: CPointer<Unit>): Int8

    func stm_read_i16_tok(stm: CPointer<Unit>): Int16

    func stm_read_i32_tok(stm: CPointer<Unit>): Int32

    func stm_read_i64_tok(stm: CPointer<Unit>): Int64

    func stm_read_u8_tok(stm: CPointer<Unit>): UInt8

    func stm_read_u16_tok(stm: CPointer<Unit>): UInt16

    func stm_read_u32_tok(stm: CPointer<Unit>): UInt32

    func stm_read_u64_tok(stm: CPointer<Unit>): UInt64

    func stm_read_r32_tok(stm: CPointer<Unit>): Float32

    func stm_read_r64_tok(stm: CPointer<Unit>): Float64

    func stm_read_bool(stm: CPointer<Unit>): Bool

    func stm_read_i8(stm: CPointer<Unit>): Int8

    func stm_read_i16(stm: CPointer<Unit>): Int16

    func stm_read_i32(stm: CPointer<Unit>): Int32

    func stm_read_i64(stm: CPointer<Unit>): Int64

    func stm_read_u8(stm: CPointer<Unit>): UInt8

    func stm_read_u16(stm: CPointer<Unit>): UInt16

    func stm_read_u32(stm: CPointer<Unit>): UInt32

    func stm_read_u64(stm: CPointer<Unit>): UInt64

    func stm_read_r32(stm: CPointer<Unit>): Float32

    func stm_read_r64(stm: CPointer<Unit>): Float64

    func stm_skip(stm: CPointer<Unit>, size: UInt32): Unit

    func stm_skip_bom(stm: CPointer<Unit>): Unit

    func stm_skip_token(stm: CPointer<Unit>, token: UInt32): Unit

    func stm_flush(stm: CPointer<Unit>): Unit

    func stm_pipe(from: CPointer<Unit>, to: CPointer<Unit>, n: UInt32): Unit
}

struct NStream <: NappObject {
    var m_handle: CPointer<Unit>

    public init(handle: CPointer<Unit>) {
        m_handle = handle
    }

    public init(data: CPointer<Byte>, size: UInt32) {
        m_handle = unsafe { stm_from_block(data, size) }
    }

    public prop handle: CPointer<Unit> {
        get() {
            m_handle
        }
    }

    public static func fromBlock(data: CPointer<Byte>, size: UInt32): NStream {
        unsafe { NStream(stm_from_block(data, size)) }
    }

    public static func memory(size: UInt32): NStream {
        unsafe { NStream(stm_memory(size)) }
    }

    public static func fromFile(pathname: String, error: CPointer<Int32>): NStream {
        unsafe {
            let strPtr = LibC.mallocCString(pathname)
            let stream = NStream(stm_from_file(strPtr, error))
            LibC.free(strPtr)
            return stream
        }
    }

    public static func toFile(pathname: String, error: CPointer<Int32>): NStream {
        unsafe {
            let strPtr = LibC.mallocCString(pathname)
            let stream = NStream(stm_to_file(strPtr, error))
            LibC.free(strPtr)
            return stream
        }
    }

    public static func appendFile(pathname: String, error: CPointer<Int32>): NStream {
        unsafe {
            let strPtr = LibC.mallocCString(pathname)
            let stream = NStream(stm_append_file(strPtr, error))
            LibC.free(strPtr)
            return stream
        }
    }

    // static func socket(sock: Socket): NStream { ... }

    public func close(): Unit {
        unsafe {
            var ptr = m_handle
            stm_close(inout ptr)
        }
    }

    public func getWriteEndian(): Endian {
        unsafe { Endian(stm_get_write_endian(m_handle)) }
    }

    public func getReadEndian(): Endian {
        unsafe { Endian(stm_get_read_endian(m_handle)) }
    }

    // public func setWriteEndian(endian: Endian): Unit {
    //     unsafe { stm_set_write_endian(m_handle, endian.rawValue) }
    // }

    // public func setReadEndian(endian: Endian): Unit {
    //     unsafe { stm_set_read_endian(m_handle, endian.rawValue) }
    // }

    // public func getWriteUtf(): UnicodeFormat {
    //     unsafe { UnicodeFormat(stm_get_write_utf(m_handle)) }
    // }

    // public func getReadUtf(): UnicodeFormat {
    //     unsafe { UnicodeFormat(stm_get_read_utf(m_handle)) }
    // }

    // public func setWriteUtf(format: UnicodeFormat): Unit {
    //     unsafe { stm_set_write_utf(m_handle, format.rawValue) }
    // }

    // public func setReadUtf(format: UnicodeFormat): Unit {
    //     unsafe { stm_set_read_utf(m_handle, format.rawValue) }
    // }

    public func isMemory(): Bool {
        unsafe { stm_is_memory(m_handle) }
    }

    public func bytesWritten(): UInt64 {
        unsafe { stm_bytes_written(m_handle) }
    }

    public func bytesReaded(): UInt64 {
        unsafe { stm_bytes_readed(m_handle) }
    }

    public func col(): UInt32 {
        unsafe { stm_col(m_handle) }
    }

    public func row(): UInt32 {
        unsafe { stm_row(m_handle) }
    }

    public func tokenCol(): UInt32 {
        unsafe { stm_token_col(m_handle) }
    }

    public func tokenRow(): UInt32 {
        unsafe { stm_token_row(m_handle) }
    }

    public func tokenLexeme(size: CPointer<UInt32>): CString {
        unsafe { stm_token_lexeme(m_handle, size) }
    }

    public func tokenEscapes(active: Bool): Unit {
        unsafe { stm_token_escapes(m_handle, active) }
    }

    public func tokenSpaces(active: Bool): Unit {
        unsafe { stm_token_spaces(m_handle, active) }
    }

    public func tokenComments(active: Bool): Unit {
        unsafe { stm_token_comments(m_handle, active) }
    }

    // public func state(): StreamState {
    //     unsafe { StreamState(stm_state(m_handle)) }
    // }

    // public func fileErr(): FError {
    //     unsafe { FError(stm_file_err(m_handle)) }
    // }

    // public func sockErr(): SError {
    //     unsafe { SError(stm_sock_err(m_handle)) }
    // }

    public func corrupt(): Unit {
        unsafe { stm_corrupt(m_handle) }
    }

    public func str(): String {
        unsafe {
            let cstr = stm_str(m_handle)
            return cstr.toString()
        }
    }

    public func buffer(): CPointer<Byte> {
        unsafe { stm_buffer(m_handle) }
    }

    public func bufferSize(): UInt32 {
        unsafe { stm_buffer_size(m_handle) }
    }

    public func write(data: CPointer<Byte>, size: UInt32): Unit {
        unsafe { stm_write(m_handle, data, size) }
    }

    public func writeChar(codepoint: UInt32): Unit {
        unsafe { stm_write_char(m_handle, codepoint) }
    }

    public func writef(str: String): UInt32 {
        unsafe {
            let cstr = LibC.mallocCString(str)
            let ret = stm_writef(m_handle, cstr)
            LibC.free(cstr)
            return ret
        }
    }

    public func writeBool(value: Bool): Unit {
        unsafe { stm_write_bool(m_handle, value) }
    }

    public func writeI8(value: Int8): Unit {
        unsafe { stm_write_i8(m_handle, value) }
    }

    public func writeI16(value: Int16): Unit {
        unsafe { stm_write_i16(m_handle, value) }
    }

    public func writeI32(value: Int32): Unit {
        unsafe { stm_write_i32(m_handle, value) }
    }

    public func writeI64(value: Int64): Unit {
        unsafe { stm_write_i64(m_handle, value) }
    }

    public func writeU8(value: UInt8): Unit {
        unsafe { stm_write_u8(m_handle, value) }
    }

    public func writeU16(value: UInt16): Unit {
        unsafe { stm_write_u16(m_handle, value) }
    }

    public func writeU32(value: UInt32): Unit {
        unsafe { stm_write_u32(m_handle, value) }
    }

    public func writeU64(value: UInt64): Unit {
        unsafe { stm_write_u64(m_handle, value) }
    }

    public func writeR32(value: Float32): Unit {
        unsafe { stm_write_r32(m_handle, value) }
    }

    public func writeR64(value: Float64): Unit {
        unsafe { stm_write_r64(m_handle, value) }
    }

    public func read(data: CPointer<Byte>, size: UInt32): UInt32 {
        unsafe { stm_read(m_handle, data, size) }
    }

    public func readChar(): UInt32 {
        unsafe { stm_read_char(m_handle) }
    }

    public func readChars(n: UInt32): String {
        unsafe {
            let cstr = stm_read_chars(m_handle, n)
            return cstr.toString()
        }
    }

    public func readLine(): ?String {
        unsafe {
            let cstr = stm_read_line(m_handle)
            if (cstr.isNull()) {
                return None
            }
            return Some(cstr.toString())
        }
    }

    public func readTrim(): ?String {
        unsafe {
            let cstr = stm_read_trim(m_handle)
            if (cstr.isNull()) {
                return None
            }
            return Some(cstr.toString())
        }
    }

    public func readToken(): UInt32 {
        unsafe { stm_read_token(m_handle) }
    }

    public func readI8Tok(): Int8 {
        unsafe { stm_read_i8_tok(m_handle) }
    }

    public func readI16Tok(): Int16 {
        unsafe { stm_read_i16_tok(m_handle) }
    }

    public func readI32Tok(): Int32 {
        unsafe { stm_read_i32_tok(m_handle) }
    }

    public func readI64Tok(): Int64 {
        unsafe { stm_read_i64_tok(m_handle) }
    }

    public func readU8Tok(): UInt8 {
        unsafe { stm_read_u8_tok(m_handle) }
    }

    public func readU16Tok(): UInt16 {
        unsafe { stm_read_u16_tok(m_handle) }
    }

    public func readU32Tok(): UInt32 {
        unsafe { stm_read_u32_tok(m_handle) }
    }

    public func readU64Tok(): UInt64 {
        unsafe { stm_read_u64_tok(m_handle) }
    }

    public func readR32Tok(): Float32 {
        unsafe { stm_read_r32_tok(m_handle) }
    }

    public func readR64Tok(): Float64 {
        unsafe { stm_read_r64_tok(m_handle) }
    }

    public func readBool(): Bool {
        unsafe { stm_read_bool(m_handle) }
    }

    public func readI8(): Int8 {
        unsafe { stm_read_i8(m_handle) }
    }

    public func readI16(): Int16 {
        unsafe { stm_read_i16(m_handle) }
    }

    public func readI32(): Int32 {
        unsafe { stm_read_i32(m_handle) }
    }

    public func readI64(): Int64 {
        unsafe { stm_read_i64(m_handle) }
    }

    public func readU8(): UInt8 {
        unsafe { stm_read_u8(m_handle) }
    }

    public func readU16(): UInt16 {
        unsafe { stm_read_u16(m_handle) }
    }

    public func readU32(): UInt32 {
        unsafe { stm_read_u32(m_handle) }
    }

    public func readU64(): UInt64 {
        unsafe { stm_read_u64(m_handle) }
    }

    public func readR32(): Float32 {
        unsafe { stm_read_r32(m_handle) }
    }

    public func readR64(): Float64 {
        unsafe { stm_read_r64(m_handle) }
    }

    public func skip(size: UInt32): Unit {
        unsafe { stm_skip(m_handle, size) }
    }

    public func skipBom(): Unit {
        unsafe { stm_skip_bom(m_handle) }
    }

    public func skipToken(token: UInt32): Unit {
        unsafe { stm_skip_token(m_handle, token) }
    }

    public func flush(): Unit {
        unsafe { stm_flush(m_handle) }
    }

    public func pipe(to: NStream, n: UInt32): Unit {
        unsafe { stm_pipe(m_handle, to.m_handle, n) }
    }
}
