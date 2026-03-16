macro package nappgui4cj.nrc

import std.fs.*
import std.collection.*
import std.sort.*
import std.ast.*
import std.env.getWorkingDirectory

enum ResourceType <: Comparable<ResourceType> & ToString {
    | Message
    | Image
    | File

    public operator func ==(right: ResourceType): Bool {
        match ((this, right)) {
            case (Message, Message) => return true
            case (Image, Image) => return true
            case (File, File) => return true
            case _ => return false
        }
    }

    public operator func !=(right: ResourceType): Bool {
        return !(this == right)
    }

    public func compare(that: ResourceType): Ordering {
        // Implicit ordinal comparison: Message < Image < File
        if (this == that) {
            return Ordering.EQ
        }

        match (this) {
            case Message => return Ordering.LT
            case Image =>
                if (that == Message) {
                    return Ordering.GT
                }
                if (that == File) {
                    return Ordering.LT
                }
                return Ordering.GT
            case File => return Ordering.GT
        }
        return Ordering.EQ
    }

    public operator func <(rhs: ResourceType): Bool {
        return this.compare(rhs) == Ordering.LT
    }

    public operator func <=(rhs: ResourceType): Bool {
        return this.compare(rhs) != Ordering.GT
    }

    public operator func >(rhs: ResourceType): Bool {
        return this.compare(rhs) == Ordering.GT
    }

    public operator func >=(rhs: ResourceType): Bool {
        return this.compare(rhs) != Ordering.LT
    }

    public func toString(): String {
        match (this) {
            case Message => "Str"
            case Image => "Image"
            case File => "File"
        }
    }
}

// Represents a single localized version of a resource
struct LocalizedResource {
    public LocalizedResource(
        let localeCode: String, // e.g., "es_es"
        let text!: String = String.empty, // For messages
        let data!: Array<UInt8> = Array<UInt8>() // For files/images
    ) {}
}

// Represents a global resource (Text or File)
struct Resource <: Comparable<Resource> {
    Resource(
        let name!: String, // e.g., "TEXT_FACE" or "cards.png"
        let kind!: ResourceType,
        let globalText!: String = String.empty, // For messages
        let globalData!: Array<UInt8> = Array<UInt8>(), // For files/images
        let locales!: ArrayList<LocalizedResource> = ArrayList<LocalizedResource>(),
        var index!: Int = 0
    ) {}

    public operator func ==(right: Resource): Bool {
        return this.name == right.name && this.kind == right.kind
    }

    public operator func !=(right: Resource): Bool {
        return !(this == right)
    }

    public func compare(that: Resource): Ordering {
        // 1. Handle Equality
        if (this == that) {
            return Ordering.EQ
        }

        // 2. Compare by Type
        // Uses the ResourceType logic: Message < Image < File
        let typeCompare = this.kind.compare(that.kind)
        if (typeCompare != Ordering.EQ) {
            return typeCompare
        }

        // 3. Compare by Content (Matches i_compare_resource in resgen.c)
        if (this.kind == ResourceType.Message) {
            // Messages are sorted by insertion index (Order of appearance)
            if (this.index < that.index) {
                return Ordering.LT
            }
            if (this.index > that.index) {
                return Ordering.GT
            }
            return Ordering.EQ
        } else {
            // Images and Files are sorted alphabetically by name
            if (this.name < that.name) {
                return Ordering.LT
            }
            if (this.name > that.name) {
                return Ordering.GT
            }
            return Ordering.EQ
        }
    }

    public operator func <(rhs: Resource): Bool {
        return this.compare(rhs) == Ordering.LT
    }

    public operator func <=(rhs: Resource): Bool {
        return this.compare(rhs) != Ordering.GT
    }

    public operator func >(rhs: Resource): Bool {
        return this.compare(rhs) == Ordering.GT
    }

    public operator func >=(rhs: Resource): Bool {
        return this.compare(rhs) != Ordering.LT
    }
}

// The main data structure containing all processed information
struct ResourcePack {
    let localeCodes: ArrayList<String> = ArrayList<String>() // List of found locale codes (e.g., "es_es")
    let resources: ArrayList<Resource> = ArrayList<Resource>()
    let warnings: ArrayList<String> = ArrayList<String>()
    let errors: ArrayList<String> = ArrayList<String>()
}

