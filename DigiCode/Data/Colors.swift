//
//  DigiColors.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 18..
//  Copyright © 2018년 presto. All rights reserved.
//

import UIKit

enum ColorType {
    case light
    case dark
}

struct Colors {
    let buttonBackgroundColor: UIColor
    let buttonHighlightColor: UIColor
    let keyboardBackgroundColor: UIColor
    let accessoryBackgroundColor: UIColor
    let accessoryPreviewBackgroundColor: UIColor
    let tintColor: UIColor
    
    init(colorScheme: ColorType) {
        switch colorScheme {
        case .light:
            buttonBackgroundColor = .white
            buttonHighlightColor = #colorLiteral(red: 0.6823529412, green: 0.7019607843, blue: 0.7450980392, alpha: 1)
            keyboardBackgroundColor = #colorLiteral(red: 0.8235294118, green: 0.8352941176, blue: 0.8588235294, alpha: 1)
            accessoryBackgroundColor = #colorLiteral(red: 0.7294117647, green: 0.7490196078, blue: 1, alpha: 1)
            accessoryPreviewBackgroundColor = #colorLiteral(red: 0.4929447974, green: 0.5363932676, blue: 1, alpha: 1)
            tintColor = .black
        case .dark:
            buttonBackgroundColor = UIColor(white: 138/255, alpha: 1)
            buttonHighlightColor = UIColor(white: 104/255, alpha: 1)
            keyboardBackgroundColor = UIColor(white: 89/255, alpha: 1)
            accessoryBackgroundColor = UIColor(white: 80/255, alpha: 1)
            accessoryPreviewBackgroundColor = UIColor(white: 80/255, alpha: 0.5)
            tintColor = .white
        }
    }
}
