//
//  Clothes.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit

struct Clothes {

    enum ClothesType {
        case hat
        case top
        case bottom
        case shoes
        case accessory
    }

    enum Season {
        case all
        case spring
        case summer
        case fall
        case winter
    }

    let clothesOrderNumber: Int
    let registedDate: Date
    let clothesType: ClothesType
    let itemImage: UIImage
    let mainColor: UIColor?
    let season: Season?

    let brandName: String?
    let meterial: String?
}
