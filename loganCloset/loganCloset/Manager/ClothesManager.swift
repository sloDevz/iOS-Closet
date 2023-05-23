//
//  ClothesManager.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

final class ClothesManager {

    let closet: [Clothes]?
    let dummyCloset = [
        Clothes(clothesOrderNumber: 1, createdDate: Date(), clothesType: .hat, itemImage: UIImage(named: "Hats")!, mainColor: .green, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 2, createdDate: Date(), clothesType: .bottom, itemImage: UIImage(named: "Pants1")!, mainColor: .brown, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 3, createdDate: Date(), clothesType: .outer, itemImage: UIImage(named: "Outer")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 4, createdDate: Date(), clothesType: .bottom, itemImage: UIImage(named: "Pants2")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 5, createdDate: Date(), clothesType: .bottom, itemImage: UIImage(named: "Pants3")!, mainColor: .red, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 6, createdDate: Date(), clothesType: .top, itemImage: UIImage(named: "Shirts1")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 7, createdDate: Date(), clothesType: .hat, itemImage: UIImage(named: "Shirts2")!, mainColor: .blue, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 8, createdDate: Date(), clothesType: .shoes, itemImage: UIImage(named: "shoes")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 9, createdDate: Date(), clothesType: .bottom, itemImage: UIImage(named: "ShortPant")!, mainColor: .gray, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 10, createdDate: Date(), clothesType: .shoes, itemImage: UIImage(named: "Socks")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 11, createdDate: Date(), clothesType: .top, itemImage: UIImage(named: "TShirts1")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 12, createdDate: Date(), clothesType: .top, itemImage: UIImage(named: "TShirts2")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
    ]

    init(closet: [Clothes]? = nil) {
        self.closet = closet
    }

}
