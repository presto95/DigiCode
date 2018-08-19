//
//  ViewController.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var digiKeyboardView: DigiKeyboardView!
    var digiCodeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //키보드 커스텀 인풋 뷰에 추가
        guard let keyboardView = UINib(nibName: "DigiKeyboardView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? DigiKeyboardView else { return }
        keyboardView.delegate = self
        self.textField.inputView = keyboardView
        //커스텀 인풋 뷰에 악세사리 뷰, 스택 뷰 추가
        let colorScheme = DigiColors(colorScheme: .light)
        let accessoryView = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        accessoryView.backgroundColor = colorScheme.accessoryBackgroundColor
        self.digiCodeStackView = UIStackView(frame: .zero)
        self.digiCodeStackView.backgroundColor = colorScheme.accessoryPreviewBackgroundColor
        self.digiCodeStackView.spacing = 4
        accessoryView.addSubview(self.digiCodeStackView)
        self.digiCodeStackView.translatesAutoresizingMaskIntoConstraints = false
        self.digiCodeStackView.centerXAnchor.constraint(equalTo: accessoryView.centerXAnchor).isActive = true
        self.digiCodeStackView.centerYAnchor.constraint(equalTo: accessoryView.centerYAnchor).isActive = true
        self.digiCodeStackView.heightAnchor.constraint(equalToConstant: 20)
        self.textField.inputAccessoryView = accessoryView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
}

extension ViewController: DigiKeyboardViewDelegate {    
    func didTouchUpCharacterKey(_ newCharacter: String) {
        self.textField.insertText(newCharacter)
        let image = UIImage(imageLiteralResourceName: "dark\(newCharacter.uppercased())")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        self.digiCodeStackView.addArrangedSubview(imageView)
    }
    
    func didTouchUpBackspaceKey() {
        self.textField.deleteBackward()
        guard let lastSubview = self.digiCodeStackView.arrangedSubviews.last else { return }
        lastSubview.removeFromSuperview()
    }
    
    func didTouchUpSpaceKey() {
        self.textField.insertText(" ")
        for view in self.digiCodeStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
    func characterBeforeCursor() -> String? {
        return nil
    }
}

