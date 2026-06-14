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
        private var mPseudoTerminal:            MIPseudoTerminal? = nil
        private var mErrorPipe:                 Pipe? = nil

        override func viewDidLoad() {
                super.viewDidLoad()

                let pseudoterm  = MIPseudoTerminal()
                let errorPipe   = Pipe()

                /* connect with terminal */
                mTerminalView.standardInput     = pseudoterm.masterFile
                mTerminalView.standardOutput    = pseudoterm.masterFile
                mTerminalView.standardError     = errorPipe.fileHandleForWriting

                /* allocate and execute shell */
                let shell = ShellThread()
                shell.standardInput             = pseudoterm.slaveFile
                shell.standardOutput            = pseudoterm.slaveFile
                shell.standardError             = errorPipe.fileHandleForWriting
                shell.start()

                /* get standard error */
                errorPipe.fileHandleForReading.setReader(reader: {
                        (_ str: String) -> Void in
                        NSLog("[stderr] \(str)")
                })

                /* setup terminal */
                setupTerminal(preference: shell.preference)

                /* keep object */
                mShellThread            = shell
                mPseudoTerminal         = pseudoterm
                mErrorPipe              = errorPipe
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }

        private func setupTerminal(preference pref: KSPreference) {
                let fgcolor = pref.foregroundColor.toNativeColor()
                mTerminalView.textColor = fgcolor

                let bgcolor = pref.backgroundColor.toNativeColor()
                mTerminalView.backgroundColor = bgcolor
        }
}


