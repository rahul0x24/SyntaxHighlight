//
//  Text+Init.swift
//  SyntaxHighlight
//
//  Created by Makoto Aoyama on 2020/09/21.
//  Copyright © 2020 dev.aoyama. All rights reserved.
//

import Foundation
import SwiftUI
import DynamicColor

extension Text {
    init(from highlighter: Highlighter) {
        guard let styleds = try? highlighter.styledStrings() else {
            self.init(verbatim: highlighter.string)
            return
        }
        self.init(verbatim:"")
        for styled in styleds {
            var text = Text(verbatim: styled.0)
            if let foreground = styled.1?.foreground {
                let color = SwiftUI.Color(foreground)
                text = text.foregroundColor(color)
            }
            if styled.1?.fontStyle.contains(.bold) ?? false {
                text = text.bold()
            }
            if styled.1?.fontStyle.contains(.italic) ?? false {
                text = text.italic()
            }
            if styled.1?.fontStyle.contains(.underline) ?? false {
                text = text.underline()
            }
            self = self + text
        }
    }
}


extension SwiftUI.Color {
    public init?(_ color: SyntaxHighlight.Color) {
        self.init(hexString: color.hex)
    }
}
