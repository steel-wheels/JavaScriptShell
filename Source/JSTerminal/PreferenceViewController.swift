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
                let rootview = MIStack()
                rootview.axis = .vertical
                mRootView = rootview

                self.view = rootview
        }

        private var rootView: MIStack { get {
                if let root = mRootView {
                        return root
                } else {
                        fatalError("root view must be allocated")
                }
        }}

        public override func viewDidLoad() {
                super.viewDidLoad()
                allocateContents(rootVoew: self.rootView)
        }

        private func allocateContents(rootVoew root: MIStack) {
                root.addArrangedSubView(self.allocateHomeDirectorySelector())
        }

        private func allocateHomeDirectorySelector() -> MIStack {
                if let _ = currentViewController() {
                        NSLog("has view controller")
                }

                let stack = MIStack()
                stack.axis = .horizontal

                let button = MIButton()
                button.title = "Set Home Directory"
                button.isEnabled = true
                stack.addArrangedSubView(button)

                return stack
        }

        private func currentViewController() -> ViewController? {
                guard let doc = NSDocumentController.shared.currentDocument else {
                        return nil
                }
                let vconts = doc.windowControllers
                guard vconts.count > 0 else {
                        return nil
                }
                if let vcont = vconts[0].contentViewController as? ViewController {
                        return vcont
                } else {
                        return nil
                }
        }
}

