//
//  Text+Extension.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import SwiftUI

extension Text {
    init(html: String, alert: String? = nil) {
        do {
            try self.init(html.htmlToAttributedString())
        } catch {
            self.init(alert ?? error.localizedDescription)
        }
    }
}
