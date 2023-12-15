//
//  ClothesType.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import Foundation

enum ClothesCategory: String, CaseIterable {

    case none
    case hat = "모자"
    case outer = "아우터"
    case top = "상의"
    case bottom = "하의"
    case footWaer = "신발"
    case accessory = "악세서리"

    var index: Int? {
        var categories = Self.allCases
        categories.removeFirst()
        guard let index = categories.firstIndex(of: self) else { return nil }
        return Int(index)
    }

    static var categories: [Self] {
        var categories = Self.allCases
        let index = Self.none.index ?? 0
        categories.remove(at: index)
        return categories
    }
}
