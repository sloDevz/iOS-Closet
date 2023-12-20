//
//  StyleSet.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/22.
//

import UIKit

struct StyleSet: Hashable {

    let identifier = UUID()
    let name: String //필요
    let items: [Clothes] //UUID만 필요

    func StyleSetItem(of parts: StyleSetCategory) -> [Clothes]? {
        let styleItems = items.filter { item in
            item.styleSetCategory == parts
        }
        guard !styleItems.isEmpty else { return nil }

        return styleItems
    }
}
