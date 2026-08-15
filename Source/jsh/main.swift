/**
 * @file        main.swift
 * @brief      main function of jsh
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiDataKit
import Foundation
import _Concurrency

@MainActor
public func shellMain()
{
        let infile  = FileHandle.standardInput
        let outfile = FileHandle.standardOutput
        let errfile = FileHandle.standardError

        let interm  = infile.enableRawMode()
        let outterm = outfile.enableRawMode()
        let errterm = errfile.enableRawMode()

        let ext   = ShellExtension()
        let shell = KSShell(extension: ext)
        shell.standardInput  = infile
        shell.standardOutput = outfile
        shell.standardError  = errfile
        shell.run()
        shell.wait()

        infile.restoreRawMode(originalTerm: interm)
        outfile.restoreRawMode(originalTerm: outterm)
        errfile.restoreRawMode(originalTerm: errterm)
}

Task { @MainActor in
        shellMain()
}

// Keep the run loop alive until the task completes if necessary
// Since shellMain() is synchronous and blocking until shell.wait(), the Task will complete when done.
// For command-line tools, the process will stay alive while the Task runs.
RunLoop.current.run(mode: .default, before: Date(timeIntervalSinceNow: 0.01))
