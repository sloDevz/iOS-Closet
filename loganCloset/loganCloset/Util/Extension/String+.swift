//
//  String+.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 11/30/23.
//

import Foundation

extension String {

    func transformIntoTag() -> [String]? {
        guard !self.isEmpty else { return nil }
        let separatedText = self.components(separatedBy: "#")
        guard !separatedText.isEmpty else { return nil }
        let trimedTags = separatedText.map { text in
            let spacelessText = text.replacingOccurrences(of: " ", with: "")
            return "#" + spacelessText
        }.filter { $0.count > 1 }
        guard !trimedTags.isEmpty else { return nil }
        let tags = Array(Set(trimedTags))
        return tags
    }




}
