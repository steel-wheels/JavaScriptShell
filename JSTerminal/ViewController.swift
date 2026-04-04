/*
 * @file ViewController.swift
 * @description Define ViewController class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import ShellKit
import TerminalKit
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
}

