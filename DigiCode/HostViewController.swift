//
//  ViewController.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

class HostViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let colors = Colors(colorScheme: .light)
    var keyboardView: EnglishKeyboardView!
    var codeStackView: UIStackView!
    var isShifted: Bool {
        return keyboardView.shiftButton.isSelected
    }
    var language: KeyboardLanguage {
        if segmentedControl.selectedSegmentIndex == 0 {
            return .english
        } else {
            return .japanese
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiateKeyboardView()
        makeKeyboardViewAsInputView()
        let accessoryView = makePreview()
        makePreviewStackView()
        attachStackView(self.codeStackView, to: accessoryView)
        makePreviewAsInputViewAccessoryView(accessoryView)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViews), name: .UIApplicationWillEnterForeground, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
}

//MARK:- IBActions
extension HostViewController {
    @IBAction func selectSegmentedControl(_ sender: UISegmentedControl) {
        //키보드 언어 바꾸기
        let count = keyboardView.secondLineStackView.arrangedSubviews.count
        let index = sender.selectedSegmentIndex
        guard let stackView = keyboardView.secondLineStackView else { return }
        if index == 0 && count == 10 {
            guard let firstOfFirstStackView = keyboardView.firstLineStackView.arrangedSubviews.first else { return }
            guard let lastOfFirstStackView = keyboardView.firstLineStackView.arrangedSubviews.last else { return }
            stackView.arrangedSubviews.last?.removeFromSuperview()
            stackView.removeConstraints(stackView.constraints)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: keyboardView.firstLineStackView.bottomAnchor, constant: 16),
                stackView.heightAnchor.constraint(equalTo: keyboardView.firstLineStackView.heightAnchor),
                stackView.leadingAnchor.constraint(equalTo: firstOfFirstStackView.centerXAnchor),
                stackView.trailingAnchor.constraint(equalTo: lastOfFirstStackView.centerXAnchor)
                ])
        } else if index == 1 && count == 9 {
            let button = KeyboardButton(type: .system)
            button.character = "-"
            button.setImage(#imageLiteral(resourceName: "jpn_dark_dash"), for: [])
            button.addTarget(self, action: #selector(touchUpDashButton), for: [.touchUpInside, .touchUpOutside])
            stackView.addArrangedSubview(button)
            stackView.removeConstraints(stackView.constraints)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: keyboardView.firstLineStackView.bottomAnchor, constant: 16),
                stackView.heightAnchor.constraint(equalTo: keyboardView.firstLineStackView.heightAnchor),
                stackView.leadingAnchor.constraint(equalTo: keyboardView.leadingAnchor, constant: 4),
                stackView.trailingAnchor.constraint(equalTo: keyboardView.trailingAnchor, constant: -4)
                ])
        }
    }
    @objc private func touchUpDashButton() {
        UIDevice.current.playInputClick()
        self.textField.insertText("-")
    }
}

//MARK:- Observers
extension HostViewController {
    @objc func reloadViews() {
        self.textField.becomeFirstResponder()
    }
}

//MARK:- 키보드 키 입력 델리게이트
extension HostViewController: KeyboardViewDelegate {
    func didTouchUpCharacterKey(_ newCharacter: String) {
        UIDevice.current.playInputClick()
        if isShifted {
            self.textField.insertText(newCharacter.uppercased())
            self.keyboardView.shiftButton.isSelected = !isShifted
        } else {
            self.textField.insertText(newCharacter)
        }
        let image = UIImage(imageLiteralResourceName: "eng_dark_\(newCharacter)")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.codeStackView.addArrangedSubview(imageView)
    }
    func didTouchUpBackspaceKey() {
        UIDevice.current.playInputClick()
        self.textField.deleteBackward()
        guard let lastSubview = self.codeStackView.arrangedSubviews.last else { return }
        lastSubview.removeFromSuperview()
    }
    func didTouchUpSpaceKey() {
        UIDevice.current.playInputClick()
        self.textField.insertText(" ")
        for view in self.codeStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    func didTouchUpShiftKey(_ sender: KeyboardButton) {
        UIDevice.current.playInputClick()
        sender.isSelected = !sender.isSelected
    }
    func didTouchUpDotKey() {
        UIDevice.current.playInputClick()
        self.textField.insertText(".")
    }
    func didTouchUpGlobeKey() {
        UIDevice.current.playInputClick()
    }
    func didTouchUpEnterKey() {
        UIDevice.current.playInputClick()
    }
    func didTouchUpOneTwoThreeKey() {
        UIDevice.current.playInputClick()
    }
    func characterBeforeCursor() -> String? {
        return nil
    }
}

//MARK:- private methods
private extension HostViewController {
    func instantiateKeyboardView() {
        guard let keyboardView = UINib(nibName: "EnglishKeyboardView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? EnglishKeyboardView else { return }
        keyboardView.delegate = self
        self.keyboardView = keyboardView
    }
    func makeKeyboardViewAsInputView() {
        self.textField.inputView = self.keyboardView
    }
    func makePreview() -> UIToolbar {
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        accessoryView.backgroundColor = colors.accessoryBackgroundColor
        return accessoryView
    }
    func makePreviewStackView() {
        self.codeStackView = UIStackView(frame: .zero)
        self.codeStackView.backgroundColor = colors.accessoryPreviewBackgroundColor
        self.codeStackView.spacing = 2
    }
    func attachStackView(_ stackView: UIStackView, to accessoryView: UIToolbar) {
        accessoryView.addSubview(stackView)
        self.codeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            codeStackView.leftAnchor.constraint(greaterThanOrEqualTo: accessoryView.leftAnchor, constant: 16),
            codeStackView.topAnchor.constraint(equalTo: accessoryView.topAnchor, constant: 8),
            codeStackView.rightAnchor.constraint(lessThanOrEqualTo: accessoryView.rightAnchor, constant: -16),
            codeStackView.bottomAnchor.constraint(equalTo: accessoryView.bottomAnchor, constant: -8),
            codeStackView.centerXAnchor.constraint(equalTo: accessoryView.centerXAnchor)
            ])
        codeStackView.distribution = .fillEqually
        
    }
    func makePreviewAsInputViewAccessoryView(_ accessoryView: UIToolbar) {
        self.textField.inputAccessoryView = accessoryView
    }
}

