//
//  String+.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 11/30/23.
//

import Foundation

extension String {
    
    func transformIntoTag() -> [String]? {
        let unSpacedText = self.replacingOccurrences(of: " ", with: "")
        let separatedText = unSpacedText.components(separatedBy: "#")
        if !separatedText.isEmpty {
            let tags = separatedText.map { "#" + $0 }
            return tags
        } else {
            return nil
        }
    }




}
