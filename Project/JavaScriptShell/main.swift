/**
 * @file        main.swift
 * @brief      main function of jsh
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiDataKit
import Foundation

public func shellMain()
{
        let infile  = FileHandle.standardInput
        let outfile = FileHandle.standardOutput
        let errfile = FileHandle.standardError

        let interm  = infile.enableRawMode()
        let outterm = outfile.enableRawMode()
        let errterm = errfile.enableRawMode()

        let shell = KSShell(input: infile, output: outfile, error: errfile)
        shell.main()

        infile.restoreRawMode(originalTerm: interm)
        outfile.restoreRawMode(originalTerm: outterm)
        errfile.restoreRawMode(originalTerm: errterm)
}

shellMain()


