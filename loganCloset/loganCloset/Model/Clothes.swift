//
//  Clothes.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit

struct Clothes: Hashable {

    let itemID: UUID = UUID()
    let clothesOrderNumber: Int?
    let createdDate: Date?
    let clothesCategory: ClothesCategory
    let itemImage: UIImage?
    let mainColor: UIColor?
    let season: Season?
    let tags: [String]?
    let brandName: String?
    let meterial: String?

    var styleSetCategory: StyleSetCategory? {
        switch clothesCategory {
        case .none:
            return nil
        case .hat:
            return .head
        case .outer:
            return .body
        case .top:
            return .body
        case .bottom:
            return .bottom
        case .shoes:
            return .foot
        case .accessory:
            return .accessory
        }
    }

    init(
         clothesOrderNumber: Int? = nil,
         createdDate: Date? = nil,
         clothesCategory: ClothesCategory,
         itemImage: UIImage? = nil,
         mainColor: UIColor? = nil,
         season: Season? = nil,
         tags: [String]? = nil,
         brandName: String? = nil,
         meterial: String? = nil)
    {
        self.clothesOrderNumber = clothesOrderNumber
        self.createdDate = createdDate
        self.clothesCategory = clothesCategory
        self.itemImage = itemImage
        self.mainColor = mainColor
        self.season = season
        self.tags = tags
        self.brandName = brandName
        self.meterial = meterial
    }

}