// Parser logic for .msg files
class MsgParser {
    public func parse(filepath: Path, data: String, pack: ResourcePack, localeIndex: ?Int) {
        var line = 1
        var pos = 0
        let chars = data.toRuneArray()
        let eof = chars.size

        // Jump BOM if present (U+FEFF)
        if (eof >= 1 && chars[0] == Rune(0xFEFF)) {
            pos = 1
        }

        while (pos < eof) {
            // Jump blanks and comments
            pos = jumpBlanksAndComments(chars, pos, eof, line, filepath, pack.errors)
            if (pos >= eof) {
                break
            }

            // Read ID
            let (id, newPos, newLine) = readId(chars, pos, eof, line, filepath, pack.errors)
            pos = newPos
            line = newLine

            if (id.isEmpty()) {
                return
            }

            // Jump blanks again between ID and text
            pos = jumpBlanksAndComments(chars, pos, eof, line, filepath, pack.errors)
            if (pos >= eof) {
                pack
                    .errors
                    .add(
                        "MsgError (${filepath.fileName}:${line}): Unexpected end of file after string ID (${filepath}).")
                return
            }

            // Read Text
            let text = readText(chars, pos, eof)
            pos = text[1] // Update position

            // Add to pack
            processEntry(id, text[0], pack, localeIndex, filepath)
        }
    }

    private func processEntry(id: String, text: String, pack: ResourcePack, localeIndex: ?Int, filepath: Path) {
        if (let Some(idx) <- localeIndex) {
            // Localized message
            let found = pack.resources |> filter({r => r.name == id})
            let first = found.next()
            if (let Some(res) <- first) {
                let locRes = LocalizedResource(pack.localeCodes[idx], text: text)
                res.locales.add(locRes)
            } else {
                pack.warnings.add("Ignored localized text '${id}' in '${filepath}'. Global resource doesn't exist.")
            }
        } else {
            // Global message
            let exists = pack.resources |> any({r => r.name == id})
            if (exists) {
                pack.errors.add("Duplicate resource id in '${filepath}' (${id}).")
            } else {
                pack.resources.add(
                    Resource(
                        name: id,
                        kind: ResourceType.Message,
                        globalText: text,
                        index: pack.resources.size
                    )
                )
            }
        }
    }

    private func jumpBlanksAndComments(chars: Array<Rune>, start: Int, eof: Int, line: Int, path: Path,
        errors: ArrayList<String>): Int {
        var pos = start
        var currentLine = line
        while (pos < eof) {
            let c = chars[pos]
            if (isSpace(c)) {
                if (c == r"\n") {
                    currentLine += 1
                }
                pos += 1
            } else if (pos + 1 < eof && c == r"/" && chars[pos + 1] == r"/") {
                // C++ comment
                pos += 2
                while (pos < eof && chars[pos] != r"\n") {
                    pos += 1
                }
            } else if (pos + 1 < eof && c == r"/" && chars[pos + 1] == r"*") {
                // C comment
                pos += 2
                while (pos < eof) {
                    if (chars[pos] == r"*") {
                        if (pos + 1 < eof && chars[pos + 1] == r"/") {
                            pos += 2
                            break
                        }
                    }
                    if (chars[pos] == r"\n") {
                        currentLine += 1
                    }
                    pos += 1
                }
                if (pos >= eof) {
                    errors.add("MsgError (${path.fileName}:${currentLine}): Comment not closed (${path}).")
                }
            } else {
                break
            }
        }
        return pos
    }

    private func isSpace(c: Rune): Bool {
        return c == r" " || c == r"\t" || c == r"\n" || c == r"\r"
    }

    private func readId(chars: Array<Rune>, start: Int, eof: Int, line: Int, path: Path, errors: ArrayList<String>): (String,
        Int, Int) {
        var pos = start
        if (pos >= eof) {
            return (String.empty, pos, line)
        }

        let c = chars[pos]
        if (!isUpper(c) && c != r"_") {
            errors.add("MsgError (${path.fileName}:${line}): Invalid TEXT_ID (${path}).")
            return (String.empty, pos, line)
        }

        pos += 1
        while (pos < eof) {
            let c2 = chars[pos]
            if (isUpper(c2) || c2 == r"_" || isDigit(c2)) {
                pos += 1
            } else if (isSpace(c2) || c2 == r"/") { // Stop on space or comment start
                break
            } else {
                errors.add("MsgError (${path.fileName}:${line}): Invalid TEXT_ID (${path}).")
                return (String.empty, pos, line)
            }
        }

        return (String(chars[start..pos]), pos, line)
    }

