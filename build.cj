import std.collection.ArrayList
import std.process.{launch, ProcessRedirect}
import std.fs.{Directory, exists, FileInfo, Path, removeIfExists}

@When[os == "Windows"]
private const CHECK_CMD = "where"
@When[os != "Windows"]
private const CHECK_CMD = "which"
@When[os == "Windows"]
private const IS_WINDOWS = true
@When[os != "Windows"]
private const IS_WINDOWS = false
private const LIBRARY_PATH = "./nappgui"

private func commandExists(name: String): Bool {
    let process = launch(
        CHECK_CMD,
        name,
        stdOut: ProcessRedirect.Discard,
        stdErr: ProcessRedirect.Discard
    )
    return process.wait() == 0
}

private func runCommand(cmd: String, args: Array<String>, cwd!: ?Path = None): Int64 {
    let process = launch(
        cmd,
        args,
        workingDirectory: cwd
    )
    return process.wait()
}

private func stagePreBuild(): Int64 {
    if (!commandExists("cmake")) {
        println("Error: 'cmake' not found. Please install CMake.")
        return 1
    }

    let generatorArgs = match {
        case IS_WINDOWS => match {
            case commandExists("ninja") => ["-G", "Ninja"]
            case commandExists("mingw32-make") => ["-G", "MinGW Makefiles"]
            case _ =>
                println("Error: Windows requires 'ninja' or 'mingw32-make' to build with Clang/GCC.")
                return 1
        }
        case _ => match {
            case commandExists("ninja") => ["-G", "Ninja"]
            case _ => Array<String>()
        }
    }

    let preset = match {
        case commandExists("clang") => "clang"
        case commandExists("gcc") => "gcc"
        case _ =>
            println("Error: Neither 'clang' nor 'gcc' found.")
            return 1
    }

    let configureArgs = generatorArgs.concat(["--preset", preset])
    let ret = runCommand("cmake", configureArgs, cwd: Path(LIBRARY_PATH))
    if (ret != 0) {
        return ret
    }
    return runCommand("cmake", ["--build", "--preset", preset], cwd: Path(LIBRARY_PATH))
}

main(args: Array<String>): Int64 {
    match (args[0]) {
        case "pre-build" => stagePreBuild()
        case _ => 0
    }
}
