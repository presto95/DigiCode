//
//  DigiKeyboardView.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

protocol DigiKeyboardViewDelegate: class {
    func didTouchUpCharacterButton(_ newCharacter: String)
    func didTouchUpBackspaceButton()
    func characterBeforeCursor() -> String?
}

class DigiKeyboardView: UIView {

    weak var delegate: DigiKeyboardViewDelegate?
    @IBOutlet weak var nextKeyboardButton: DigiKeyboardButton!
    @IBOutlet weak var backspaceButton: DigiKeyboardButton!
    @IBOutlet weak var firstLineStackView: UIStackView!
    @IBOutlet weak var secondLineStackView: UIStackView!
    @IBOutlet weak var thirdLineStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        setColorScheme(.light)
        setupKeys(.english)
    }
}

//MARK:- 키보드 키 클릭 액션 관련
extension DigiKeyboardView {
    @IBAction func touchUpCharacterKeys(_ sender: DigiKeyboardButton) {
        delegate?.didTouchUpCharacterButton(sender.character ?? "")
    }
    @IBAction func touchUpBackspaceKey(_ sender: DigiKeyboardButton) {
        delegate?.didTouchUpBackspaceButton()
    }
}

//MARK:- 키보드 색 설정 관련
extension DigiKeyboardView {
    private func setColorScheme(_ colorScheme: DigiColorScheme) {
        let colorScheme = DigiColors(colorScheme: colorScheme)
        self.backgroundColor = colorScheme.keyboardBackgroundColor
        changeButtonColors(in: [firstLineStackView, secondLineStackView, thirdLineStackView], to: colorScheme)
        
    }
    
    private func changeButtonColors(in stackViews: [UIStackView], to colorScheme: DigiColors) {
        for stackView in stackViews {
            for view in stackView.arrangedSubviews {
                guard let button = view as? DigiKeyboardButton else { return }
                button.backgroundColor = colorScheme.buttonBackgroundColor
                button.hightlightBackgroundColor = colorScheme.buttonHighlightColor
                button.tintColor = colorScheme.tintColor
            }
        }
    }
}

//MARK:- 키보드 키 설정 관련
extension DigiKeyboardView {
    ///키보드 언어에 따라 키에 표시되는 문자를 다르게 함
    private func setupKeys(_ language: DigiKeyboardInputLanguage) {
        switch language {
        case .english:
            changeButtonTitleToDigiCode(in: [firstLineStackView, secondLineStackView, thirdLineStackView])
        case .japanese:
            break
        }
    }
    
    private func changeButtonTitleToDigiCode(in stackViews: [UIStackView]) {
        for stackView in stackViews {
            for view in stackView.arrangedSubviews {
                guard let button = view as? DigiKeyboardButton else { return }
                guard let title = button.title(for: []) else { return }
                button.setImage(UIImage(imageLiteralResourceName: "dark\(title.uppercased())"), for: [])
                button.setTitle(nil, for: [])
            }
        }
    }
}
