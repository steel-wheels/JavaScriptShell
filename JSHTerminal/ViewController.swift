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

        private var mShellThread:               ShellThread? = nil
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
                let env   = MIEnvVariables(parent: nil)
                let shell = ShellThread(environment: env)
                shell.standardInput     = terminalToShellPipe.fileHandleForReading
                shell.standardOutput    = shellToTerminalPipe.fileHandleForWriting
                shell.standardError     = errorPipe.fileHandleForWriting
                shell.start()

                /* get standard error */
                errorPipe.fileHandleForReading.setReader(reader: {
                        (_ str: String) -> Void in
                        NSLog("[stderr] \(str)")
                })

                /* setup terminal */
                setupTerminal(preference: shell.preference)

                /* keep object */
                mShellThread                  = shell
                mTerminalToShellPipe    = terminalToShellPipe
                mShellToTerminalPipe    = shellToTerminalPipe
                mErrorPipe              = errorPipe
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }

        private func setupTerminal(preference pref: KSPreference) {
                let (_, fgcolor) = pref.foregroundColor.toNativeColor()
                mTerminalView.textColor = fgcolor

                let (_, bgcolor) = pref.backgroundColor.toNativeColor()
                mTerminalView.backgroundColor = bgcolor
        }
}

