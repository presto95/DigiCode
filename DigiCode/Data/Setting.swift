//
//  Setting.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 19..
//  Copyright © 2018년 presto. All rights reserved.
//

enum KeyboardType {
    case english
    case japanese
    case numbers
    case symbols
}

class Setting {
    static let shared = Setting()
    var currentKeyboard: KeyboardType = .english
}
