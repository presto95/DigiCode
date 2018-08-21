//
//  NumbersKeyboardView.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 19..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

class NumberKeyboardView: UIView {

    weak var delegate: KeyboardViewDelegate?
    var colors: Colors!
    @IBOutlet weak var firstStackView: UIStackView!
    @IBOutlet weak var secondStackView: UIStackView!
    @IBOutlet weak var thirdStackView: UIStackView!
    @IBOutlet weak var symbolButton: KeyboardButton!
    @IBOutlet weak var backspaceButton: KeyboardButton!
    @IBOutlet weak var enterButton: KeyboardButton!
    @IBOutlet weak var dotButton: KeyboardButton!
    @IBOutlet weak var mainButton: KeyboardButton!
    @IBOutlet weak var globeButton: KeyboardButton!
    @IBOutlet weak var spaceButton: KeyboardButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTargetToCharacterKey()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTargetToCharacterKey()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTargetToCharacterKey()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setColorScheme(.light)
    }
    
    private func addTargetToCharacterKey() {
        let stackViews = [firstStackView, secondStackView, thirdStackView]
        for stackView in stackViews {
            guard let stackView = stackView else { return }
            for view in stackView.arrangedSubviews {
                guard let button = view as? KeyboardButton else { return }
                button.addTarget(self, action: #selector(touchUpCharacterKeys(_:)), for: [.touchUpInside, .touchUpOutside])
            }
        }
    }
}

//MARK:- 키보드 키 클릭 액션 관련
extension NumberKeyboardView {
    @objc func touchUpCharacterKeys(_ sender: KeyboardButton) {
        delegate?.didTouchUpCharacterKey(sender.character ?? "")
    }
    @IBAction func touchUpBackspaceKey() {
        delegate?.didTouchUpBackspaceKey()
    }
    @IBAction func touchUpSpaceKey() {
        delegate?.didTouchUpSpaceKey()
    }
    @IBAction func touchUpSymbolKey(_ sender: KeyboardButton) {
        delegate?.didTouchUpSymbolKey()
    }
    @IBAction func touchUpDotKey() {
        delegate?.didTouchUpDotKey()
    }
    @IBAction func touchUpGlobeKey() {
        delegate?.didTouchUpGlobeKey()
    }
    @IBAction func toucUpEnterKey() {
        delegate?.didTouchUpEnterKey()
    }
    @IBAction func touchUpKeyboardChangeKey() {
        delegate?.didTouchUpKeyboardChangeKey()
    }
}

//MARK:- 키보드 색 설정 관련
extension NumberKeyboardView {
    private func setColorScheme(_ colorScheme: ColorType) {
        self.colors = Colors(colorScheme: colorScheme)
        self.backgroundColor = colors.keyboardBackgroundColor
        changeButtonColors(in: [firstStackView, secondStackView, thirdStackView])
        
    }
    
    private func changeButtonColors(in stackViews: [UIStackView]) {
        for stackView in stackViews {
            for view in stackView.arrangedSubviews {
                guard let button = view as? KeyboardButton else { return }
                button.backgroundColor = colors.buttonBackgroundColor
                button.hightlightBackgroundColor = colors.buttonHighlightColor
                button.tintColor = colors.tintColor
            }
        }
    }
}

//MARK:- 키보드 키 입력 시 소리나게 하기
extension NumberKeyboardView: UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}
