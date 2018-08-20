//
//  KeyboardButton.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

class KeyboardButton: UIButton {

    var defaultBackgroundColor: UIColor = .white
    var hightlightBackgroundColor: UIColor = .lightGray
    var character: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = isHighlighted ? hightlightBackgroundColor : defaultBackgroundColor
    }
}

extension KeyboardButton {
    private func setup() {
        self.character = self.title(for: []) ?? ""
        self.imageView?.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0.35
        self.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
}
