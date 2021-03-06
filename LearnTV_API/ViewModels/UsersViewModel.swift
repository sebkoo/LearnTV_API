//
//  UserViewModel.swift
//  LearnTV_API
//
//  Created by Sebastian Koo on 2/10/21.
//

import Foundation

class UsersViewModel {
    typealias completionBlock = ([User]?, Error?) -> ()
    var apiHandler = APIhandler()
    var dataSource = [User]()
    
    func getPostsFromAPIhandler (postsURL: String, completionBlock: @escaping completionBlock) {
        apiHandler.getPostsFromAPI(withURL: postsURL) { [weak self] (users, err) in
            self?.dataSource = users!
            completionBlock(users!, nil)
        }
    }
    
    func getNumberOfRowsInSection() -> Int {
        return dataSource.count
    }
    
    func getUserAtIndex (index: Int) -> User {
        let user = dataSource[index]
        return user
    }
    
    func getUserCellData (index: Int) -> String {
        let user = self.getUserAtIndex(index: index)
        let userId = user.userId ?? 0
        let id = user.id ?? 0
//        let body = user.body ?? ""
        let title = user.title ?? ""
        return "UserId- \(userId) ID- \(id) Title- \(title)"
    }
    
    func getUserCellDetail (index: Int) -> String {
        let user = self.getUserAtIndex(index: index)
        let body = user.body ?? ""
        return "Body- \(body)"
    }
}
