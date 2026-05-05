/*
 * @file ShellThread.swift
 * @description Define ShellThread class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiDataKit
import Foundation

public class ShellThread: Thread
{
        public var mShell = KSShell()

        public var preference: KSPreference {
                get       { return mShell.preference    }
        }

        public var standardInput: FileHandle {
                get      { return mShell.standardInput  }
                set(hdl) { mShell.standardInput = hdl   }
        }

        public var standardOutput: FileHandle {
                get      { return mShell.standardOutput  }
                set(hdl) { mShell.standardOutput = hdl   }
        }

        public var standardError: FileHandle {
                get      { return mShell.standardError  }
                set(hdl) { mShell.standardError = hdl   }
        }

        public override func main() {
                mShell.run()
                mShell.wait()
        }
}
