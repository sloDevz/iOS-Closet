//
//  UIFont+.swift
//  loganCloset
//
//  Created by DONGWOOK SEO on 2023/05/21.
//

import UIKit

extension UIFont {

    enum ImportedFont {
        case pretendardRegular
        case pretendardThin
        case pretendardExtraLight
        case pretendardLight
        case pretendardMedium
        case pretendardSemiBold
        case pretendardBold
        case pretendardExtraBold
        case pretendardBlack
    }

    private enum FontStyleName {
        static let pretendardRegular = "Pretendard-Regular"
        static let pretendardThin = "Pretendard-Thin"
        static let pretendardExtraLight = "Pretendard-ExtraLight"
        static let pretendardLight = "Pretendard-Light"
        static let pretendardMedium = "Pretendard-Medium"
        static let pretendardSemiBold = "Pretendard-SemiBold"
        static let pretendardBold = "Pretendard-Bold"
        static let pretendardExtraBold = "Pretendard-ExtraBold"
        static let pretendardBlack = "Pretendard-Black"
    }

    static func importedUIFont(name: ImportedFont, fontSize: CGFloat) -> UIFont {
        let defaultFont = Self.systemFont(ofSize: fontSize)

        switch name {
        case .pretendardRegular:
            guard let font = UIFont(name: FontStyleName.pretendardRegular, size: fontSize) else { return defaultFont }
            return font
        case .pretendardThin:
            guard let font = UIFont(name: FontStyleName.pretendardThin, size: fontSize) else { return defaultFont }
            return font
        case .pretendardExtraLight:
            guard let font = UIFont(name: FontStyleName.pretendardExtraLight, size: fontSize) else { return defaultFont }
            return font
        case .pretendardLight:
            guard let font = UIFont(name: FontStyleName.pretendardLight, size: fontSize) else { return defaultFont }
            return font
        case .pretendardMedium:
            guard let font = UIFont(name: FontStyleName.pretendardMedium, size: fontSize) else { return defaultFont }
            return font
        case .pretendardSemiBold:
            guard let font = UIFont(name: FontStyleName.pretendardSemiBold  , size: fontSize) else { return defaultFont }
            return font
        case .pretendardBold:
            guard let font = UIFont(name: FontStyleName.pretendardBold, size: fontSize) else { return defaultFont }
            return font
        case .pretendardExtraBold:
            guard let font = UIFont(name: FontStyleName.pretendardExtraBold, size: fontSize) else { return defaultFont }
            return font
        case .pretendardBlack:
            guard let font = UIFont(name: FontStyleName.pretendardBlack, size: fontSize) else { return defaultFont }
            return font
        }
    }
    
}
