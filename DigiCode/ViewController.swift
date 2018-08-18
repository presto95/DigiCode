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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let keyboardView = UINib(nibName: "DigiKeyboardView", bundle: nil).instantiate(withOwner: nil, options: nil).first as? DigiKeyboardView else { return }
        keyboardView.delegate = self
        self.textField.inputView = keyboardView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField.becomeFirstResponder()
    }
    
}

extension ViewController: DigiKeyboardViewDelegate {    
    func didTouchUpCharacterButton(_ newCharacter: String) {
        self.textField.insertText(newCharacter)
    }
    
    func didTouchUpBackspaceButton() {
        self.textField.deleteBackward()
    }
    
    func characterBeforeCursor() -> String? {
        return nil
    }
}

