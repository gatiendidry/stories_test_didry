//
//  NetworkService.swift
//  stories_test_didry
//
//  Created by Gatien DIDRY on 15/05/2025.
//

import Foundation
import Combine

class NetworkService {

    let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

   func fetchUsersPages() -> some Publisher<UsersPages, Error> {
       let url = URL(string: "https://file.notion.so/f/f/217d0d1c-7a97-42dd-91c5-2c6314c29174/56226368-cb1a-4572-a037-655366fc8071/users.json?table=block&id=1a0a0b48-1db4-8072-82db-c5aceda9f98d&spaceId=217d0d1c-7a97-42dd-91c5-2c6314c29174&expirationTimestamp=1747316312287&signature=ehgfdZa5GR4fhjEXBwYoy9sMSf78nK0aZ0_Kq0Rlhmo&downloadName=users.json")!

       return URLSession
           .shared
           .dataTaskPublisher(for: url)
           .map(\.data)
           .decode(type: UsersPages.self, decoder: jsonDecoder)
   }

    func fetchUsersStories() -> some Publisher<[Story], Error> {
        let url = Bundle.main.url(forResource: "stories_datasource", withExtension: "json")!

        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Story].self, decoder: jsonDecoder)
    }


}
