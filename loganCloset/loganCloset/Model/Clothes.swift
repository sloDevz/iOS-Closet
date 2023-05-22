//
//  Clothes.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/18.
//

import UIKit

struct Clothes: Hashable {

    let clothesOrderNumber: Int
    let createdDate: Date
    let clothesType: ClothesCategory
    let itemImage: UIImage
    let mainColor: UIColor?
    let season: Season?
    let tags: [String]?

    let brandName: String?
    let meterial: String?

}
