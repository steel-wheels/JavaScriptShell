//
//  AppDelegate.swift
//  JSTerminal
//
//  Created by Tomoo Hamada on 2026/04/04.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate
{
        private var mPreferenceWindowController: PreferenceWindowController? = nil

        func applicationDidFinishLaunching(_ aNotification: Notification) {
                // Insert code here to initialize your application
        }

        func applicationWillTerminate(_ aNotification: Notification) {
                // Insert code here to tear down your application
        }

        func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
                return true
        }

        @IBAction func openPreference(_ sender: Any) {
                NSLog("openPreference")
                if mPreferenceWindowController == nil {
                        mPreferenceWindowController = PreferenceWindowController()
                }
                if let winctrl = mPreferenceWindowController {
                        winctrl.showWindow(self)
                        NSApp.activate(ignoringOtherApps: true)
                }
        }
}

