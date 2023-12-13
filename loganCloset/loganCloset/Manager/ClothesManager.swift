//
//  ClothesManager.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

final class ClothesManager {

    // MARK: - Constants

    // MARK: - Properties
    private var closet: [ClothesCategory:[Clothes]] = [:]
    private var styleSets: [StyleSet] = []

    // MARK: - LifeCycle
    init() {
        self.appendDummyData()
        self.styleSets = styleSets + dummyStyleSets
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func fetchAllCloset() -> [ClothesCategory:[Clothes]] {
        return closet
    }

    func fetchCloset(of category: ClothesCategory) -> [Clothes]? {
        return closet[category]
    }

    func fetchStyleSets() -> [StyleSet] {
        return styleSets
    }

    func addStyleSet(styleSet: StyleSet?) {
        guard let styleSet else { return }
        styleSets.append(styleSet)
    }

    func addClothes(clothes: Clothes?) {
        guard let clothes else { return }
        let category = clothes.clothesCategory
        if closet[category] != nil {
            closet[category]?.append(clothes)
        } else {
            closet[category] = [clothes]
        }
    }

    func fetchLatestItem() -> Clothes? {
        let items = fetchOrderedItems()
        return items.last
    }

    func fetchLatestStyleSet() -> StyleSet? {
        return styleSets.last
    }

    // MARK: - Private
    private func appendDummyData() {
        dummyCloset.forEach { item in
            addClothes(clothes: item)
        }
    }

    private func fetchOrderedItems() -> [Clothes] {
        let itemGroups = fetchAllCloset().values
        var items = itemGroups.flatMap{ $0 }
        items.sort { rhs, lhs in
            rhs.createdDate < lhs.createdDate
        }
        return items
    }

    // MARK: - MockData
    private let dummyCloset:[Clothes] = [
        Clothes(itemImage: UIImage(named: "Hats")!, clothesCategory: .hat, season: .all, mainColor: .green, tags: ["#greenFav."], brandName: "Nike", material: nil),
        Clothes(itemImage: UIImage(named: "Pants1")!, clothesCategory: .bottom, season: .all, mainColor: .brown, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Outer")!, clothesCategory: .outer, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Pants2")!, clothesCategory: .bottom, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Pants3")!, clothesCategory: .bottom, season: .all, mainColor: .red, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Shirts2")!, clothesCategory: .top, season: .all, mainColor: .blue, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Shirts1")!, clothesCategory: .top, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "shoes")!, clothesCategory: .footWaer, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "ShortPant")!, clothesCategory: .bottom, season: .all, mainColor: .gray, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Socks")!, clothesCategory: .footWaer, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "TShirts1")!, clothesCategory: .top, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "TShirts2")!, clothesCategory: .top, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "backPack1")!, clothesCategory: .accessory, season: .all, mainColor: .white, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Belt")!, clothesCategory: .accessory, season: .all, mainColor: .black, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "clutch1")!, clothesCategory: .accessory, season: .all, mainColor: .black, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "clutch2")!, clothesCategory: .accessory, season: .all, mainColor: .red, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "clutch3")!, clothesCategory: .accessory, season: .all, mainColor: .brown, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "earring")!, clothesCategory: .accessory, season: .all, mainColor: .gold, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Hats2")!, clothesCategory: .hat, season: .all, mainColor: .brown, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Hats3")!, clothesCategory: .hat, season: .all, mainColor: .black, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "Hats4")!, clothesCategory: .hat, season: .all, mainColor: .black, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "neckglass")!, clothesCategory: .accessory, season: .all, mainColor: .gold, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "sunglasses1")!, clothesCategory: .accessory, season: .all, mainColor: .black, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "sunglasses2")!, clothesCategory: .accessory, season: .all, mainColor: .yellow, tags: nil, brandName: nil, material: nil),
        Clothes(itemImage: UIImage(named: "sunglasses3")!, clothesCategory: .accessory, season: .all, mainColor: .brown, tags: nil, brandName: nil, material: nil),
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

}
