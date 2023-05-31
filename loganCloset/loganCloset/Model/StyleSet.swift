//
//  StyleSet.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

struct StyleSet: Hashable {

    let name: String
    let items: [Clothes]
    let genDate: Date
    let identifier = UUID()
    let backgroundImage: UIImage? = nil

    func StyleSetItem(of parts: StyleSetCategory) -> [Clothes]? {
        let styleItems = items.filter { item in
            item.styleSetCategory == parts
        }
        guard !styleItems.isEmpty else { return nil }

        return styleItems
    }
}