    private func isUpper(c: Rune): Bool {
        return c >= r"A" && c <= r"Z"
    }

    private func isDigit(c: Rune): Bool {
        return c >= r"0" && c <= r"9"
    }

    private func readText(chars: Array<Rune>, start: Int, eof: Int): (String, Int) {
        var pos = start
        while (pos < eof && chars[pos] != r"\n" && chars[pos] != r"\r") {
            pos += 1
        }
        return (String(chars[start..pos]), pos)
    }
}

// Main Compiler Logic
class NrcProcessor {
    public func process(srcDir: Path): ResourcePack {
        let pack = ResourcePack()
        let parser = MsgParser()

        // 1. Process global resources (files in root)
        try {
            Directory.walk(srcDir) {
                info: FileInfo =>
                    if (info.isRegular()) {
                        processFile(info.path, pack, None)
                    }
                    return true // continue traversal
            }
        } catch (ex: Exception) {
            pack.errors.add("Error reading '${srcDir}' resource directory.")
        }

        // 2. Process localized resources (subdirectories)
        try {
            let entries = Directory.readFrom(srcDir)
            for (info in entries) {
                if (info.isDirectory()) {
                    processLocaleDir(info.path, pack, parser)
                }
            }
        } catch (ex: Exception) {
            pack.errors.add("Error reading '${srcDir}' subdirectories.")
        }

        // 3. Sort resources
        // Uses the Resource.compare logic (Messages by index, Files by name)
        sort<Resource>(pack.resources)

        // 4. Re-index resources
        for (i in 0..pack.resources.size) {
            var res = pack.resources[i]
            res.index = i
            pack.resources[i] = res
        }

        return pack
    }

    private func processLocaleDir(dirPath: Path, pack: ResourcePack, parser: MsgParser) {
        let localeCode = dirPath.fileName.replace(".", "_").toAsciiUpper() // e.g., "es_es"
        pack.localeCodes.add(localeCode)
        let localeIndex = pack.localeCodes.size - 1

        try {
            let entries = Directory.readFrom(dirPath)
            for (info in entries) {
                if (info.isRegular()) {
                    let path = info.path
                    let ext = path.extensionName
                    if (ext == "msg") {
                        // Parse message file
                        try {
                            let content = String.fromUtf8(File.readFrom(path))
                            parser.parse(path, content, pack, Some<Int>(localeIndex))
                        } catch (ex: Exception) {
                            pack.errors.add("Failed to read localized file '${path}'")
                        }
                    } else if (isResourceFile(ext)) {
                        // Read binary file
                        processFile(path, pack, Some<Int>(localeIndex))
                    }
                }
            }
        } catch (ex: Exception) {
            pack.errors.add("Error reading locale directory '${dirPath}'")
        }
    }

    private func processFile(filepath: Path, pack: ResourcePack, localeIndex: ?Int) {
        let ext = filepath.extensionName
        let name = filepath.fileName.replace(".", "_").toAsciiUpper()

        if (ext == "msg") {
            // Global message file
            try {
                let content = String.fromUtf8(File.readFrom(filepath))
                MsgParser().parse(filepath, content, pack, localeIndex)
            } catch (ex: Exception) {
                pack.errors.add("Failed to read file '${filepath}'")
            }
            return
        }

        if (!isResourceFile(ext)) {
            pack.warnings.add("Ignored resource file '${filepath}' (Unknown type).")
            return
        }

        let resKind = getResourceKind(ext)

        // Load binary data
        var data: Array<UInt8>
        try {
            data = File.readFrom(filepath)
        } catch (ex: Exception) {
            pack.errors.add("Can't load resource file '${filepath}'")
            return
        }

        if (let Some(idx) <- localeIndex) {
            // Localized file
            let found = pack.resources |> filter({r => r.name == name})
            if (let Some(res) <- found.next()) {
                let locRes = LocalizedResource(pack.localeCodes[idx], data: data)
                res.locales.add(locRes)
            } else {
                let locale = pack.localeCodes[idx]
                pack.warnings.add("Ignored localized file '${name}' in '${locale}'. Global resource doesn't exist.")
            }
        } else {
            // Global file
            let exists = pack.resources |> any({r => r.name == name})
            if (exists) {
                pack.errors.add("Duplicate resource id '${filepath}' (${name}).")
            } else {
                pack.resources.add(
                    Resource(
                        name: name,
                        kind: resKind,
                        globalData: data,
                        index: pack.resources.size,
                    )
                )
            }
        }
    }

