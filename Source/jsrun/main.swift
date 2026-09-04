/**
 * @file        jsrun.swift
 * @brief      main function of jsrun
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import MultiDataKit
import JavaScriptKit
import JavaScriptCore
import Foundation

struct Argument {
        public var      scriptFile:     String

        public init(file fname: String){
                self.scriptFile = fname
        }
}

public func jsrun(arguments args: Array<String>) -> Bool
{
        /* parse arguments */
        let arg: Argument
        switch parseArguments(arguments: args) {
        case .success(let a):
                arg = a
        case .failure(let err):
                error(message: MIError.errorToString(error: err))
                return false
        }

        /* allocate context */
        switch allocateContext() {
        case .success(let contxt):
                execute(argument: arg, context: contxt)
        case .failure(let err):
                error(message: MIError.errorToString(error: err))
                return false
        }
        return true
}

private func parseArguments(arguments args: Array<String>) -> Result<Argument, NSError>
{
        if args.count > 0 {
                return .success(Argument(file: args[0]))
        } else {
                return .failure(MIError.fileError(message: "No script file name"))
        }
}

private func allocateContext() -> Result<KSContext, NSError> {
        guard let vm = JSVirtualMachine() else {
                return .failure(MIError.fileError(message: "Failed to allocate VM"))
        }
        let phdl = MIProcessFileHandle(input:  FileHandle.standardInput,
                                       output: FileHandle.standardOutput,
                                       error:  FileHandle.standardError)
        let env = MIEnvVariables(parent: nil)

        let lib = KSLibrary()
        switch lib.load(virtualMachine: vm, processFileHandle: phdl, environment: env) {
        case .success(let context):
                return .success(context)
        case .failure(let err):
                return .failure(err)
        }
}

private func execute(argument arg: Argument, context ctxt: KSContext)
{
        print("Hello, World!")
}

private func error(message msg: String) {
        FileHandle.standardError.write(string: "[Error]" + msg + "\n")
}

/* call main function */
if jsrun(arguments: CommandLine.arguments) {
        exit(0)
} else {
        exit(-1)
}

