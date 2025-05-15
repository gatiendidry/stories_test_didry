//
//  ContentView.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: ContentViewModel = ContentViewModel()

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.users, id: \.id) { user in
                        VStack {
                            if let url = URL(string: user.profilePictureUrl) {

                                AsyncImage(url: url) { content in
                                    content
                                        .resizable()
                                        .frame(width: 90, height: 90)
                                        .clipShape(Circle())
                                        .overlay {

                                            if  !viewModel.getStoryIfExist(user: user).isEmpty {
                                                Circle()
                                                    .stroke(Color.blue, lineWidth: 4)
                                            }



                                        }
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100)
                                }
                            }

                            Text(user.name)
                                .font(.system(size: 10))
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)

            Spacer()
        }
        .onAppear {
            viewModel.fetchInitialsData()
        }

    }
}

#Preview {
    ContentView()
}