    private static let imageExtensions = ["png", "jpg", "gif", "bmp"]
    private static let resourceExtensions = imageExtensions.clone().concat("msg")

    private func isResourceFile(ext: String): Bool {
        return resourceExtensions.contains(ext)
    }

    private func getResourceKind(ext: String): ResourceType {
        if (imageExtensions.contains(ext)) {
            return ResourceType.Image
        }
        return ResourceType.File
    }
}

/**
 * Generates the constant ID for a resource.
 */
private func generateResourceId(resName: String, res: Resource): Tokens {
    let dataName = Token(IDENTIFIER, "${res.name}_CSTRING")
    let name = Token(IDENTIFIER, res.name)
    let value = "N23R3C75::${resName}::${res.index}".toArray().concat(0)
    return quote(private var $(dataName): VArray<UInt8, \$$(value.size)> = $(value)
        let $(name): ResId = unsafe { resIdCreate(inout $(dataName)) }
    )
}

/**
 * Generates data constants for messages, files and images.
 */
private func generateResourceData(res: Resource): Tokens {
    let output = quote()
    match (res.kind) {
        case Message =>
            // Default text
            let name = Token(IDENTIFIER, "${res.name}_TEXT")
            let value = res.globalText.toArray().concat(0)
            output.append(quote(var $(name): VArray<UInt8, \$$(value.size)> = $(value)))
            output.append(Token(TokenKind.NL))

            // Localized text
            for (locale in res.locales) {
                let name = Token(IDENTIFIER, "${res.name}_${locale.localeCode}_TEXT")
                let value = locale.text.toArray().concat(0)
                output.append(quote(var $(name): VArray<UInt8, \$$(value.size)> = $(value)))
                output.append(Token(TokenKind.NL))
            }
        case Image | File =>
            // Default data
            let name = Token(IDENTIFIER, "${res.name}_DATA")
            let value = res.globalData
            // Using specific VArray syntax requested
            output.append(quote(var $(name): VArray<UInt8, \$$(value.size)> = $(value)))
            output.append(Token(TokenKind.NL))

            // Localized data
            for (locale in res.locales) {
                let name = Token(IDENTIFIER, "${res.name}_${locale.localeCode}_DATA")
                let value = locale.data
                output.append(quote(var $(name): VArray<UInt8, \$$(value.size)> = $(value)))
                output.append(Token(TokenKind.NL))
            }
    }
    return output
}

/**
 * Generates the main respack loading function with automated locale handling.
 */
