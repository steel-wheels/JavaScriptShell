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
        private let mShell: KSShell = KSShell()

        nonisolated public override init(environment env: MIEnvVariables) {
                super.init(environment: env)
        }

        public var preference: KSPreference { get {
                return mShell.preference
        }}

        public override func main() {
                NSLog("ShellThread: run")
                mShell.standardInput    = self.standardInput
                mShell.standardOutput   = self.standardOutput
                mShell.standardError    = self.standardError

                mShell.run()
                mShell.wait()
        }
}
