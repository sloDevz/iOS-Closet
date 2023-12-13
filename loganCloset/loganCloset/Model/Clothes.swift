//
//  Clothes.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit

struct Clothes: Hashable {

    let itemID: UUID
    let createdDate: Date

    let itemImage: UIImage
    let clothesCategory: ClothesCategory
    let season: Season
    let mainColor: MainColor?
    let tags: [String]?
    let brandName: String?
    let material: Material?

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
        case .footWaer:
            return .footWaer
        case .accessory:
            return .accessory
        }
    }

    init(
        from item: Clothes? = nil,
        itemImage: UIImage,
        clothesCategory: ClothesCategory,
        season: Season,
        mainColor: MainColor? = nil,
        tags: [String]? = nil,
        brandName: String? = nil,
        material: Material? = nil
    )
    {
        if let item {
            self.itemID = item.itemID
            self.createdDate = item.createdDate
            self.itemImage = itemImage
            self.clothesCategory = clothesCategory
            self.season = season
            self.mainColor = mainColor
            self.tags = tags
            self.brandName = brandName
            self.material = material
        } else {
            self.itemID = UUID()
            self.createdDate = Date()
            self.itemImage = itemImage
            self.clothesCategory = clothesCategory
            self.season = season
            self.mainColor = mainColor
            self.tags = tags
            self.brandName = brandName
            self.material = material
        }
    }
}
