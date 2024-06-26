//
//  ErrorView.swift
//  SwifUI_MVVM_Sample
//
//  Created by Tùng on 23/04/2024.
//

import SwiftUI

enum ErrorType {
    case decoding
    case noInternet
    case backend(Int)
}

struct ErrorView: View {
    let error: ErrorType
    
    var body: some View {
        VStack {
            Text("Something went wrong")
                .font(.title)
                .padding()
            Group {
                switch error {
                case .decoding:
                    Text("Please contact developer")
                case .noInternet:
                    Text("Please check your internet connection")
                case .backend(let code):
                    switch code {
                    case 403:
                        Text("Github API limit reached, wait a second")
                    case 503:
                        Text("Service unavailable")
                    default:
                        Text("Server error code: \(code)")
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ErrorView(error: .noInternet)
}