private func generateRespackFunction(resName: String, pack: ResourcePack): Tokens {
    // 1. Collect unique locale codes (e.g., "es_es")
    let localeSet = HashSet<String>()
    for (res in pack.resources) {
        for (loc in res.locales) {
            localeSet.add(loc.localeCode)
        }
    }

    // 2. Helper to generate loading statements for Messages (Text)
    func generateTextBody(localeSuffix: String): Tokens {
        let body = quote()
        // Fix double underscore using match expression
        let sep = match (localeSuffix.isEmpty()) {
            case true => ""
            case false => "_"
        }

        for (res in pack.resources) {
            if (res.kind == ResourceType.Message) {
                let varName = Token(IDENTIFIER, "${res.name}${sep}${localeSuffix}_TEXT")
                body.append(quote(resPackAddMsg(pack, inout $(varName))))
                body.append(Token(TokenKind.NL))
            }
        }
        return body
    }

    // 3. Helper to generate loading statements for Images/Files (Binary)
    func generateBinaryBody(localeCode: String): Tokens {
        let body = quote()
        for (res in pack.resources) {
            if (res.kind != ResourceType.Message) {
                let resType = Token(IDENTIFIER, res.kind.toString())

                // Default to global data
                var varName = Token(IDENTIFIER, "${res.name}_DATA")
                var varSize = Token(IDENTIFIER, "${res.name}_DATA.size")

                // If we are in a locale context, check if a localized file exists
                if (!localeCode.isEmpty()) {
                    let found = res.locales |> filter({ l => l.localeCode == localeCode })
                    if (let Some(loc) <- found.next()) {
                        varName = Token(IDENTIFIER, "${res.name}_${localeCode}_DATA")
                        varSize = Token(IDENTIFIER, "${res.name}_${localeCode}_DATA.size")
                    }
                }

                body.append(quote(resPackAddCData(pack, ResType.$(resType), inout $(varName), UInt32($(varSize)))))
                body.append(Token(TokenKind.NL))
            }
        }
        return body
    }

    // 4. Construct the function signature
    let funcNameStr = "${resName}ResPack"
    let funcName = Token(IDENTIFIER, funcNameStr)
    let embedName = Token(STRING_LITERAL, resName)

    // 5. Build match cases
    let matchBody = quote()

    // Sort for deterministic output
    let sortedLocales = ArrayList<String>(localeSet)
    sort(sortedLocales)

    // Generate specific locale cases
    for (loc in sortedLocales) {
        // Use toAsciiLower to ensure generated code compares correctly
        let locCheck = Token(STRING_LITERAL, loc.toAsciiLower())

        matchBody.append(quote(case $(locCheck) =>))
        matchBody.append(Token(TokenKind.NL))

        // Add localized text
        let textBody = generateTextBody(loc)
        matchBody.append(textBody)

        // Add binary resources
        let binaryBody = generateBinaryBody(loc)
        matchBody.append(binaryBody)
    }

    // 6. Build default (fallback) case
    let defaultTextBody = generateTextBody("")

    matchBody.append(quote(case _ =>))
    matchBody.append(Token(TokenKind.NL))

    // Add default text
    matchBody.append(defaultTextBody)

    // Add binary resources
    let defaultBinaryBody = generateBinaryBody("")
    matchBody.append(defaultBinaryBody)

    // 7. Assemble final function
    return quote(
        @C
        func $(funcName)(locale: CString): ResPack {
            unsafe {
                let pack = ResPack.createEmbedded($(embedName))
                match (locale.toString()) {
                    $(matchBody)
                }
                return pack
            }
        }
    )
}

/**
 * @brief Macro to read resources from a directory and generate constants.
 * Usage: @NRC["res"]
 */
public macro NRC(inputTokens: Tokens) {
    // 1. Parse Arguments
    if (inputTokens.size != 1) {
        diagReport(
            DiagReportLevel.ERROR,
            inputTokens,
            "Invalid arguments",
            "Expected 1 string argument for directory. Example: @NRC[\"res\"]"
        )
    }

    let resNameToken = inputTokens[0]
    let relativePath = match (resNameToken.kind) {
        case STRING_LITERAL | MULTILINE_STRING | MULTILINE_RAW_STRING => resNameToken.value
        case _ =>
            diagReport(
                DiagReportLevel.ERROR,
                inputTokens,
                "Invalid path",
                "Resource path must be a string literal."
            )
            String.empty
    }

    // 2. Resolve Path
    let resPath = getWorkingDirectory().join(relativePath)
    let resName = resPath.fileNameWithoutExtension

    // 3. Run the original logic
    let processor = NrcProcessor()
    let pack = processor.process(resPath)

    // 4. Check for errors found during processing
    if (pack.errors.size > 0) {
        for (err in pack.errors) {
            diagReport(DiagReportLevel.ERROR, inputTokens, "Resource Error", err)
        }
    }

    // 5. Generate Code
    let output = quote()

    // Resource IDs
    for (res in pack.resources) {
        output.append(generateResourceId(resName, res))
    }

    output.append(Token(TokenKind.NL))

    // Resource Data (Text and Binary)
    for (res in pack.resources) {
        output.append(generateResourceData(res))
    }

    // Loading Function
    output.append(generateRespackFunction(resName, pack))

    return output
}
