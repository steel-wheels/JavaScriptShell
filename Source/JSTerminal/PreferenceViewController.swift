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
                button.setButtonPressedCallback({
                        () -> Void in self.selectHomeDirectory()
                })
                stack.addArrangedSubView(button)

                return stack
        }

        private func selectHomeDirectory() {
                guard let viewctrl = self.currentViewController() else {
                        NSLog("[Error] no view controller")
                        return
                }
                if let dir = MIPanel.openPanel(title: "Select Home Directory", type: .directory, fileExtensions: []) {
                        if let env = self.currentEnvVariables(viewController: viewctrl) {
                                env.home = dir
                                updateHomeDirectorySelector(environment: env)
                        }
                }
        }

        private func updateContents() {
                guard let viewctrl = self.currentViewController() else {
                        NSLog("[Error] no view controller")
                        return
                }
                if let curenv = currentEnvVariables(viewController: viewctrl) {
                        updateHomeDirectorySelector(environment: curenv)
                }
        }

        private func updateHomeDirectorySelector(environment env: MIEnvVariables) {
                if let field = mHomeDirectoryField, let curdir = env.home {
                        field.stringValue = curdir.path
                } else {
                        NSLog("[Error] No home directory field")
                }
        }

        private func currentEnvVariables(viewController curview: ViewController) -> MIEnvVariables? {
                guard let curenv = curview.environment else {
                        NSLog("[Error] No environment variable")
                        return nil
                }
                return curenv
        }

        private func currentViewController() -> ViewController? {
                guard let doc = NSDocument.frontDocument else {
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

