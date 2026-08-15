/**
 * @file        ext.swift
 * @brief      Define ShellExtension class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import ShellKit
import MultiUIKit
import Foundation

@MainActor
public class ShellExtension: KSShellExtension
{
        public override init() {
        }

        public override var doesSupportFileSelector: Bool {
                get { return true }
        }

        public override func selectFile(title tstr: String, fileType file: KSShellExtension.FileType, extension estr: String) -> URL? {
                if let url = MIPanel.openPanel(title: tstr, type: .file, fileExtensions: [estr]) {
                        return url
                } else {
                        return nil
                }
        }
}
