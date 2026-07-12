/**
 * @file        ext.swift
 * @brief      Define ShellExtension class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import Foundation

public class ShellExtension: KSShellExtension
{
        public override nonisolated init() {
        }

        public override nonisolated var doesSupportFileSelector: Bool {
                get { false }
        }
}
