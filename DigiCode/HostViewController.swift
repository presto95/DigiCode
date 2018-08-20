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
    var digiKeyboardView: EnglishKeyboardView!
    var digiCodeStackView: UIStackView!
    var isShifted: Bool {
        return digiKeyboardView.shiftButton.isSelected
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
        attachStackView(self.digiCodeStackView, to: accessoryView)
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
            self.digiKeyboardView.shiftButton.isSelected = !isShifted
        } else {
            self.textField.insertText(newCharacter)
        }
        let image = UIImage(imageLiteralResourceName: "eng_dark_\(newCharacter)")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.digiCodeStackView.addArrangedSubview(imageView)
    }
    func didTouchUpBackspaceKey() {
        UIDevice.current.playInputClick()
        self.textField.deleteBackward()
        guard let lastSubview = self.digiCodeStackView.arrangedSubviews.last else { return }
        lastSubview.removeFromSuperview()
    }
    func didTouchUpSpaceKey() {
        UIDevice.current.playInputClick()
        self.textField.insertText(" ")
        for view in self.digiCodeStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    func didTouchUpShiftKey(_ sender: KeyboardButton) {
        UIDevice.current.playInputClick()
        sender.isSelected = !sender.isSelected
//        if sender.isSelected {
//            sender.backgroundColor = #colorLiteral(red: 0.6823529412, green: 0.7019607843, blue: 0.7450980392, alpha: 1)
//        } else {
//            sender.backgroundColor = .white
//        }
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
        self.digiKeyboardView = keyboardView
    }
    func makeKeyboardViewAsInputView() {
        self.textField.inputView = self.digiKeyboardView
    }
    func makePreview() -> UIToolbar {
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        accessoryView.backgroundColor = colors.accessoryBackgroundColor
        return accessoryView
    }
    func makePreviewStackView() {
        self.digiCodeStackView = UIStackView(frame: .zero)
        self.digiCodeStackView.backgroundColor = colors.accessoryPreviewBackgroundColor
        self.digiCodeStackView.spacing = 2
    }
    func attachStackView(_ stackView: UIStackView, to accessoryView: UIToolbar) {
        accessoryView.addSubview(stackView)
        self.digiCodeStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            digiCodeStackView.leftAnchor.constraint(greaterThanOrEqualTo: accessoryView.leftAnchor, constant: 16),
            digiCodeStackView.topAnchor.constraint(equalTo: accessoryView.topAnchor, constant: 8),
            digiCodeStackView.rightAnchor.constraint(lessThanOrEqualTo: accessoryView.rightAnchor, constant: -16),
            digiCodeStackView.bottomAnchor.constraint(equalTo: accessoryView.bottomAnchor, constant: -8),
            digiCodeStackView.centerXAnchor.constraint(equalTo: accessoryView.centerXAnchor)
            ])
        digiCodeStackView.distribution = .fillEqually
        
    }
    func makePreviewAsInputViewAccessoryView(_ accessoryView: UIToolbar) {
        self.textField.inputAccessoryView = accessoryView
    }
}

