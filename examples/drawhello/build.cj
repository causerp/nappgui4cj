import std.process.{launch, ProcessRedirect}

private const CHECK_CMD = "where"
@When[os == "Windows"]
private const IS_WINDOWS = true
@When[os != "Windows"]
private const IS_WINDOWS = false

private func commandExists(name: String): Bool {
    let process = launch(
        CHECK_CMD,
        name,
        stdOut: ProcessRedirect.Discard,
        stdErr: ProcessRedirect.Discard
    )
    return process.wait() == 0
}

private func runCommand(cmd: String, args: Array<String>): Int64 {
    let process = launch(
        cmd,
        args
    )
    return process.wait()
}

private func stagePreBuild(): Int64 {
    let cmd = match {
        case commandExists("windres") => "windres"
        case commandExists("llvm-windres") => "llvm-windres"
        case _ =>
            println("Error: Windows requires 'windres' or 'llvm-windres' to build resource.rc.")
            return 1
    }
    return runCommand(cmd, ["./res/resource.rc", "-O", "coff", "-o", "./res/resource.o"])
}

main(args: Array<String>): Int64 {
    match (args[0]) {
        case "pre-build" where IS_WINDOWS => stagePreBuild()
        case _ => 0
    }
}
