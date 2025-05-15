//
//  ContentViewModel.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import Foundation
import Combine

final class FeedViewModel: ObservableObject {

    private let networkService: NetworkService = NetworkService()

    @Published var users: [User] = []

    @Published var stories: [Story] = []

    @Published var isStoriesFeedPresented: Bool = false
    var storyDisplayed: Story?
    var userStoryDisplayed: User?

    private var cancellables = Set<AnyCancellable>()

    func fetchInitialsData() {
        fetchUsers()
        fetchStories()
    }

    private func fetchUsers() {
        networkService
            .fetchUsersPages()
            .map { $0.pages.flatMap { $0.users } }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }

    private func fetchStories() {
        networkService
            .fetchUsersStories()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    ()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: {[weak self] stories in
                print(stories)
                self?.stories = stories
            }
            .store(in: &cancellables)
    }

    func getStoryIfExist(user: User) -> [Story] {
        return self.stories.filter { $0.userId == user.id }
    }

    func presentStory(user: User) {
        isStoriesFeedPresented = true
        storyDisplayed = stories.filter {$0.userId == user.id }.first
        userStoryDisplayed = user
    }

    func dismissStoryFeed() {
        isStoriesFeedPresented = false
    }

    func updateLikeStatus(likeStatus: Bool) {
        if let storyDisplayed {
            stories[storyDisplayed.id].isLiked = likeStatus
        }
    }

}
