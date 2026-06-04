/*
 * @file PreferenceViewController.swift
 * @description Define PreferenceViewController class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import MultiUIKit
import AppKit

public class PreferenceViewController: NSViewController
{
        private weak var mRootView: MIStack? = nil

        public override func loadView() {
                let stack = MIStack()
                stack.wantsLayer = true
                stack.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor
                mRootView = stack

                self.view = stack
        }

        public override func viewDidLoad() {
                super.viewDidLoad()
                // allocate contents
        }
}
