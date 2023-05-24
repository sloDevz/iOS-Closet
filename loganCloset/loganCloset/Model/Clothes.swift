//
//  Clothes.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit

struct Clothes: Hashable {

    let clothesOrderNumber: Int?
    let createdDate: Date?
    let clothesCategory: ClothesCategory
    let itemImage: UIImage?
    let mainColor: UIColor?
    let season: Season?
    let tags: [String]?
    let identifier: UUID
    let brandName: String?
    let meterial: String?

    init(clothesOrderNumber: Int? = nil,
         createdDate: Date? = nil,
         clothesCategory: ClothesCategory,
         itemImage: UIImage? = nil,
         mainColor: UIColor? = nil,
         season: Season? = nil,
         tags: [String]? = nil,
         identifier: UUID = UUID(),
         brandName: String? = nil,
         meterial: String? = nil) {
        self.clothesOrderNumber = clothesOrderNumber
        self.createdDate = createdDate
        self.clothesCategory = clothesCategory
        self.itemImage = itemImage
        self.mainColor = mainColor
        self.season = season
        self.tags = tags
        self.identifier = identifier
        self.brandName = brandName
        self.meterial = meterial
    }

}
