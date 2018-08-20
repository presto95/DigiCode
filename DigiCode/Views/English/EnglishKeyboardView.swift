//
//  DigiKeyboardView.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

class EnglishKeyboardView: UIView {

    weak var delegate: KeyboardViewDelegate?
    var colors: Colors!
    @IBOutlet weak var oneTwoThreeButton: KeyboardButton!
    @IBOutlet weak var globeButton: KeyboardButton!
    @IBOutlet weak var enterButton: KeyboardButton!
    @IBOutlet weak var dotButton: KeyboardButton!
    @IBOutlet weak var shiftButton: KeyboardButton!
    @IBOutlet weak var backspaceButton: KeyboardButton!
    @IBOutlet weak var spaceButton: KeyboardButton!
    @IBOutlet weak var firstLineStackView: UIStackView!
    @IBOutlet weak var secondLineStackView: UIStackView!
    @IBOutlet weak var thirdLineStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTargetToCharacterKeys()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addTargetToCharacterKeys()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTargetToCharacterKeys()
    }
    
    override func layoutSubviews() {
        setColorScheme(.light)
        setupKeys(.english)
    }
    
    ///문자 키들에 액션 추가하기
    private func addTargetToCharacterKeys() {
        let stackViews = [firstLineStackView, secondLineStackView, thirdLineStackView]
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
extension EnglishKeyboardView {
    @objc func touchUpCharacterKeys(_ sender: KeyboardButton) {
        delegate?.didTouchUpCharacterKey(sender.character ?? "")
    }
    @IBAction func touchUpBackspaceKey(_ sender: KeyboardButton) {
        delegate?.didTouchUpBackspaceKey()
    }
    @IBAction func touchUpSpaceKey(_ sender: KeyboardButton) {
        delegate?.didTouchUpSpaceKey()
    }
    @IBAction func touchUpShiftKey(_ sender: KeyboardButton) {
        delegate?.didTouchUpShiftKey(sender)
    }
    @IBAction func touchUpDotKey() {
        delegate?.didTouchUpDotKey()
    }
    @IBAction func touchUpGlobeKey() {
        delegate?.didTouchUpGlobeKey()
    }
    @IBAction func touchUpEnterKey() {
        delegate?.didTouchUpEnterKey()
    }
    @IBAction func touchUpOneTwoThreeKey() {
        delegate?.didTouchUpOneTwoThreeKey()
    }
}

//MARK:- 키보드 색 설정 관련
extension EnglishKeyboardView {
    private func setColorScheme(_ colorScheme: ColorType) {
        self.colors = Colors(colorScheme: colorScheme)
        self.backgroundColor = colors.keyboardBackgroundColor
        changeButtonColors(in: [firstLineStackView, secondLineStackView, thirdLineStackView])
        
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

//MARK:- 키보드 키 설정 관련
extension EnglishKeyboardView {
    ///키보드 언어에 따라 키에 표시되는 문자를 다르게 함
    private func setupKeys(_ language: KeyboardLanguage) {
        switch language {
        case .english:
            changeOneTwoThreeTitleToDigiCode()
            changeDotTitleToDigiCode()
            changeEnterTitleToDigiCode()
            changeGlobeTitleToDigiCode()
            changeShiftTitleToDigiCode()
            changeBackspaceTitleToDigiCode()
            changeSpaceTitleToDigiCode()
            changeCharacterKeysToDigiCode(in: [firstLineStackView, secondLineStackView, thirdLineStackView])
        case .japanese:
            break
        }
    }
    
    private func changeCharacterKeysToDigiCode(in stackViews: [UIStackView]) {
        for stackView in stackViews {
            for view in stackView.arrangedSubviews {
                guard let button = view as? KeyboardButton else { return }
                guard let title = button.title(for: []) else { return }
                button.setImage(UIImage(imageLiteralResourceName: "eng_dark_\(title)"), for: [])
                button.setTitle(nil, for: [])
            }
        }
    }
    
    private func changeOneTwoThreeTitleToDigiCode() {
        self.oneTwoThreeButton.setImage(#imageLiteral(resourceName: "dark_oneTwoThree"), for: [])
        self.oneTwoThreeButton.tintColor = colors.tintColor
    }
    
    private func changeEnterTitleToDigiCode() {
        self.enterButton.setImage(#imageLiteral(resourceName: "dark_enter"), for: [])
        self.enterButton.tintColor = colors.tintColor
    }
    
    private func changeDotTitleToDigiCode() {
        self.dotButton.setImage(#imageLiteral(resourceName: "dark_dot"), for: [])
        self.dotButton.tintColor = colors.tintColor
    }
    
    private func changeGlobeTitleToDigiCode() {
        self.globeButton.setImage(#imageLiteral(resourceName: "dark_globe"), for: [])
        self.globeButton.tintColor = colors.tintColor
    }
    
    private func changeShiftTitleToDigiCode() {
        self.shiftButton.setImage(#imageLiteral(resourceName: "dark_shift"), for: [])
        self.shiftButton.tintColor = colors.tintColor
    }
    
    private func changeBackspaceTitleToDigiCode() {
        self.backspaceButton.setImage(#imageLiteral(resourceName: "dark_backspace"), for: [])
        self.backspaceButton.tintColor = colors.tintColor
    }
    
    private func changeSpaceTitleToDigiCode() {
        let imageViews = [UIImageView(image: #imageLiteral(resourceName: "eng_dark_s")), UIImageView(image: #imageLiteral(resourceName: "eng_dark_p")), UIImageView(image: #imageLiteral(resourceName: "eng_dark_a")), UIImageView(image: #imageLiteral(resourceName: "eng_dark_c")), UIImageView(image: #imageLiteral(resourceName: "eng_dark_e"))]
        for imageView in imageViews {
            imageView.contentMode = .scaleAspectFit
        }
        let stackView = UIStackView(arrangedSubviews: imageViews)
        self.spaceButton.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: spaceButton.leftAnchor, constant: 8),
            stackView.topAnchor.constraint(equalTo: spaceButton.topAnchor, constant: 8),
            stackView.rightAnchor.constraint(equalTo: spaceButton.rightAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: spaceButton.bottomAnchor, constant: -8)
            ])
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
}

//MARK:- 키보드 키 입력 시 소리나게 하기
extension EnglishKeyboardView: UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}
