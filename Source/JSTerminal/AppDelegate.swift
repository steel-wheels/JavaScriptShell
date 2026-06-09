//
//  AppDelegate.swift
//  JSTerminal
//
//  Created by Tomoo Hamada on 2026/06/05.
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
                let pctrl = preferenceWindowController()
                pctrl.showWindow(self)
                NSApp.activate(ignoringOtherApps: true)
        }

        private func preferenceWindowController() -> PreferenceWindowController {
                if let ctrl = mPreferenceWindowController {
                        return ctrl
                } else {
                        let ctrl = PreferenceWindowController()
                        mPreferenceWindowController = ctrl
                        return ctrl
                }
        }
}

