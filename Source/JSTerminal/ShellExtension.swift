/**
 * @file        ext.swift
 * @brief      Define ShellExtension class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiUIKit
import Foundation

public class ShellExtension: KSShellExtension
{
        public override nonisolated init() {
        }

        public override nonisolated var doesSupportFileSelector: Bool {
                get { return true }
        }

        public override nonisolated func selectFile(title tstr: String, fileType file: KSShellExtension.FileType, extension estr: String) -> URL? {
                if let url = MIPanel.openPanel(title: tstr, type: .file, fileExtensions: [estr]) {
                        return url
                } else {
                        return nil
                }
        }
}
