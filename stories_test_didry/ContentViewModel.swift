//
//  ContentViewModel.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {

    private let networkService: NetworkService = NetworkService()

    @Published var users: [User] = []

    private var cancellables = Set<AnyCancellable>()

    func fetchUsers() {
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
}
