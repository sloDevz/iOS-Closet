//
//  ClothesManager.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

final class ClothesManager {

    let closet: [Clothes]?
    let dummyCloset:[Clothes]? = [
        Clothes(clothesOrderNumber: 1, createdDate: Date(), clothesCategory: .hat, itemImage: UIImage(named: "Hats")!, mainColor: .green, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 2, createdDate: Date(), clothesCategory: .bottom, itemImage: UIImage(named: "Pants1")!, mainColor: .brown, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 3, createdDate: Date(), clothesCategory: .outer, itemImage: UIImage(named: "Outer")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 4, createdDate: Date(), clothesCategory: .bottom, itemImage: UIImage(named: "Pants2")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 5, createdDate: Date(), clothesCategory: .bottom, itemImage: UIImage(named: "Pants3")!, mainColor: .red, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 6, createdDate: Date(), clothesCategory: .top, itemImage: UIImage(named: "Shirts1")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 7, createdDate: Date(), clothesCategory: .top, itemImage: UIImage(named: "Shirts2")!, mainColor: .blue, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 8, createdDate: Date(), clothesCategory: .shoes, itemImage: UIImage(named: "shoes")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 9, createdDate: Date(), clothesCategory: .bottom, itemImage: UIImage(named: "ShortPant")!, mainColor: .gray, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 10, createdDate: Date(), clothesCategory: .shoes, itemImage: UIImage(named: "Socks")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 11, createdDate: Date(), clothesCategory: .top, itemImage: UIImage(named: "TShirts1")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
        Clothes(clothesOrderNumber: 12, createdDate: Date(), clothesCategory: .top, itemImage: UIImage(named: "TShirts2")!, mainColor: .white, season: .all, tags: .none, brandName: nil, meterial: nil),
    ]

    lazy var dummyStyleSets: [StyleSet] = [
        StyleSet(
            name: "데이트 코디",
            items: [
                dummyCloset![0],
                dummyCloset![2],
                dummyCloset![10],
                dummyCloset![4],
                dummyCloset![9],
                dummyCloset![7]
            ],
            genDate: Date()),
        StyleSet(
            name: "물놀이 갈 때 입을 옷",
            items: [
                dummyCloset![11],
                dummyCloset![1],
                dummyCloset![9]
            ],
            genDate: Date()),
        StyleSet(
            name: "헬스장 코디",
            items: [
                dummyCloset![5],
                dummyCloset![3],
                dummyCloset![7]
            ],
            genDate: Date()),
        StyleSet(
            name: "필승 면접박살 코디",
            items: [
                dummyCloset![9]
            ],
            genDate: Date())
    ]

    init(closet: [Clothes]? = nil) {
        self.closet = closet
    }

}
