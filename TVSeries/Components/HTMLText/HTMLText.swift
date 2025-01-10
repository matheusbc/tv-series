//
//  HTMLText.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI

struct HTMLText: View {
    @Environment(\.colorScheme) var colorScheme
    @State var htmlString: String
    @State var font: Font?

    var text: AttributedString? {
        let htmlType = NSAttributedString.DocumentType.html
        if let nsAttributedString = try? NSAttributedString(data: Data(htmlString.utf8),
                                                            options: [.documentType: htmlType],
                                                            documentAttributes: nil),
           var attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            attributedString.font = font
            attributedString.foregroundColor = colorScheme == .dark ? .white : .black
            return attributedString
        }
        return nil
    }

    var body: some View {
        if let attributedString = self.text {
            Text(attributedString)
        } else {
            Text(htmlString)
                .font(font)
        }
    }
}
