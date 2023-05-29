//
//  ClothesManager.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

final class ClothesManager {

    var closet: [Clothes] = []
    private let dummyCloset:[Clothes] = [
        Clothes(itemImage: UIImage(named: "Hats")!, clothesCategory: .hat, season: .all, mainColor: nil, tags: ["hello"], brandName: "Nike", meterial: nil),
        Clothes(itemImage: UIImage(named: "Pants1")!, clothesCategory: .bottom, season: .all, mainColor: .brown, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "Outer")!, clothesCategory: .outer, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "Pants2")!, clothesCategory: .bottom, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "Pants3")!, clothesCategory: .bottom, season: .all, mainColor: .red, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "Shirts1")!, clothesCategory: .top, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "Shirts2")!, clothesCategory: .top, season: .all, mainColor: .blue, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage:  UIImage(named: "shoes")!, clothesCategory: .footWaer, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "ShortPant")!, clothesCategory: .bottom, season: .all, mainColor: .gray, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "Socks")!, clothesCategory: .footWaer, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "TShirts1")!, clothesCategory: .top, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil),
        Clothes(itemImage: UIImage(named: "TShirts2")!, clothesCategory: .top, season: .all, mainColor: .white, tags: nil, brandName: nil, meterial: nil)
    ]

    lazy var dummyStyleSets: [StyleSet] = [
        StyleSet(
            name: "데이트 코디",
            items: [
                dummyCloset[0],
                dummyCloset[2],
                dummyCloset[10],
                dummyCloset[4],
                dummyCloset[7]
            ],
            genDate: Date()),
        StyleSet(
            name: "물놀이 갈 때 입을 옷",
            items: [
                dummyCloset[11],
                dummyCloset[1],
                dummyCloset[9]
            ],
            genDate: Date()),
        StyleSet(
            name: "헬스장 코디",
            items: [
                dummyCloset[5],
                dummyCloset[3],
                dummyCloset[7]
            ],
            genDate: Date()),
        StyleSet(
            name: "필승 면접박살 코디",
            items: [
                dummyCloset[9]
            ],
            genDate: Date())
    ]

    init() {
        self.closet = closet + dummyCloset
    }

}
