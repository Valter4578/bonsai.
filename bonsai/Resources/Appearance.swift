//
//  Appearance.swift
//  bonsai
//
//  Created by hoang on 04.12.2021.
//

import Foundation
import SwiftUI

enum BonsaiFont {
    static let title_34 = Font.system(size: 34, weight: .bold)
    static let title_28 = Font.system(size: 28, weight: .bold)
    static let title_22 = Font.system(size: 22, weight: .bold)
    static let title_20 = Font.system(size: 20, weight: .bold)
    static let title_headline_17 = Font.system(size: 17, weight: .bold)
    static let body_17 = Font.system(size: 17)
    static let subtitle_15 = Font.system(size: 15, weight: .bold)
    static let body_15 = Font.system(size: 15)
    static let caption_12 = Font.system(size: 12)
    static let caption_11 = Font.system(size: 11)
}

enum BonsaiImage {
    static var calendar: Image { Image(systemName: "calendar") }
    static var category: Image { Image(systemName: "folder") }
    static var tag: Image { Image(systemName: "tag") }
    static var title: Image { Image(systemName: "text.bubble") }
    static var arrowUpCircle: Image { Image(systemName: "arrow.up.circle") }
    static var chevronForward: Image { Image(systemName: "chevron.forward") }
    static var chevronDown: Image { Image(systemName: "chevron.down") }
    static var chevronUp: Image { Image(systemName: "chevron.up") }
    static var textBubble: Image { Image(systemName: "text.bubble") }
    static var xMark: Image { Image(systemName: "xmark") }
    static var plus: Image { Image(systemName: "plus") }
    static var textformatAlt: Image { Image(systemName: "textformat.alt") }
    static var pencil: Image { Image(systemName: "pencil.circle.fill") }
    static var settings: Image { Image(systemName: "gearshape.circle.fill") }
    static var folder: Image { Image(systemName: "folder.fill") }
    static var star: Image { Image(systemName: "star.square") }
    static var light: Image { Image(systemName: "light.max") }
    static var star_leadinghal: Image { Image(systemName: "star.leadinghalf.filled") }
    static var star_fill: Image { Image(systemName: "star.fill") }
    static var trash: Image { Image(systemName: "trash") }
    static var unselect: Image { Image(systemName: "filemenu.and.selection") }
    static var hexagongrid: Image { Image(systemName: "circle.hexagongrid.circle.fill") }
    static var hexagongridFill: Image { Image(systemName: "circle.hexagongrid.fill") }
    static var creditcard: Image { Image(systemName: "creditcard.circle.fill") }
    static var creditcard123: Image { Image(systemName: "creditcard.and.123") }
    static var creditcardRectangle: Image { Image(systemName: "rectangle.on.rectangle.circle.fill") }
    static var info: Image { Image(systemName: "info.circle.fill") }

}

enum BonsaiColor {
    
    /*
     UIKit 1 column
     */
    static let mainPurple = Color(hex: 0x9791FE)
    static let purple2 = Color(hex: 0xA49FFE)
    static let purple3 = Color(hex: 0xB1ACFE)
    static let purple4 = Color(hex: 0xBEBAFE)
    static let purple5 = Color(hex: 0xCBC8FE)
    static let purple6 = Color(hex: 0xD8D6FF)
    
    /*
     UIKit 2 column
     */
    static let disabled = Color(hex: 0x4E4B76)
    static let green = Color(hex: 0x34CE8D)
    static let text = Color(hex: 0xE5E3FF)
    
    /*
     UIKit 3 column
     */
    static let card = Color(hex: 0x292838)
    static let blue = Color(hex: 0x34A0CE)
    static let blue_dark = Color(hex: 0x0052D4)
    static let pink = Color(hex: 0xC84E89)
    
    /*
     UIKit 4 column
     */
    static let back = Color(hex: 0x1D1C22)
    static let secondary = Color(hex: 0xF86D70)
    static let blueLight = Color(hex: 0x1FA2FF)
    static let orange = Color(hex: 0xFFE259)
    
    /*
     Not in UIKit
     */
    static let newPurple = Color(hex: 0x6C63FF)
    static let separator = Color(hex: 0x343150)
    static let prompt = Color(hex: 0x686599)
    
    /*
     Disables colors for charts
     */
    
    enum ChartDisabledColors {
        static let c1 = Color(hex: 0x232236)
        static let c2 = Color(hex: 0x2C2A42)
        static let c3 = Color(hex: 0x33324A)
        static let c4 = Color(hex: 0x1A1931)
        static let c5 = Color(hex: 0x0A091D)
        static let c6 = Color(hex: 0x131129)
        static let c7 = Color(hex: 0x504E65)
        static let c8 = Color(hex: 0x49485E)
        static let c9 = Color(hex: 0x474555)
        static let c10 = Color(hex: 0x394F6C)
        
        static var colors: [Color] {
            return [BonsaiColor.ChartDisabledColors.c1, BonsaiColor.ChartDisabledColors.c2, BonsaiColor.ChartDisabledColors.c3, BonsaiColor.ChartDisabledColors.c4, BonsaiColor.ChartDisabledColors.c5, BonsaiColor.ChartDisabledColors.c6, BonsaiColor.ChartDisabledColors.c7, BonsaiColor.ChartDisabledColors.c8, BonsaiColor.ChartDisabledColors.c9, BonsaiColor.ChartDisabledColors.c10]
        }
    }
}
