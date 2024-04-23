//
//  StringProtocol+Extension.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import Foundation

extension StringProtocol {
    func htmlToAttributedString() throws -> AttributedString {
        try .init(
            .init(
                data: .init(utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        )
    }
}
