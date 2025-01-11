//
//  ListLoadingErrorView.swift
//  TVSeries
//
//  Created by Matheus Campos on 10/01/25.
//
import SwiftUI

struct ListLoadingErrorView: View {
    var retryAction: (() async -> Void)?

    var body: some View {
        VStack {
            Text("Something went wrong")
                .padding(.bottom, 6)
            if let retryAction {
                Button("Retry") {
                    Task {
                        await retryAction()
                    }
                }
            }
        }
    }
}

#Preview {
    ListLoadingErrorView {
        print("Test")
    }
}
