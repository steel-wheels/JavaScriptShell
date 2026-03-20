/**
 * @file        main.swift
 * @brief      main function of jsh
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiDataKit
import Foundation

public func shellMain() {
        let fileif = MIFileInterface(input:  FileHandle.standardInput,
                                     output: FileHandle.standardOutput,
                                     error:  FileHandle.standardError)
        let shell = KSShell(fileInterface: fileif)
        shell.main()
}

shellMain()


