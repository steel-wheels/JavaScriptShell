/*
 * @file PreferenceWindowController.swift
 * @description Define PreferenceWindowController class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import Cocoa
import Foundation

class PreferenceWindowController: NSWindowController
{
    convenience init() {
        let vc = PreferenceViewController()

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 640, height: 480),
            styleMask: [.titled, .closable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        window.title = "Preferences"
        window.contentViewController = vc

        self.init(window: window)
    }
}

