//
//  Clothes.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit

struct Clothes: Hashable {

    let itemID: UUID = UUID()
    let createdDate: Date = Date()

    let itemImage: UIImage
    let clothesCategory: ClothesCategory
    let season: Season
    let mainColor: MainColor?
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
        case .footWaer:
            return .footWaer
        case .accessory:
            return .accessory
        }
    }

    init(
        itemImage: UIImage,
        clothesCategory: ClothesCategory,
        season: Season,
        mainColor: MainColor? = nil,
        tags: [String]? = nil,
        brandName: String? = nil,
        meterial: String? = nil)
    {
        self.itemImage = itemImage
        self.clothesCategory = clothesCategory
        self.season = season
        self.mainColor = mainColor
        self.tags = tags
        self.brandName = brandName
        self.meterial = meterial
    }


}

extension Clothes: Sequence {

    typealias Iterator = AnyIterator<Any>

    func makeIterator() -> AnyIterator<Any> {

        var index = 0

        return AnyIterator {
            defer { index += 1 }

            switch index {
            case 0:
                return itemID
            case 1:
                return createdDate
            case 2:
                return itemImage
            case 3:
                return clothesCategory
            case 4:
                return season
            case 5:
                return Optional(mainColor)
            case 6:
                return Optional(tags)
            case 7:
                return Optional(brandName)
            case 8:
                return Optional(meterial)
            default:
                return nil
            }
        }
    }

}
