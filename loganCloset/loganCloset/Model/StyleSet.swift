//
//  StyleSet.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

struct StyleSet: Hashable {

    let identifier: UUID
    let name: String
    let items: [Clothes]

    init(
        from: StyleSet? = nil,
        name: String,
        items: [Clothes]
    )
    {
        if let from {
            self.identifier = from.identifier
        } else {
            identifier = UUID()
        }
        self.name = name
        self.items = items
    }

    func StyleSetItem(of parts: ClothesCategory) -> [Clothes] {
        let styleItem = items.filter { item in
            item.clothesCategory == parts
        }
        return styleItem
    }
}
