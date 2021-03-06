//
//  KeyboardViewController.swift
//  DigiKeyboard
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var keyboardParentView: UIView!
    var colors: Colors!
    var mainKeyboardView: MainKeyboardView {
        return keyboardParentView as! MainKeyboardView
    }
    var numberKeyboardView: NumberKeyboardView {
        return keyboardParentView as! NumberKeyboardView
    }
    var symbolKeyboardView: SymbolKeyboardView {
        return keyboardParentView as! SymbolKeyboardView
    }
    var digiCodeStackView: UIStackView!
    
//    override var inputAccessoryView: UIView? {
//        get {
//            return self.inputAccessoryView
//        }
//        set {
//            self.inputAccessoryView = newValue
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colors = Colors(colorScheme: .light)
        
        guard let keyboardView = UINib(nibName: "MainKeyboardView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? MainKeyboardView else { return }
        keyboardView.delegate = self
        keyboardView.globeButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        guard let inputView = inputView else { return }
        inputView.addSubview(keyboardView)
        keyboardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            keyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            keyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            keyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            keyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
            ])
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        toolBar.backgroundColor = colors.accessoryBackgroundColor
        self.digiCodeStackView = UIStackView(arrangedSubviews: [])
        self.digiCodeStackView.backgroundColor = colors.accessoryPreviewBackgroundColor
        self.digiCodeStackView.spacing = 2
        toolBar.addSubview(digiCodeStackView)
        self.digiCodeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            digiCodeStackView.leftAnchor.constraint(greaterThanOrEqualTo: toolBar.leftAnchor, constant: 16),
            digiCodeStackView.topAnchor.constraint(equalTo: toolBar.topAnchor, constant: 8),
            digiCodeStackView.rightAnchor.constraint(lessThanOrEqualTo: toolBar.rightAnchor, constant: -16),
            digiCodeStackView.bottomAnchor.constraint(equalTo: toolBar.bottomAnchor, constant: -8),
            digiCodeStackView.centerXAnchor.constraint(equalTo: toolBar.centerXAnchor)
            ])
        digiCodeStackView.distribution = .fillEqually
//        self.inputAccessoryView = toolBar
        
        self.keyboardParentView = keyboardView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: .UIKeyboardDidShow, object: nil)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        let colorScheme: ColorType
        if textDocumentProxy.keyboardAppearance == .dark {
            colorScheme = .dark
        } else {
            colorScheme = .light
        }
        switch Setting.shared.currentKeyboard {
        case .english:
            break
        case .japanese:
            break
        case .numbers:
            break
        case .symbols:
            break
        }
    }
    
    @objc func keyboardDidShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardHeight = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return }
        print(keyboardHeight.height)
    }
}

extension KeyboardViewController: KeyboardViewDelegate {
    func didTouchUpSymbolKey() {
        
    }
    func didTouchUpCharacterKey(_ newCharacter: String) {
        textDocumentProxy.insertText(newCharacter)
    }
    
    func didTouchUpBackspaceKey() {
        textDocumentProxy.deleteBackward()
    }
    
    func didTouchUpSpaceKey() {
        textDocumentProxy.insertText(" ")
    }
    
    func didTouchUpShiftKey(_ sender: KeyboardButton) {
        sender.isSelected = !sender.isSelected
    }
    
    func didTouchUpDotKey() {
        textDocumentProxy.insertText(".")
    }
    
    func didTouchUpGlobeKey() {
        
    }
    
    func didTouchUpEnterKey() {
        self.dismissKeyboard()
    }
    
    func didTouchUpKeyboardChangeKey() {
        
    }
    
    func characterBeforeCursor() -> String? {
        return nil
    }
}
