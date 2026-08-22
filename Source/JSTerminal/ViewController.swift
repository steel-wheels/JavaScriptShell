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
                setupTerminal(environment: shell.environment)

                /* keep object */
                mShellThread            = shell
                mPseudoTerminal         = pseudoterm
                mErrorPipe              = errorPipe
        }

        public var preference: KSPreference? { get {
                return mShellThread?.preference
        }}

        public var environment: MIEnvVariables? { get {
                return mShellThread?.environment
        }}

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }

        private func setupTerminal(environment env: MIEnvVariables) {
                if let fgcol = env.foregroundColor {
                        mTerminalView.textColor = fgcol.toNativeColor()
                }
                if let bgcol = env.backgroundColor {
                        mTerminalView.backgroundColor = bgcol.toNativeColor()
                }
        }
}


