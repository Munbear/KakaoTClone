//
//  category.swift
//  KakaoTClone
//
//  Created by 박도원 on 9/18/24.
//

import Foundation

enum Categories: String, CaseIterable, Identifiable {
    case all = "전체"
    case rightHere = "지금여기"
    case tip = "꿀팁"
    case hotPlace = "맛집"
    case accident = "사고/교통"
    
    var id: String { self.rawValue }
}
