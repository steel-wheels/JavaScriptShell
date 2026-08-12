/*
 * @file PreferenceViewController.swift
 * @description Define PreferenceViewController class
 * @par Copyright
 *   Copyright (C) 2026 Steel Wheels Project
 */

import MultiUIKit
import MultiDataKit
import AppKit

public class PreferenceViewController: NSViewController
{
        private weak var mRootView: MIStack? = nil

        private var mHomeDirectoryField: MITextField?   = nil

        public override func loadView() {
                let rootview = MIStack()
                let size     = NSSize(width: 640, height: 480)
                rootview.axis = .vertical
                rootview.frame.size  = size
                rootview.bounds.size = size
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
                updateContents()
        }

        private func allocateContents(rootVoew root: MIStack) {
                root.addArrangedSubView(self.allocateHomeDirectorySelector())
        }

        private func allocateHomeDirectorySelector() -> MIStack {
                let stack = MIStack()
                stack.axis = .horizontal

                let field = MITextField()
                field.isEditable = false
                stack.addArrangedSubView(field)
                mHomeDirectoryField = field

                let button = MIButton()
                button.title = "Set Home Directory"
                button.isEnabled = true
                stack.addArrangedSubView(button)

                return stack
        }

        private func updateContents() {
                guard let curview = self.currentViewController() else {
                        NSLog("[Error] No view controller")
                        return
                }
                guard let curenv = curview.environment else {
                        NSLog("[Error] No environment variable")
                        return
                }
                updateHomeDirectorySelector(environment: curenv)
        }

        private func updateHomeDirectorySelector(environment env: MIEnvVariables) {
                if let field = mHomeDirectoryField, let curdir = env.currentDirectory {
                        field.stringValue = curdir.path
                } else {
                        NSLog("[Error] No home directory field")
                }
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

