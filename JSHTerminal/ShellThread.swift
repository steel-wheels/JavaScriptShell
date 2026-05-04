/*
 * @file ShellThread.swift
 * @description Define ShellThread class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiDataKit
import Foundation

public class ShellThread: MIThread
{
        private let mShell: KSShell

        public nonisolated override init() {
                mShell = KSShell()
                super.init()
        }

        public var preference: KSPreference { get {
                return mShell.preference
        }}

        public override func main() {
                mShell.standardInput    = self.standardInput
                mShell.standardOutput   = self.standardOutput
                mShell.standardError    = self.standardError

                self.environment = mShell.environment

                mShell.run()
                mShell.wait()
        }
}

