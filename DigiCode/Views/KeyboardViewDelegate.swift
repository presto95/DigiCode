//
//  KeyboardViewDelegate.swift
//  DigiCode
//
//  Created by Presto on 2018. 8. 19..
//  Copyright © 2018년 presto. All rights reserved.
//

protocol KeyboardViewDelegate: class {
    ///문자, 숫자 등 키 입력시 수행할 동작 정의
    func didTouchUpCharacterKey(_ newCharacter: String)
    ///백스페이스 키 입력 시 수행할 동작 정의
    func didTouchUpBackspaceKey()
    ///스페이스 키 입력 시 수행할 동작 정의
    func didTouchUpSpaceKey()
    ///쉬프트 키 입력 시 수행할 동작 정의
    func didTouchUpShiftKey(_ sender: KeyboardButton)
    ///숫자 -> 심볼 전환 키 입력 시 수행할 동작 정의
    func didTouchUpSymbolKey()
    ///마침표 키 입력 시 수행할 동작 정의
    func didTouchUpDotKey()
    ///지구본 키 입력 시 수행할 동작 정의
    func didTouchUpGlobeKey()
    ///엔터 키 입력 시 수행할 동작 정의
    func didTouchUpEnterKey()
    ///키보드 타입 전환 키 입력 시 수행할 동작 정의
    func didTouchUpKeyboardChangeKey()
    ///커서 이전의 문자 가져오기
    func characterBeforeCursor() -> String?
}
