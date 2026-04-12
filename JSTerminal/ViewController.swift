/*
 * @file ViewController.swift
 * @description Define ViewController class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import ShellKit
import TerminalKit
import MultiDataKit
import MultiUIKit
import Cocoa

class ViewController: NSViewController
{
        @IBOutlet weak var mTerminalView: MITerminalView!

        private var mShell:                     KSShell? = nil
        private var mTerminalToShellPipe:       Pipe? = nil
        private var mShellToTerminalPipe:       Pipe? = nil
        private var mErrorPipe:                 Pipe? = nil

        override func viewDidLoad() {
                super.viewDidLoad()

                let terminalToShellPipe = Pipe()
                let shellToTerminalPipe = Pipe()
                let errorPipe           = Pipe()

                /* connect with terminal */
                mTerminalView.standardInput     = shellToTerminalPipe.fileHandleForReading
                mTerminalView.standardOutput    = terminalToShellPipe.fileHandleForWriting
                mTerminalView.standardError     = errorPipe.fileHandleForWriting

                /* allocate and execute shell */
                let shell = KSShell()
                shell.standardInput     = terminalToShellPipe.fileHandleForReading
                shell.standardOutput    = shellToTerminalPipe.fileHandleForWriting
                shell.standardError     = errorPipe.fileHandleForWriting
                shell.run()

                /* get standard error */
                errorPipe.fileHandleForReading.setReader(reader: {
                        (_ str: String) -> Void in
                        NSLog("[stderr] \(str)")
                })

                /* setup terminal */
                setupTerminal(envVariables: shell.envVariables)

                /* keep object */
                mShell                  = shell
                mTerminalToShellPipe    = terminalToShellPipe
                mShellToTerminalPipe    = shellToTerminalPipe
                mErrorPipe              = errorPipe
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }

        private func setupTerminal(envVariables envvars: MIEnvVariables) {
                if let col = envvars.color(forKey: .terminalForeground) {
                        let (_, nativecol) = col.toNativeColor()
                        mTerminalView.textColor = nativecol
                }
                if let col = envvars.color(forKey: .terminalBackground) {
                        let (_, nativecol) = col.toNativeColor()
                        mTerminalView.backgroundColor = nativecol
                }
        }
}

