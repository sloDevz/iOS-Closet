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
    case outer = "겉 옷"
    case top = "상의"
    case bottom = "하의"
    case footWaer = "신발"
    case accessory = "악세서리"
    
    var index: Int {
        var categories = Self.allCases
        categories.removeFirst()
        guard let index = categories.firstIndex(of: self) else { return 0 }
        return Int(index)
    }
}
