//
//  Season.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import Foundation

enum Season: String, CaseIterable {

    case all = "사계절"
    case spring = "봄"
    case summer = "여름"
    case fall = "가을"
    case winter = "겨울"
    
    var index: Int {
        let seasons = Self.allCases
        guard let index = seasons.firstIndex(of: self) else { return 0 }
        return Int(index)
    }
}
