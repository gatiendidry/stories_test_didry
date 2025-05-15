//
//  FeedView.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import SwiftUI

struct FeedView: View {

    @ObservedObject var viewModel: FeedViewModel = FeedViewModel()

    var body: some View {
        ZStack {
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
                                            .onTapGesture{ viewModel.presentStory(user: user)}
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

            if viewModel.isStoriesFeedPresented,
               let storyPresented = viewModel.storyDisplayed,
                let userStoryDisplayed = viewModel.userStoryDisplayed {
                StoryView(
                    username: userStoryDisplayed.name,
                    story: storyPresented,
                    dismiss: viewModel.dismissStoryFeed,
                    updateStoryLikeStatus: viewModel.updateLikeStatus
                )
            }
        }
        .sensoryFeedback(.impact, trigger: viewModel.isStoriesFeedPresented)
        .onAppear {
            viewModel.fetchInitialsData()
        }

    }
}

#Preview {
    FeedView()
}


